show databases;
use da_1;

show tables;

create table sales_Data(
Order_ID varchar(14),
Order_Date text, 
Ship_Date text, 
Ship_Mode varchar(14), 
Customer_ID varchar(8), 
Customer_Name varchar(22), 
Segment varchar(11), 
Country_Region varchar(13), 
City varchar(17), 
State_Province varchar(25),
Postal_Code varchar(5), 
Region varchar(7),
Product_ID varchar(15), 
Category varchar(15), 
Sub_Category varchar(11), 
Product_Name varchar(127) ,
Sales decimal(9,4), 
Quantity int ,
Profit decimal(10,4)
);

-- Import Data
 
select * from sales_Data;

-- 1. How many records are present in the dataset?
SELECT COUNT(*) AS total_records
FROM sales_data;

-- 2. How many unique orders are there?
SELECT count(distinct(Order_ID)) AS total_orders 
FROM sales_data;

-- 3. What is the total sales generated?
SELECT round(SUM(Sales),2) AS total_sales
FROM sales_data;

-- 4. What is the total profit?
SELECT ROUND(SUM(Profit), 2) AS total_profit
FROM sales_data;

-- 5. What is the overall profit margin?
SELECT ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS profit_margin
FROM sales_data;

-- 6. Which product category generates the highest sale?
SELECT Category,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Category
ORDER BY Total_Sales DESC
limit 1;

-- 7. Which category generates the highest profit?
SELECT Category,SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Category
ORDER BY Total_Profit DESC
limit 1;

-- 8. Which region has the highest sales?
SELECT Region,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC
limit 1;

-- 9. Which region has the lowest profit?
SELECT Region,SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Region
ORDER BY Total_Profit ASC
limit 1;

-- 10. Which customer generated the highest sales?
SELECT Customer_Name,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 1;

-- 11. Which product generated the highest sales?
SELECT Product_Name,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 1;

-- 12. Which sub-category generated the highest sales?
SELECT Sub_Category,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Sub_Category
ORDER BY Total_Sales DESC
LIMIT 1;

-- 13. Which sub-category has the lowest profit?
SELECT Sub_Category,SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Sub_Category
ORDER BY Total_Profit ASC
LIMIT 1;

-- 14. Which state has the highest sales?
SELECT State_Province,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY State_Province
ORDER BY Total_Sales DESC
LIMIT 1;

-- 15. Which shipping mode is used most and generates the highest sales?
SELECT Ship_Mode,COUNT(*) AS Number_of_Records,SUM(Sales) AS Total_Sales
FROM sales_data
GROUP BY Ship_Mode
ORDER BY Total_Sales DESC;

-- 16. Which sub-categories are loss-making?
SELECT Sub_Category,SUM(Sales) AS Total_Sales,SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-- 17. Customer_ID wise ranking dya
select *, dense_rank() over(partition by Customer_ID order by Profit desc ) as RNK from Sales_data 
order by Customer_ID;

-- 18. Which city generated the highest sales?
SELECT City,ROUND(SUM(Sales), 2) AS Total_Sales
FROM sales_data
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 1;

-- 19. Rank products based on total sales
SELECT Product_Name,SUM(Sales) AS Total_Sales, RANK() OVER(ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM sales_data
GROUP BY Product_Name
ORDER BY Sales_Rank;

-- 20. Find each customer's sales and compare them with the previous customer
SELECT Customer_Name,SUM(Sales) AS Total_Sales,LAG(SUM(Sales)) OVER(ORDER BY SUM(Sales) DESC) AS Previous_Customer_Sales
FROM sales_data
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
