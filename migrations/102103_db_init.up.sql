-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    signup_date DATE NOT NULL DEFAULT CURRENT_DATE,
    location VARCHAR(100),
    lifetime_value NUMERIC(10, 2) DEFAULT 0.00
);

-- Create Products table
CREATE TABLE IF NOT EXISTS Products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
    id SERIAL NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL CHECK (status IN ('PENDING', 'COMPLETED', 'CANCELED')),
    PRIMARY KEY (id, order_date),
	FOREIGN KEY (customer_id) REFERENCES Customers(id) ON DELETE CASCADE
) PARTITION BY RANGE (order_date);

-- partitions table
CREATE TABLE Orders_2022 PARTITION OF Orders
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE Orders_2023 PARTITION OF Orders
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Orders_2024 PARTITION OF Orders
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Create Order_Items table
CREATE TABLE IF NOT EXISTS Order_Items (
    order_id INT NOT NULL,
	order_date DATE NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id, order_date) REFERENCES Orders(id, order_date) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

-- Create Transactions table
CREATE TABLE IF NOT EXISTS Transactions (
    id SERIAL NOT NULL,
    order_id INT NOT NULL,
	order_date DATE NOT NULL,
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('SUCCESS', 'FAILED')),
    payment_date DATE NULL DEFAULT CURRENT_DATE,
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0),
    PRIMARY KEY (id, payment_date),
	FOREIGN KEY (order_id, order_date) REFERENCES Orders(id, order_date) ON DELETE CASCADE
) PARTITION BY RANGE (payment_date);

CREATE TABLE Transactions_2022 PARTITION OF Transactions
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE Transactions_2023 PARTITION OF Transactions
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Transactions_2024 PARTITION OF Transactions
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');







INSERT INTO Customers (name, email, signup_date, location, lifetime_value)
VALUES 
('John Doe', 'johndoe@example.com', '2023-01-15', 'New York', 1200.00),
('Jane Smith', 'janesmith@example.com', '2023-02-20', 'Los Angeles', 980.00),
('Bob Johnson', 'bobjohnson@example.com', '2023-03-12', 'Chicago', 1500.00),
('Alice Davis', 'alicedavis@example.com', '2023-04-05', 'Houston', 700.00),
('Charlie Brown', 'charliebrown@example.com', '2023-05-01', 'Miami', 850.00),
('Emily White', 'emilywhite@example.com', '2023-06-21', 'Boston', 1100.00),
('Michael Black', 'michaelblack@example.com', '2023-07-14', 'San Francisco', 1400.00),
('Olivia Green', 'oliviagreen@example.com', '2023-08-03', 'Seattle', 900.00),
('Ethan King', 'ethanking@example.com', '2023-09-09', 'Dallas', 1150.00),
('Sophia Lewis', 'sophialewis@example.com', '2023-10-10', 'Atlanta', 950.00);


INSERT INTO Products (name, category, price)
VALUES 
('Laptop', 'Electronics', 1500.00),
('Smartphone', 'Electronics', 800.00),
('Headphones', 'Electronics', 150.00),
('Refrigerator', 'Appliances', 1000.00),
('Microwave', 'Appliances', 200.00),
('T-shirt', 'Clothing', 25.00),
('Jeans', 'Clothing', 60.00),
('Shoes', 'Footwear', 100.00),
('Watch', 'Accessories', 250.00),
('Backpack', 'Accessories', 80.00);


INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2022-01-01', 'COMPLETED'),
(2, '2022-01-02', 'COMPLETED'),
(3, '2022-01-03', 'PENDING'),
(4, '2022-01-04', 'COMPLETED'),
(5, '2022-01-05', 'CANCELED'),
(6, '2023-01-06', 'COMPLETED'),
(7, '2023-01-07', 'PENDING'),
(8, '2023-01-08', 'COMPLETED'),
(9, '2023-01-09', 'CANCELED'),
(10, '2023-01-10', 'COMPLETED'),
(2, '2023-01-11', 'COMPLETED'),
(3, '2023-01-12', 'COMPLETED'),
(4, '2024-01-13', 'PENDING'),
(5, '2024-01-14', 'COMPLETED'),
(6, '2024-01-15', 'CANCELED'),
(7, '2024-01-16', 'COMPLETED'),
(8, '2024-01-17', 'COMPLETED'),
(9, '2024-01-18', 'COMPLETED'),
(10, '2024-01-19', 'COMPLETED'),
(1, '2024-01-20', 'PENDING');


