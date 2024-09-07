SELECT * from superstore;

--Total sales by category
SELECT category, sum (sales) as total_sales
from superstore
GROUP by category
order by total_sales DESC;

--total sales by sub-category
SELECT category, sum (sales) as total_sales
from superstore
GROUP by sub_category
order by total_sales DESC;

--Converting date to standard format
SELECT 
    substr(order_date, -4) || '-' || 
    printf('%02d', CAST(substr(order_date, instr(order_date, '/') + 1, instr(substr(order_date, instr(order_date, '/') + 1), '/') - 1) AS INTEGER)) || '-' ||
    printf('%02d', CAST(substr(order_date, 1, instr(order_date, '/') - 1) AS INTEGER)) AS reformatted_date,
    sales
FROM superstore;

ALTER TABLE superstore ADD COLUMN formatted_order_date TEXT;

UPDATE superstore
SET formatted_order_date = substr(order_date, -4) || '-' || 
    printf('%02d', CAST(substr(order_date, instr(order_date, '/') + 1, instr(substr(order_date, instr(order_date, '/') + 1), '/') - 1) AS INTEGER)) || '-' ||
    printf('%02d', CAST(substr(order_date, 1, instr(order_date, '/') - 1) AS INTEGER));
    
--Sales trends Monthly
SELECT strftime('%Y-%m', formatted_order_date) AS month, SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;

--Sales trends Quarterly
SELECT 
    strftime('%Y', formatted_order_date) || 
    '-Q' || 
    CASE 
        WHEN CAST(strftime('%m', formatted_order_date) AS INTEGER) BETWEEN 1 AND 3 THEN '1'
        WHEN CAST(strftime('%m', formatted_order_date) AS INTEGER) BETWEEN 4 AND 6 THEN '2'
        WHEN CAST(strftime('%m', formatted_order_date) AS INTEGER) BETWEEN 7 AND 9 THEN '3'
        WHEN CAST(strftime('%m', formatted_order_date) AS INTEGER) BETWEEN 10 AND 12 THEN '4'
    END AS quarter,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY quarter
ORDER BY quarter;

--Sales trends Yearly
SELECT 
    strftime('%Y', formatted_order_date) AS year, 
    SUM(sales) AS total_sales
FROM superstore
GROUP BY year
ORDER BY year;

-- find top performing products
SELECT product_name, sum(sales) as total_sales
from superstore
group by product_name
ORDER by total_sales DESC
LIMIT 10;

-- Total Sales by Customer Segment
SELECT segment, sum (sales) as total_sales
from superstore
GROUP by segment
order by total_sales DESC;

--find top customer
SELECT customer_id, customer_name, sum (sales) as total_sales
from superstore
GROUP by customer_id, customer_name
order by total_sales DESC
limit 10;

-- Average Order Size and Frequency by Customer
SELECT customer_id, customer_name, COUNT (order_id) as order_count, avg(sales) as average_order
from superstore
GROUP by customer_id, customer_name
order by order_count desc;

-- Sales by Region
SELECT region, SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- Sales by State
SELECT state, SUM(sales) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC;

-- Sales by City
SELECT city, SUM(sales) AS total_sales
FROM superstore
GROUP BY city
ORDER BY total_sales DESC;

-- shipping mode analysis
SELECT ship_mode, sum (sales) as total_sales
from superstore
group by ship_mode
order by total_sales desc;

-- Converting ship date to standard format
SELECT
   substr (ship_date, 7, 4) || '-' ||
   printf('%02d', CAST (substr(ship_date, 4, 2) as INTEGER)) || '-' ||
   printf('%02d', CAST (substr(ship_date, 1, 2) as INTEGER)) as formated_ship_date,
   sales
from superstore;

ALTER TABLE superstore ADD COLUMN formatted_ship_date TEXT;

UPDATE superstore
SET formatted_ship_date = substr(ship_date, 7, 4) || '-' || 
    printf('%02d', CAST(substr(ship_date, 4, 2) AS INTEGER)) || '-' || 
    printf('%02d', CAST(substr(ship_date, 1, 2) AS INTEGER));

-- Calculating the Average Shipping Time
SELECT
julianday(formatted_ship_date) - julianday(formatted_order_date) AS shipping_time_days,
AVG(julianday(formatted_ship_date) - julianday(formatted_order_date)) AS avg_shipping_time
from superstore
where formatted_ship_date is not NULL and formatted_order_date is not NULL; 
                                       
-- Product sales performance
SELECT product_name, sum(sales) as total_sales
from superstore
GROUP by product_name
order by total_sales DESC;

-- Sales by Category
SELECT category, SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Sales by Sub-Category
SELECT sub_category, SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Average Processing Time (from order to ship date)
SELECT AVG(JULIANDAY(formatted_ship_date) - JULIANDAY(formatted_order_date)) AS avg_processing_days
FROM superstore;

-- Number of Orders by Date
SELECT formatted_order_date, COUNT(order_id) AS order_count
FROM superstore
GROUP BY order_date
ORDER BY order_date;                               
                                       
-- Basic Trend Analysis Over Time
SELECT strftime('%Y-%m', formatted_order_date) AS month, SUM(sales) AS total_sales
FROM superstore
GROUP BY month
ORDER BY month;  
       
       


