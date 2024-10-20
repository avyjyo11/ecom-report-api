-- Create a view to aggregate sales by customer, product, and region
CREATE VIEW sales_summary AS
SELECT 
    c.id AS customer_id,
    c.name AS customer_name,
    c.location AS customer_location,
    p.id AS product_id,
    p.name AS product_name,
    p.category AS product_category,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_sales,
    COUNT(DISTINCT o.id) AS total_orders,
    SUM(t.total_amount) AS total_revenue
FROM 
    Orders o
JOIN Customers c ON o.customer_id = c.id
JOIN Order_Items oi ON o.id = oi.order_id
JOIN Products p ON oi.product_id = p.id
JOIN Transactions t ON o.id = t.order_id
WHERE 
    o.status = 'COMPLETED' AND t.payment_status = 'SUCCESS'
GROUP BY 
    c.id, c.name, c.location, p.id, p.name, p.category;