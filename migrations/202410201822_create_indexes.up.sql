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