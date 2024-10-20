package services

import "ecom-report-api/repositories"

// ReportService handles business logic for reports
type ReportService struct {
    Repo repositories.ReportRepository
}

// NewReportService creates a new instance of ReportService
func NewReportService(repo repositories.ReportRepository) *ReportService {
    return &ReportService{Repo: repo}
}

// GenerateSalesReport generates the sales report
func (rs *ReportService) GenerateSalesReport() (interface{}, error) {
    return rs.Repo.FetchSalesReport()  // Business logic: delegate to the repository
}
