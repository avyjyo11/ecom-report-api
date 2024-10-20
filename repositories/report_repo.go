package repositories

import (
	"context"
	"ecom-report-api/db"
)

// ReportRepository handles database queries for reports
type ReportRepository struct{}

// NewReportRepository creates a new instance of ReportRepository
func NewReportRepository() *ReportRepository {
    return &ReportRepository{}
}

// FetchSalesReport fetches sales report from the database
func (rr *ReportRepository) FetchSalesReport() (interface{}, error) {
    pool := db.GetPool()

    // Example query, actual logic will depend on requirements
    rows, err := pool.Query(context.Background(), `
        SELECT SUM(total_amount) as total_sales FROM transactions
    `)
    if err != nil {
        return nil, err
    }
    defer rows.Close()

    var totalSales float64
    for rows.Next() {
        err := rows.Scan(&totalSales)
        if err != nil {
            return nil, err
        }
    }

    return totalSales, nil
}
