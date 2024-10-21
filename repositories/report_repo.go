package repositories

import (
	"context"
	"log"
	"strings"
	"time"

	"github.com/avyjyo11/ecom-report-api/db"
	"github.com/avyjyo11/ecom-report-api/types"
	"github.com/jackc/pgx/v5"
)

// ReportRepository handles database queries for reports
type ReportRepository struct{}

// NewReportRepository creates a new instance of ReportRepository
func NewReportRepository() *ReportRepository {
    return &ReportRepository{}
}

// FetchCustomerReport fetches sales report from the database
func (rr ReportRepository) FetchCustomersReport(startDate, endDate time.Time, lifetimeValue string) (*types.CustomerResponse, error) {
    pool := db.GetPool()

    sum_query := `
        SELECT COUNT(*) as total FROM customers c
    `

    var conditions []string
    var args []interface{}

   // Apply date range filter
   if !startDate.IsZero() {
        conditions = append(conditions, "c.signup_date >= $1")
        args = append(args, startDate)
    }
    if !endDate.IsZero() {
        conditions = append(conditions, "c.signup_date <= $2")
        args = append(args, endDate)
    }
    if lifetimeValue != "" {
        conditions = append(conditions, "c.lifetime_value = $3")
        args = append(args, lifetimeValue)
    }
    if len(conditions) > 0 {
        sum_query += " WHERE " + strings.Join(conditions, " AND ")
    }

    // Example query, actual logic will depend on requirements
    totalRows, err := pool.Query(context.Background(), sum_query, args...);
    if err != nil {
        log.Fatalf("failed in sum query: %v", err)
        return nil, err
    }

    var total int32
    for totalRows.Next() {
        totalRows.Scan(&total)
    }
    customerResponse := &types.CustomerResponse{ TotalCustomers: total }  

    report_query := `
        SELECT * FROM customer_behavior_report c
    `

    rows, err := pool.Query(context.Background(), report_query, args...);
    if err != nil {
        log.Fatalf("failed in report query: %v", err)
        return nil, err
    }
    resp, err := pgx.CollectRows(rows, pgx.RowToStructByPos[types.CustomerReport])
    customerResponse.CustomerReport = resp;

    if err != nil {
        log.Fatalf("failed in repo: %v", err)
        return nil, err
    }
    return customerResponse, nil
}


// FetchSalesReport fetches sales report from the database
func (rr ReportRepository) FetchSalesReport(startDate, endDate time.Time, productID, category, location string) (*types.SalesResponse, error) {
    pool := db.GetPool()

    query := `
        SELECT 
            SUM(s.price) AS total_sales,
            SUM(s.quantity) AS products_sold,
            AVG(s.price) AS average_order_value
        FROM sales_summary s
    `

    var conditions []string
    var args []interface{}

   // Apply date range filter
   if !startDate.IsZero() {
        conditions = append(conditions, "s.order_date >= $1")
        args = append(args, startDate)
    }
    if !endDate.IsZero() {
        conditions = append(conditions, "s.order_date <= $2")
        args = append(args, endDate)
    }
    if productID != "" {
        conditions = append(conditions, "s.product_id = $3")
        args = append(args, productID)
    }
    if category != "" {
        conditions = append(conditions, "s.product_category = $4")
        args = append(args, category)
    }
    if location != "" {
        conditions = append(conditions, "s.customer_location = $5")
        args = append(args, location)
    }
    if len(conditions) > 0 {
        query += " WHERE " + strings.Join(conditions, " AND ")
    }

    // Example query, actual logic will depend on requirements
    rows, err := pool.Query(context.Background(),  query, args...);
    if err != nil {
        log.Fatalf("failed to sales query: %v", err)
        return nil, err
    }
    defer rows.Close()

    resp, err := pgx.CollectOneRow(rows, pgx.RowToStructByPos[types.SalesReport])
    if err != nil {
        log.Fatalf("failed to sales report collect: %v", err)
        return nil, err
    }
    response := &types.SalesResponse{ Report: resp }  

    rev_by_customer_query := `
    SELECT
        'RevByCustomer' as type,
        customer_id as customer_id,
        null as product_id,
        null as location,
        SUM(price) as revenue
    FROM sales_summary s
    GROUP BY s.customer_id
    `
    rev_by_product_query := `
    SELECT
    	'RevByProduct' as type,
    	null as customer_id,
    	product_id as product_id,
    	null as location,
    	SUM(price) as revenue 
    FROM sales_summary s  
    GROUP BY s.product_id
    `
    rev_by_region_query := `
    SELECT
    	'RevByRegion' as type,
    	null as customer_id,
    	null as product_id,
    	s.customer_location as location,
    	SUM(price) as revenue 
    FROM sales_summary s  
    GROUP BY s.customer_location
    `
    rev_query := rev_by_customer_query + "UNION" + rev_by_product_query + " UNION " + rev_by_region_query + " ORDER BY type;"

    rev_rows, err := pool.Query(context.Background(), rev_query);
    if err != nil {
        log.Fatalf("failed to revenue query: %v", err)
        return nil, err
    }
    defer rev_rows.Close()

    rev_data, err := pgx.CollectRows(rev_rows, pgx.RowToStructByPos[types.RevenueRow])
    if err != nil {
        log.Fatalf("failed to revenue rows: %v", err)
        return nil, err
    }

    totalRev := types.TotalRevenue{}
    var byCustomer []types.CustomerRev
    var byProduct []types.ProductRev
    var byRegion []types.RegionRev

    for _, data := range rev_data { 
        if data.Type == "RevByCustomer" {
            byCustomer = append(byCustomer, types.CustomerRev{ 
                CustomerId: data.CustomerId, 
                Revenue: data.Revenue,
            })
        }
        if data.Type == "RevByProduct" {
            byProduct = append(byProduct, types.ProductRev{ 
                ProductId: data.ProductId, 
                Revenue: data.Revenue,
            })
        }
        if data.Type == "RevByRegion" {
            byRegion = append(byRegion, types.RegionRev{ 
                Location: data.Location, 
                Revenue: data.Revenue,
            })
        }
    } 

    totalRev.ByCustomer = byCustomer
    totalRev.ByProduct = byProduct
    totalRev.ByRegion = byRegion
    response.TotalRevenue = totalRev

    return response, nil
}
