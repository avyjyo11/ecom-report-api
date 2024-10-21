package services

import (
	"errors"
	"time"

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
func (rs *ReportService) GenerateSalesReport(filters types.SalesReportFilters) (*types.SalesResponse, error) {
    var startDate, endDate time.Time
    var err error

    if filters.StartDate != "" {
        startDate, err = time.Parse("2006-01-02", filters.StartDate)
        if err != nil {
            return nil, errors.New("invalid start date format")
        }
    }
    if filters.EndDate != "" {
        endDate, err = time.Parse("2006-01-02", filters.EndDate)
        if err != nil {
            return nil, errors.New("invalid end date format")
        }
    }

    return rs.Repo.FetchSalesReport(startDate, endDate, filters.ProductID, filters.Category, filters.Location) 
}

// GenerateSalesReport generates the sales report
func (rs *ReportService) GenerateCustomerReports(filters types.CustomerReportFilters) (*types.CustomerResponse, error) {
    var startDate, endDate time.Time
    var err error

    if filters.StartDate != "" {
        startDate, err = time.Parse("2006-01-02", filters.StartDate)
        if err != nil {
            return nil, errors.New("invalid start date format")
        }
    }
    if filters.EndDate != "" {
        endDate, err = time.Parse("2006-01-02", filters.EndDate)
        if err != nil {
            return nil, errors.New("invalid end date format")
        }
    }

    return rs.Repo.FetchCustomersReport(startDate, endDate, filters.LifetimeValue) 
}

