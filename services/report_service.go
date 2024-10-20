package services

import (
	"github.com/avyjyo11/ecom-report-api/repositories"
	"github.com/avyjyo11/ecom-report-api/types"
)

// ReportService handles business logic for reports
type ReportService struct {
    Repo *repositories.ReportRepository
}

// NewReportService creates a new instance of ReportService
func NewReportService(repo *repositories.ReportRepository) *ReportService {
    return &ReportService{Repo: repo}
}

// GenerateSalesReport generates the sales report
func (rs *ReportService) GenerateSalesReport(filters types.SalesReportFilters) (interface{}, error) {
    return rs.Repo.FetchSalesReport(filters) 
}
