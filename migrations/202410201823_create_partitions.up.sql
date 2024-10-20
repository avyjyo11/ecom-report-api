-- Partition Orders table by order_date (e.g., by year)
CREATE TABLE Orders_2023 PARTITION OF Orders
FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');
