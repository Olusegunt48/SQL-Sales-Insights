
SELECT * FROM coffee_shop_sales;
DESCRIBE coffee_shop_sales;

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y')
WHERE transaction_date LIKE '%/%/%';

SELECT @@sql_safe_updates;
SET SQL_SAFE_UPDATES = 0;

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE;

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s')
WHERE transaction_time LIKE '%:%:%';

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME;

SELECT 
	ROUND(sum(unit_price * transaction_qty)) AS Total_sales
from 
	coffee_shop_sales
where 
	month(transaction_date) = 2;

SELECT * FROM coffee_shop_sales;

-- Calculate the total sales for each respective month
select 
	MONTH(transaction_date) as month, round(sum(unit_price * transaction_qty)) as Total_Sales
from 
	coffee_shop_sales
where 
	MONTH(transaction_date) IN (1,2,3,4,5,6,7,8,9,10,11,12) -- For each month
GROUP BY 
	MONTH(transaction_date)
ORDER BY 
	MONTH(transaction_date);


-- Determine the MoM increase or decrease in sales and in percentage
SELECT 
	MONTH(transaction_date) as month, -- Number of months
    ROUND(SUM(unit_price * transaction_qty)) AS Total_sales, -- Total Sales Column
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1) 
    OVER(ORDER BY MONTH(transaction_date))) AS  MoM_difference, -- Difference in sales MoM
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1) 
    OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1)
    OVER(ORDER BY MONTH(transaction_date)) * 100 as MoM_Growth_rate -- Growth or Decline rate
FROM
	coffee_shop_sales
WHERE
	MONTH(transaction_date) IN (1,2,3,4,5,6,7) -- For the Months
    
GROUP BY
	month(transaction_date)
ORDER BY
	month(transaction_date);
    
-- Calculate total orders for each month

SELECT 
	MONTH(transaction_date), COUNT(transaction_id) as Total_orders
from 
	coffee_shop_sales
where 
	month(transaction_date) IN (1,2,3,4,5,6,7)
GROUP BY 
	MONTH(transaction_date);

SELECT * FROM coffee_shop_sales;

-- Calculate the MoM difference in number of order and the MoM increase or decrease in number of order
SELECT 
	month(transaction_date) as Months,
    ROUND(COUNT(transaction_id)) as Total_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id),1)
    OVER(ORDER BY MONTH(transaction_date))) AS Difference_in_orders,
    (COUNT(transaction_id) - LAG(COUNT(transaction_id),1)
    OVER(ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id),1)
    OVER(ORDER BY MONTH(transaction_date)) * 100 as MoM_growth
FROM 
	coffee_shop_sales
WHERE
	MONTH(transaction_date) IN (1,2,3,4,5,6)
GROUP BY 
	MONTH(transaction_date)
ORDER BY 
	MONTH(transaction_date);
    
SELECT 
	MONTH(transaction_date) AS Months,
    SUM(transaction_qty) AS Total_Qty,
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1)
    OVER(ORDER BY MONTH(transaction_date))) AS difference_in_qty,
    (SUM(transaction_qty) - LAG(SUM(transaction_qty),1)
    OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty))
    OVER(ORDER BY MONTH(transaction_date)) * 100 AS MoM_growth
FROM 
	coffee_shop_sales
GROUP BY 
	MONTH(transaction_date)
ORDER BY
	MONTH(transaction_date);
    
SELECT
	-- MONTH(transaction_date) as Months,
	DAY(transaction_date) as Days,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1),'K') as Total_sales,
    CONCAT(ROUND(SUM(transaction_qty)/1000,1),'K')  as Total_QTY_Sold,
    ROUND(COUNT(transaction_id)) as Total_order
FROM 
	coffee_shop_sales
WHERE 
	MONTH(transaction_date) = 3
GROUP BY 
	DAY(transaction_date);

SELECT
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
    ELSE 'Weekdays'
    END AS Day_type,
    ROUND(SUM(unit_price * transaction_qty),0) as Total_sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 6
    GROUP BY 
		Day_type;
        
SELECT 
	store_location,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2),'K') as Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY store_location
ORDER BY Total_sales DESC;

SELECT MONTH(transaction_date) AS Month, ROUND(AVG(unit_price * transaction_qty),2) AS Average_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) in (1,2,3,4,5,6)
GROUP BY Month;

select ROUND(AVG(Total_sales)) as Average_Sales
from
	(
	SELECT ROUND(SUM(unit_price * transaction_qty)) as Total_sales
	from coffee_shop_sales
	where month(transaction_date) = 4
	group by transaction_date
    ) as internal_query;
    

SELECT
	MonthNo,
	day_of_month,
	CASE WHEN total_sales > avg_sales THEN 'Above Average'
    WHEN total_sales < avg_sales THEN 'Below Average'
    ELSE 'Average Sales'
    END AS Sales_Category,
    total_sales
FROM
	(
		SELECT 
			MONTH(transaction_date) AS MonthNo,
			DAY(transaction_date) AS day_of_month,
			ROUND(SUM(unit_price * transaction_qty)) AS total_sales,
            AVG(SUM(unit_price * transaction_qty)) over() as avg_sales
		FROM
			coffee_shop_sales
		WHERE 
			MONTH(transaction_date) IN (1,2,3)
		GROUP BY MonthNo, day_of_month
	) AS sales_data
    where 
		total_sales < avg_sales
    order by MonthNo, day_of_month
    
    
SELECT * FROM coffee_shop_sales;

select 
	product_category, 
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales
from 
	coffee_shop_sales
where 
	month(transaction_date) = 4
group by 
	product_category
order by 
	total_sales desc;
    
-- TOP 10 SELLING PRODUCTS BY PRODUCT TYPE
select 
	product_type, 
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales
from 
	coffee_shop_sales
where 
	month(transaction_date) = 4
group by 
	product_type
order by 
	total_sales desc
LIMIT 10;

-- VISUALIZE SALES PATTERNS BY DAYS AND HOURS

SELECT 
	MONTH(transaction_date) AS Month,
	DAYOFWEEK(transaction_date) AS DAY,
    HOUR(transaction_time) AS Hour,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_sales,
    ROUND(SUM(transaction_qty)) AS Total_qty,
    COUNT(*) AS Total_orders
FROM
	coffee_shop_sales
WHERE
	MONTH(transaction_date) = 5
  --  AND DAYOFWEEK(transaction_date) = 2
  --  AND HOUR(transaction_time) = 8
GROUP BY Month,DAY,Hour
ORDER BY DAY;

-- vISUALIZE THE DAYS OF THE WEEK WITH RESPECT TO THEIR RESPECTIVE SALES

SELECT
	DAYOFWEEK(transaction_date) AS DAY,
	CASE WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
		WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
		WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
		WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
		WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
		WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
        END AS Day_of_week,
	HOUR(transaction_time) AS HOUR,
	ROUND(SUM(unit_price * transaction_qty)) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY DAY,Day_of_week,HOUR
ORDER BY DAY;
