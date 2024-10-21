-- Create a view to aggregate sales by customer, product, and region
CREATE VIEW sales_summary AS
SELECT
	o.id as order_id,
	o.order_date,
	p.id AS product_id,
	p.category as product_category,
	oi.price as price,
	oi.quantity as quantity,
    c.id AS customer_id,
	c.location as customer_location,
	t.id as transaction_id,
	t.payment_status,
	t.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.id
JOIN Order_Items oi ON o.id = oi.order_id
JOIN Products p ON oi.product_id = p.id
LEFT JOIN Transactions t ON o.id = t.order_id
WHERE o.status = 'COMPLETED';


-- Create materialized view for compulative heavy query.
CREATE MATERIALIZED VIEW customer_behavior_report AS
WITH order_stats AS (
    SELECT 
        c.id AS customer_id,
        EXTRACT(DAY FROM (MAX(o.order_date) - MIN(o.order_date))) AS total_order_period_days,
        COUNT(o.id) AS order_count
    FROM customers c
    LEFT JOIN orders o ON c.id = o.customer_id
    GROUP BY c.id
)
SELECT 
    c.id AS customer_id,
    TO_CHAR(c.signup_date, 'YYYY-MM-DD') as signup_date,
    c.lifetime_value,
    CASE
        WHEN c.lifetime_value < 500 THEN 'low'
        WHEN c.lifetime_value BETWEEN 500 AND 1000 THEN 'medium'
        ELSE 'high'
    END AS segment,
    CASE 
        WHEN os.order_count > 1 THEN FLOOR(os.total_order_period_days / (os.order_count - 1))
        ELSE 0
    END AS avg_order_frequency
FROM customers c
LEFT JOIN order_stats os ON c.id = os.customer_id;
