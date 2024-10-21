# Database optimizations implemented

## Create views and materialized ivews for the report query

- sales_summary (view)
- customer behaviour report (materialized view)

## Added partitions for the orders and transactions table

- partitions tables for orders and transactions tables
  for range (2022-2023, 2023-2024, 2024-2025)

  note: We can add more as per data present. currently I have only 3.

### Optimizations needed:

- for this we can implement this setting up automation for partition table generation
- setup cronjobs for postgres to update the partitions (for eg. each half year)
-

## Applied indexing in tables (optimization for large db)

- 'idx_orders_order_date' on orders table for filtering with date
- 'idx_order_items_product_id' on orders_items table for product_id filters
- 'idx_products_category' for the products category filtering and in view applications
- 'idx_customers_location' on customers table for location filtering
- 'idx_customers_signup_date' on the signup_date field for filtering

also created seperate indexes for each partitioned tables
for now, considering mostly used range for 2024-2025

- 'idx_orders_customer_id' on Customers for orders filters partition tables.
- 'idx_transactions_order_id' on Customers for orders filters partition tables.

## Extra assignment tasks in SQL implemented:

- Task: Calculate retention of customers over time.
  Answer: Created view in db named: `customer_retention`

- Task: Use window functions to rank customers by their total spending, to identify the top N customers
  in a particular region or for a specific product category
  Answer: Created view in db named: `customer_rank_appliances`

  ```
  CREATE VIEW customer_rank_appliances AS
  SELECT
    c.id AS customer_id,
    SUM(COALESCE(s.price, 0)) AS total_spent,
    RANK() OVER (ORDER BY SUM(COALESCE(s.price, 0)) DESC) AS rank
  FROM customers c
  LEFT JOIN sales_summary s ON c.id = s.customer_id
  WHERE s.product_category = 'Appliances'
  GROUP BY c.id
  ORDER BY rank
  LIMIT 8;
  ```

  we can update the `LIMIT` and `s.product_category`.
