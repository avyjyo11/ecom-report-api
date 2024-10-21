package controllers

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/avyjyo11/ecom-report-api/services"
	"github.com/avyjyo11/ecom-report-api/types"
)

// ReportController handles report-related API requests
type ReportController struct {
    Service *services.ReportService
}

// NewReportController creates a new instance of ReportController
func NewReportController(service *services.ReportService) *ReportController {
    return &ReportController{
        Service: service,
    }
}

// GetSalesReport generates a sales report
func (rc *ReportController) GetSalesReport(w http.ResponseWriter, r *http.Request) {
    filters := types.SalesReportFilters{
        StartDate: r.URL.Query().Get("start_date"),
        EndDate:   r.URL.Query().Get("end_date"),
        Category:  r.URL.Query().Get("category"),
        ProductID: r.URL.Query().Get("product_id"),
        Location:  r.URL.Query().Get("location"),
    }

    // Add logic to retrieve filter params from the request
    report, err := rc.Service.GenerateSalesReport(filters)

    if err != nil {
        log.Fatalln("error query", err);
        http.Error(w, "Error generating report", http.StatusInternalServerError)
        return
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(report)
}

// GetSalesReport generates a customers report
func (rc *ReportController) GetCustomersReport(w http.ResponseWriter, r *http.Request) {
    filters := types.CustomerReportFilters{
        StartDate: r.URL.Query().Get("signup_start_date"),
        EndDate:   r.URL.Query().Get("signup_end_date"),
        LifetimeValue:  r.URL.Query().Get("lifetiem_value"),
    }

    // Add logic to retrieve filter params from the request
    report, err := rc.Service.GenerateCustomerReports(filters)

    if err != nil {
        log.Fatalln("error query", err);
        http.Error(w, "Error generating report", http.StatusInternalServerError)
        return
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(report)
}
