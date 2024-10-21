package types

type SalesReportFilters struct {
    StartDate string
    EndDate   string
    Category  string
    ProductID string
    Location  string
}

type CustomerReportFilters struct {
    StartDate string
    EndDate   string
    LifetimeValue  string
}

type RevenueRow struct {
    Type string
    CustomerId *int32
    ProductId *int32
    Location *string
    Revenue float32
}
type CustomerRev struct {
    CustomerId *int32
    Revenue float32
}
type ProductRev struct {
    ProductId *int32
    Revenue float32
}
type RegionRev struct {
    Location *string
    Revenue float32
}
type TotalRevenue struct {
    ByCustomer []CustomerRev
    ByProduct []ProductRev
    ByRegion []RegionRev
}

type SalesReport struct {
	TotalSales float32
	ProductsSold int32
	AvgOrderValue float32
}

type SalesResponse struct {
    Report SalesReport
    TotalRevenue TotalRevenue
}
type CustomerReport struct {
    CustomerId int32
    SignupDate string
    LifetimeValue int32
    CustomerSegment string
    AvgOrderFrequency int32
}
type CustomerResponse struct {
	TotalCustomers int32
    CustomerReport []CustomerReport
}