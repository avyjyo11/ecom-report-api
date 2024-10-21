package middleware

import (
	"log"
	"net/http"
	"sync"
	"time"
)

var (
	requestsMap = make(map[string]int)
	mu          sync.Mutex
)

const (
	limit     = 10                 // 10 requests
	window    = time.Minute         // per 1 minute
	blockTime = time.Minute * 2     // Block for 2 minutes after exceeding the limit
)

type client struct {
	lastRequest time.Time
	blockUntil  time.Time
}

// Request Limiter middleware to limit requests based on IP address
func ReqLimit(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ip := r.RemoteAddr
		log.Println("Blocked IP", ip)

		mu.Lock()
		defer mu.Unlock()

		if isBlocked(ip) {
			http.Error(w, "Too many requests, please try again later.", http.StatusTooManyRequests)
			log.Printf("Blocked IP %s due to rate limiting", ip)
			return
		}

		requestsMap[ip]++
		if requestsMap[ip] > limit {
			blockIP(ip)
			http.Error(w, "Too many requests, please try again later.", http.StatusTooManyRequests)
			log.Printf("Rate limit exceeded for IP %s", ip)
			return
		}

		// Reset count after time window
		go resetRequestCount(ip)
		next.ServeHTTP(w, r)
	})
}

func resetRequestCount(ip string) {
	time.Sleep(window)
	mu.Lock()
	defer mu.Unlock()
	delete(requestsMap, ip)
}

func blockIP(ip string) {
	requestsMap[ip] = -1 
	go func() {
		time.Sleep(blockTime)
		mu.Lock()
		defer mu.Unlock()
		delete(requestsMap, ip)
	}()
}

func isBlocked(ip string) bool {
	return requestsMap[ip] == -1
}
