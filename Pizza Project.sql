SELECT * FROM pizza_sales

-- Total Revenue 
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

--Average Order Value 
SELECT SUM(total_price) / COUNT (DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales

--Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales

--Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales 

--Average pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_pizzas_per_order FROM pizza_sales
SELECT DATENAME(DW, order_date) as order_day,COUNT(DISTINCT order_id) AS Total_orders
from pizza_sales
GROUP BY DATENAME(DW, order_date)

--Hourly trend for total Pizzas sold
SELECT DATEPART (HOUR, order_time) as order_hours, SUM(quantity) AS Total_Pizzas_Sold_hour
FROM pizza_sales
GROUP BY DATEPART (HOUR, order_time)
ORDER BY DATEPART (HOUR, order_time) ASC

--Weekly trend for total Orders
SELECT DATEPART(ISO_WEEK, order_date) AS week_number, YEAR(order_date) AS Order_year, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY  DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY  DATEPART(ISO_WEEK, order_date), YEAR(order_date)

--Percentage of sales per pizza category
SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS Perc_Total_Sales_per_Cat
FROM pizza_sales 
GROUP BY  pizza_category

--Percentage of sales per category applied to a month
SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) =1) AS Perc_Total_Sales_per_Cat
FROM pizza_sales 
WHERE MONTH(order_date) =1
GROUP BY  pizza_category

--Percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price)*100 / (SELECT SUM(total_price) FROM pizza_sales) AS  DECIMAL(10,2)) PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

--TOP 5 Best seller by Revenue, Quantity and Orders
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Rev FROM pizza_sales 
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quant FROM pizza_sales 
GROUP BY pizza_name
ORDER BY  SUM(quantity) DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales 
GROUP BY pizza_name
ORDER BY  SUM(order_id) DESC