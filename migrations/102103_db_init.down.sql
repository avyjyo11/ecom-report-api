DELETE FROM order_items;
DELETE FROM transactions;
DELETE FROM orders;

DELETE FROM customers;
DELETE FROM products;

DROP VIEW IF EXISTS sales_summary;
DROP MATERIALIZED VIEW IF EXISTS customer_behavior_report;
DROP VIEW IF EXISTS customer_retention;
DROP VIEW IF EXISTS customer_rank_appliances;

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;