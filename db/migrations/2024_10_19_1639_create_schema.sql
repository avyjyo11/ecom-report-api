CREATE SCHEMA IF NOT EXISTS ecomm_schema;

SET search_path TO ecomm_schema;

-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    signup_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL CHECK (status IN ('PENDING', 'COMPLETED', 'CANCELED')),
    FOREIGN KEY (customer_id) REFERENCES Customers(id) ON DELETE CASCADE
);

-- Create Order_Items table
CREATE TABLE IF NOT EXISTS Order_Items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(id) ON DELETE CASCADE
);

-- Create Transactions table
CREATE TABLE IF NOT EXISTS Transactions (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('SUCCESS', 'FAILED')),
    payment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE
);

-- Create indexes to improve performance
CREATE INDEX idx_customer_signup_date ON Customers (signup_date);
CREATE INDEX idx_order_date ON Orders (order_date);
CREATE INDEX idx_product_category ON Products (category);