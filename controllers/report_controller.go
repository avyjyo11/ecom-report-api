package controllers

import (
	"encoding/json"
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
    report, err := rc.Service.GenerateSalesReport(filters)  // Business logic goes in the service layer
    if err != nil {
        http.Error(w, "Error generating report", http.StatusInternalServerError)
        return
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(report)
}
