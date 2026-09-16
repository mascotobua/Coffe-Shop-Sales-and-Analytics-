CREATE TABLE coffee_sales (
    hour_of_day INT,
    cash_type VARCHAR(10),
    money NUMERIC(10,2),
    coffee_name VARCHAR(50),
    time_of_day VARCHAR(20),
    weekday VARCHAR(15),
    month_name VARCHAR(15),
    sales_date DATE,
    sales_time TIME
);

select * from coffee_sales;

-- Baseline Metric--
select 
count(*) as total_transactions,
round(sum(money),2) as total_revenue,
round(avg(money),2) as avg_transaction_value,
round(min(money),2) as min_transaction,
round(max(money),2) as max_transaction
from coffee_sales;

--Best Selling coffee tpe by revenue and volume

SELECT coffee_name,
    COUNT(*) AS units_sold,
    ROUND(SUM(money),2) AS total_revenue,
    ROUND(AVG(money),2) AS avg_price
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue DESC;

--Monthly trend
SELECT month_name,
    COUNT(*) AS transactions,
    SUM(money) AS revenue
FROM coffee_sales
GROUP BY month_name
ORDER BY MIN(sales_date) asc;

--Weekly Sales
SELECT 
    weekday,
    COUNT(*) AS transactions,
    SUM(money) AS revenue,
    ROUND(AVG(money), 2) AS avg_transaction
FROM coffee_sales
GROUP BY weekday
ORDER BY MIN(sales_date) asc;


--Sales Distribution Time of Day
SELECT 
    time_of_day,
    COUNT(*) AS transactions,
    ROUND(SUM(money),2) AS total_revenue,
    ROUND(100.0 * COUNT(*)/SUM(COUNT(*)) OVER (), 2) AS pct_of_all_transactions
FROM coffee_sales
GROUP BY time_of_day
ORDER BY total_revenue DESC;

--Peak Hours

SELECT 
    hour_of_day,
    COUNT(*) AS transactions,
    SUM(money) AS revenue
FROM coffee_sales
GROUP BY hour_of_day
ORDER BY transactions desc;


--Payment Type
SELECT 
    cash_type,
    COUNT(*) AS transactions,
    SUM(money) AS revenue,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_transactions
FROM coffee_sales
GROUP BY cash_type;