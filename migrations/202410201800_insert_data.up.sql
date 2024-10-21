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


INSERT INTO Orders (customer_id, order_date, status)
VALUES 
(1, '2023-01-20', 'COMPLETED'),
(2, '2023-02-25', 'COMPLETED'),
(3, '2023-03-15', 'PENDING'),
(4, '2023-04-10', 'COMPLETED'),
(5, '2023-05-05', 'CANCELED'),
(6, '2023-06-25', 'COMPLETED'),
(7, '2023-07-17', 'PENDING'),
(8, '2023-08-08', 'COMPLETED'),
(9, '2023-09-11', 'COMPLETED'),
(10, '2023-10-12', 'PENDING'),
(1, '2023-11-01', 'COMPLETED'),
(3, '2023-11-05', 'COMPLETED'),
(7, '2023-11-10', 'CANCELED');


INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 1500.00),
(2, 2, 2, 1600.00),
(2, 4, 1, 1000.00),
(3, 3, 1, 150.00),
(3, 4, 1, 1000.00),
(4, 4, 1, 1000.00),
(5, 5, 1, 200.00),
(6, 6, 2, 50.00),
(7, 7, 2, 120.00),
(8, 8, 1, 250.00),
(8, 4, 1, 1000.00),
(9, 9, 1, 250.00),
(10, 10, 1, 80.00),
(11, 4, 1, 1000.00),
(12, 5, 1, 200.00),
(13, 6, 1, 60.00);


INSERT INTO Transactions (order_id, payment_status, payment_date, total_amount)
VALUES 
(1, 'SUCCESS', '2023-01-21', 1500.00),
(2, 'SUCCESS', '2023-02-26', 2600.00),
(3, 'SUCCESS', '2023-03-16', 1150.00),
(4, 'SUCCESS', '2023-04-11', 1000.00),
(5, 'FAILED', '2023-05-06', 200.00),
(6, 'SUCCESS', '2023-06-26', 110.00),
(7, 'FAILED', '2023-07-18', 240.00),
(8, 'SUCCESS', '2023-08-09', 1250.00),
(9, 'SUCCESS', '2023-09-12', 250.00),
(10, 'FAILED', '2023-10-13', 80.00),
(11, 'SUCCESS', '2023-11-02', 1000.00),
(12, 'SUCCESS', '2023-11-06', 200.00),
(13, 'FAILED', '2023-11-11', 60.00);
