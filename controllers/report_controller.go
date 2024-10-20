package controllers

import (
	"ecom-report-api/services"
	"encoding/json"
	"net/http"
)

// ReportController handles report-related API requests
type ReportController struct {
    Service services.ReportService
}

// NewReportController creates a new instance of ReportController
func NewReportController(service services.ReportService) *ReportController {
    return &ReportController{
        Service: service,
    }
}

// GetSalesReport generates a sales report
func (rc *ReportController) GetSalesReport(w http.ResponseWriter, r *http.Request) {
    // Add logic to retrieve filter params from the request
    report, err := rc.Service.GenerateSalesReport()  // Business logic goes in the service layer
    if err != nil {
        http.Error(w, "Error generating report", http.StatusInternalServerError)
        return
    }

    w.Header().Set("Content-Type", "application/json")
    json.NewEncoder(w).Encode(report)
}
