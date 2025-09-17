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
-- Highest Returns
-- SELECT product_name, ROUND(AVG(order_profit_per_order),2) AS Average_Profit
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY product_name
-- ORDER BY Average_Profit DESC
-- LIMIT 7;

-- Lowest Returns
-- SELECT product_name, ROUND(AVG(order_profit_per_order),2) AS Average_Profit
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY product_name
-- ORDER BY Average_Profit 
-- LIMIT 7;

-- 8. Which products have the longest delivery times?

-- SELECT product_name, category_name, 
-- CONCAT(ROUND(AVG(days_for_shipping_real),2),' Days') AS Average_Delivery_Time
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY product_name, category_name
-- ORDER BY Average_Delivery_Time DESC
-- LIMIT 10;

-- 9. What is the average shipping cost per region and per shipping mode?

-- SELECT order_region, shipping_mode, 
--       AVG(order_item_total - order_profit_per_order) AS Avg_Shipping_Cost
-- FROM `dataco-supply-chain-471606.2.datatable`
-- WHERE order_region = 'Central America' OR order_region = 'Western Europe' 
--       OR order_region = 'Southeast Asia' OR order_region = 'Oceania' 
--       OR order_region = 'East Africa'
-- GROUP BY shipping_mode, order_region
-- ORDER BY order_region;

-- 10. Which shipping mode is fastest vs. most expensive?

-- SELECT shipping_mode, ROUND(AVG(days_for_shipping_real),2) AS Avg_shipping_time, 
--        ROUND(AVG(sales - order_profit_per_order),2) AS Avg_Shipping_Cost
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY shipping_mode
-- ORDER BY Avg_shipping_time;

-- 11. How many orders were delivered late vs. on time?

-- SELECT
--   SUM(CASE WHEN days_for_shipping_real < days_for_shipment_scheduled THEN 1 ELSE 0 END) AS early_delivery,
--   SUM(CASE WHEN days_for_shipping_real = days_for_shipment_scheduled THEN 1 ELSE 0 END) AS on_time_delivery,
--   SUM(CASE WHEN days_for_shipping_real > days_for_shipment_scheduled THEN 1 ELSE 0 END) AS late_delivery
-- FROM `dataco-supply-chain-471606.2.datatable`

-- 12. Which regions experience the highest delivery delays?

-- SELECT order_region, COUNT(*) AS number_of_latedeliveries
-- FROM `dataco-supply-chain-471606.2.datatable`
-- WHERE delivery_status = 'Late delivery'
-- GROUP BY order_region
-- ORDER BY number_of_latedeliveries DESC;

-- 13. Which customers contribute the most profit (Customer Lifetime Value)?

-- SELECT CONCAT(customer_fname,' ',customer_lname) AS Customer_name, ROUND(SUM(order_profit_per_order),2) AS profit_by_customer
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY customer_id, Customer_name
-- ORDER BY profit_by_customer DESC
-- LIMIT 15;

-- 14. Which product categories contribute the least to Sales(Less than 50k)?

-- SELECT category_name, ROUND(SUM(Sales),3) AS Total_Sales
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY category_name
-- ORDER BY Total_Sales
-- LIMIT 18;

-- 15. How do sales, profit, and shipping costs trend over time (monthly)?

-- SELECT
--   FORMAT_DATE('%Y-%m', DATE(order_date_dateorders)) AS month,
--   ROUND(SUM(sales),2) AS total_sales,
--   ROUND(SUM(order_profit_per_order),2) AS total_profit,
--   ROUND(SUM(order_item_total - order_item_profit_ratio),2) AS total_shipping_cost
-- FROM `dataco-supply-chain-471606.2.datatable`
-- GROUP BY month
-- ORDER BY month;