INSERT INTO Order_Items (order_id, order_date, product_id, quantity, price) VALUES
(1, '2022-01-01', 1, 1, 1500.00),   
(1, '2022-01-01', 2, 2, 1600.00),   
(2, '2022-01-02', 3, 3, 450.00),    
(3, '2022-01-03', 4, 1, 1000.00),  
(3, '2022-01-03', 5, 2, 400.00),    
(4, '2022-01-04', 6, 1, 25.00),    
(5, '2022-01-05', 7, 1, 60.00),  
(6, '2023-01-06', 8, 3, 300.00),    
(7, '2023-01-07', 9, 1, 250.00), 
(8, '2023-01-08', 10, 2, 160.00),  
(9, '2023-01-09', 1, 1, 1500.00), 
(10, '2023-01-10', 2, 1, 800.00),   
(11, '2023-01-11', 3, 4, 600.00),    
(12, '2023-01-12', 4, 1, 1000.00),  
(13, '2024-01-13', 5, 3, 600.00),   
(14, '2024-01-14', 6, 1, 25.00),
(14, '2024-01-14', 3, 4, 600.00),
(15, '2024-01-15', 7, 2, 120.00),   
(16, '2024-01-16', 8, 1, 100.00), 
(17, '2024-01-17', 9, 1, 250.00), 
(17, '2024-01-17', 6, 1, 25.00),
(18, '2024-01-18', 10, 2, 160.00),  
(19, '2024-01-19', 1, 1, 1500.00), 
(20, '2024-01-20', 1, 1, 1500.00);


INSERT INTO Transactions (order_id, order_date, payment_status, payment_date, total_amount) VALUES
(1, '2022-01-01', 'SUCCESS', '2022-01-01', 2100.00),
(2, '2022-01-02', 'SUCCESS', '2022-01-02', 450.00),
(4, '2022-01-04', 'SUCCESS', '2022-01-04', 25.00),
(5, '2022-01-05', 'FAILED', '2024-01-13', 60.00),
(6, '2023-01-06', 'SUCCESS', '2023-01-06', 300.00),
(8, '2023-01-08', 'SUCCESS', '2023-01-08', 160.00),
(9, '2023-01-09', 'FAILED', '2024-01-12', 1500.00),
(10, '2023-01-10', 'SUCCESS', '2023-01-10', 800.00),
(11, '2023-01-11', 'SUCCESS', '2023-01-11', 600.00),
(12, '2023-01-12', 'SUCCESS', '2023-01-12', 1000.00),
(14, '2024-01-14', 'SUCCESS', '2024-01-14', 25.00),
(15, '2024-01-15', 'SUCCESS', '2024-01-15', 120.00),
(16, '2024-01-16', 'SUCCESS', '2024-01-16', 100.00),
(17, '2024-01-17', 'FAILED', '2024-01-17', 275.00),
(18, '2024-01-18', 'SUCCESS', '2024-01-18', 160.00),
(19, '2024-01-19', 'SUCCESS', '2024-01-19', 1500.00);





-- Index on Orders for date filtering
CREATE INDEX idx_orders_order_date ON Orders(order_date);

-- Index on Order_Items for product filtering
CREATE INDEX idx_order_items_product_id ON Order_Items(product_id);

-- Index on Products for category filtering
CREATE INDEX idx_products_category ON Products(category);

-- Index on Customers for location filtering
CREATE INDEX idx_customers_location ON Customers(location);

-- Index on Customers for singup date filtering
CREATE INDEX idx_customers_signup_date ON customers(signup_date);

-- Index on Customers for singup date filtering
CREATE INDEX idx_customers_lifetime_value ON customers(lifetime_value);

-- Index on Customers for orders filters partition tables.
CREATE INDEX idx_orders_customer_id ON orders_2024 (customer_id);

-- Index on Customers for orders filters partition tables.
CREATE INDEX idx_transactions_order_id ON transactions_2024 (order_id);





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
        (MAX(o.order_date) - MIN(o.order_date)) AS total_order_period_days,
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


CREATE VIEW customer_retention As
WITH first_purchase AS (
    SELECT customer_id, MIN(order_date) AS first_purchase
    FROM orders
    GROUP BY customer_id
), 
retention AS (
    SELECT 
        fp.customer_id, 
        fp.first_purchase, 
        COUNT(o.id) AS total_orders,
        DATE_PART('month', AGE(o.order_date, fp.first_purchase)) AS months_since_first
    FROM first_purchase fp
    LEFT JOIN orders o 
    ON fp.customer_id = o.customer_id
    WHERE o.order_date IS NOT NULL
    GROUP BY fp.customer_id, fp.first_purchase, months_since_first
)
SELECT 
	months_since_first, 
	COUNT(DISTINCT customer_id) AS retained_customers,
	ARRAY_AGG(DISTINCT customer_id) as customer_ids
FROM retention
WHERE months_since_first IN (3, 6, 12)
GROUP BY months_since_first;


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


