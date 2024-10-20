package db

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

var pool *pgxpool.Pool

// InitializePool initializes the PostgreSQL connection pool
func InitializePool(connStr string) (*pgxpool.Pool, error) {
    var err error
    pool, err = pgxpool.New(context.Background(), connStr)
    if err != nil {
        return nil, err
    }

    // Test the connection
    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    err = pool.Ping(ctx)
    if err != nil {
        return nil, fmt.Errorf("unable to connect to the database: %w", err)
    }

    log.Println("Connected to the database!")
    return pool, nil
}

// GetPool returns the initialized connection pool
func GetPool() *pgxpool.Pool {
    return pool
}
