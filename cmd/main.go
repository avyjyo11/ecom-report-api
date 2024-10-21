package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/avyjyo11/ecom-report-api/config"
	"github.com/avyjyo11/ecom-report-api/controllers"
	"github.com/avyjyo11/ecom-report-api/db"
	"github.com/avyjyo11/ecom-report-api/repositories"
	"github.com/avyjyo11/ecom-report-api/services"

	"github.com/go-chi/chi/v5"
)

func main() {
    // Load configuration and initialize the DB connection pool
    cfg := config.LoadConfig()
    connStr := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=%s",
        cfg.DBUser, cfg.DBPassword, cfg.DBHost, cfg.DBPort, cfg.DBName, cfg.SSLMode)

    _, err := db.InitializePool(connStr)
    if err != nil {
        log.Fatal(err)
    }

    // Run migrations
    // migrations.RunMigrations(connStr)

    // Set up the repository, service, and controllers
    repo := repositories.NewReportRepository()
    service := services.NewReportService(repo)
    reportController := controllers.NewReportController(service)

    router := chi.NewRouter()
    router.Get("/reports/sales", reportController.GetSalesReport)
    router.Get("/reports/customers", reportController.GetCustomersReport)

    // Start the server
    log.Println("Server started on port 8080")
    http.ListenAndServe(":8080", router)
}
