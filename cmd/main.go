package main

import (
	"ecom-report-api/config"
	"ecom-report-api/controllers"
	"ecom-report-api/db"
	"ecom-report-api/repositories"
	"ecom-report-api/services"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
)

func main() {
    // Load configuration and initialize the DB connection pool
    cfg := config.LoadConfig()
    _, err := db.InitializePool(cfg)
    if err != nil {
        log.Fatal(err)
    }
 
    // Set up the repository, service, and controllers
    repo := repositories.NewReportRepository()
    service := services.NewReportService(repo)
    reportController := controllers.NewReportController(service)

    router := chi.NewRouter()
    router.Get("/reports/sales", reportController.GetSalesReport)

    // Start the server
    log.Println("Server started on port 8080")
    http.ListenAndServe(":8080", router)
}
