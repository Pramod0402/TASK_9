-- ✅ Create the 'online_sales' table
CREATE TABLE online_sales (
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    product_id INT NOT NULL
);

-- ✅ Show secure file path to verify allowed import folder
SHOW VARIABLES LIKE 'secure_file_priv';

-- ✅ Load data from CSV (ensure file is placed in the shown directory)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/online_sales.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ✅ MySQL-compatible monthly revenue and order volume query
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, month
ORDER BY year, month;

-- ✅ Top 5 revenue-generating months (MySQL version)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month_year,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY month_year
ORDER BY total_revenue DESC
LIMIT 5;

-- ✅ Average revenue per order
SELECT 
    AVG(order_total) AS avg_revenue_per_order
FROM (
    SELECT order_id, SUM(amount) AS order_total
    FROM online_sales
    GROUP BY order_id
) AS order_summary;