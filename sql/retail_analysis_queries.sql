-- =========================================
-- Retail Sales Analysis - SQL Queries
-- =========================================


-- 1. Total Revenue Generated

SELECT SUM(purchase_amount) AS total_revenue 
FROM customer_shopping;


-- 2. Revenue Contribution by Gender

SELECT 
    gender,
    SUM(purchase_amount) AS total_revenue,
    ROUND(
        SUM(purchase_amount) * 100.0 /
        (SELECT SUM(purchase_amount) FROM customer_shopping),
        2
    ) AS revenue_percentage
FROM customer_shopping
GROUP BY gender
ORDER BY total_revenue DESC;


-- 3. Percentage of Purchases Made Using Discounts

SELECT 
	ROUND(
		SUM(CASE
				WHEN discount_applied = 'Yes' THEN 1
                ELSE 0 
			END
            ) * 100.0 / COUNT(*), 2 
) AS customers_percentage_applied_discount
 FROM customer_shopping;
 

-- 4. Average Order Value: Discount vs Non-Discount

SELECT discount_applied,
ROUND(AVG(purchase_amount), 2) AS avg_order_value
FROM customer_shopping
GROUP BY discount_applied;


-- 5. Revenue Contribution: Discounted vs Non-Discounted

SELECT discount_applied, SUM(purchase_amount) AS total_revenue,
ROUND(
	SUM(purchase_amount) * 100.0 /
    (SELECT SUM(purchase_amount) FROM customer_shopping), 2
) AS revenue_percentage
FROM customer_shopping
GROUP BY discount_applied;


-- 6. Top 5 Products by Total Revenue

 SELECT item_purchased, SUM(purchase_amount) AS total_revenue
 FROM customer_shopping
 GROUP BY item_purchased
 ORDER BY  total_revenue DESC
 LIMIT 5;
 

-- 7. Top 5 Most Frequently Purchased Products
 
 SELECT item_purchased, COUNT(*) AS total_orders
 FROM customer_shopping
 GROUP BY item_purchased
 ORDER BY total_orders DESC
 LIMIT 5;


-- 8. Relationship Between Product Rating and Purchases

SELECT item_purchased,
ROUND(AVG(review_rating), 2) AS avg_rating,
COUNT(*) AS total_orders
FROM customer_shopping
GROUP BY item_purchased
ORDER BY total_orders DESC;


-- 9. Average Order Value by Shipping Type average than Standard shipping customers

SELECT shipping_type, ROUND(AVG(purchase_amount), 2)
 AS avg_order_value
FROM customer_shopping
GROUP BY shipping_type
ORDER BY  avg_order_value DESC;


-- 10. Revenue Contribution by Shipping Method

SELECT shipping_type, SUM(purchase_amount) AS total_revenue,
ROUND(
		SUM(purchase_amount) * 100.0 / 
        (SELECT SUM(purchase_amount) FROM customer_shopping),2) 
        AS revenue_percentage
FROM customer_shopping
GROUP BY shipping_type
ORDER BY total_revenue DESC;


-- 11. Customer Segmentation Based on Previous Purchases

SELECT 
	CASE 
		WHEN previous_purchases = 0 THEN 'New'
        WHEN previous_purchases BETWEEN 1 AND 5 THEN 'Returning'
        ELSE 'Loyal'
	END AS customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(purchase_amount) AS total_revenue,
    ROUND(
		SUM(purchase_amount) * 100.0 /
        (SELECT SUM(purchase_amount) FROM customer_shopping),2
    ) AS revenue_percentage
FROM customer_shopping
GROUP BY customer_segment
ORDER BY total_revenue DESC;


-- 12. Revenue Contribution by Age Group

SELECT age_group, SUM(purchase_amount) AS total_revenue ,
ROUND(
	SUM(purchase_amount) *100.0 /
    (SELECT SUM(purchase_amount) FROM customer_shopping), 2
) AS revenue_percentage
FROM customer_shopping
GROUP BY age_group
ORDER BY total_revenue DESC;


-- 13. Average Order Value by Age Group

SELECT age_group , ROUND(AVG(purchase_amount),2) AS avg_order_value
FROM customer_shopping
GROUP BY age_group
ORDER BY avg_order_value DESC;

