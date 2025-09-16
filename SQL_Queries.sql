-- CHECKING THE DATA 

-- SELECT * FROM `dataco-supply-chain-471606.2.datatable` LIMIT 10;

-- 1. Which customers have placed the highest number of orders?

-- SELECT customer_id, customer_fname, customer_lname, COUNT(order_id) AS Order_count
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY customer_id, customer_fname, customer_lname
-- HAVING COUNT(*) > 1
-- ORDER BY Order_count DESC
-- LIMIT 25;

-- 2. What is the average order value per customer segment (e.g., Consumer, Corporate, Home Office)?

-- SELECT customer_segment, CONCAT('$',ROUND(AVG(order_item_total),2)) AS average_order_value
-- FROM `2.datatable`
-- GROUP BY customer_segment

-- 3. Which regions/countries have the most orders and highest sales revenue?
-- Most Orders

-- SELECT order_country, COUNT(*) AS Number_of_Orders
-- FROM `2.datatable`
-- GROUP BY order_country
-- ORDER BY Number_of_Orders DESC
-- LIMIT 5;

-- Highest Sales

-- SELECT order_country, CONCAT('$',ROUND(SUM(Sales),2)) AS total_sales
-- FROM `2.datatable`
-- GROUP BY order_country
-- ORDER BY total_sales DESC
-- LIMIT 5;

-- 4. What percentage of orders are delivered late, and which regions face the most delays?

-- SELECT 
--   CONCAT(ROUND(SUM(CASE WHEN late_delivery_risk = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2),'%') AS late_order_perc
-- FROM `2.datatable`;

-- SELECT order_region,
-- CONCAT(ROUND(SUM(CASE WHEN late_delivery_risk = 1 THEN 1 ELSE 0 END) * 100.0 / 
-- (SELECT COUNT(*) FROM `dataco-supply-chain-471606.2.datatable`), 2),'%') AS late_order_perc
-- FROM `2.datatable`
-- GROUP BY order_region
-- ORDER BY late_order_perc DESC

-- 5. Which product categories generate the most sales and profit?

-- SELECT category_name, CONCAT('$',ROUND(SUM(Sales),2)) AS Total_sales, 
--        ROUND(SUM(order_profit_per_order),2) AS Total_Profit
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY category_name
-- ORDER BY Total_Profit DESC
-- LIMIT 10;

-- 6. What are the top 10 best-selling products overall?

-- SELECT product_name, COUNT(*) AS Number_of_Orders, category_name
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY product_name, category_name
-- ORDER BY Number_of_Orders DESC
-- LIMIT 10;

-- 7. Which products have the highest and lowest return rates?



