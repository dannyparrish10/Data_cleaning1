-- How does customer spending vary between genders?
SELECT
Count(CASE WHEN c.age is NOT NULL THEN 1 END ) AS Count_people,
CASE WHEN c.age <= 25 THEN "youngins " 
WHEN c.age BETWEEN 25 AND 45  THEN  "meddle age"
ELSE " old folks" 
END AS Age_category ,
ROUND(AVG(s.price) ,2) AS price
FROM `Practice project`.customer_data AS c
INNER JOIN `Practice project`.sales_data AS s 
ON c.customer_id =s.customer_id
GROUP BY Age_category
ORDER BY Price DESC;
-- What is the average transaction amount for each payment method (Credit Card, Debit Card, Cash)?

SELECT ROUND(AVG( s.price),02) AS price, 
c.payment_method
FROM `Practice project`.customer_data AS c
INNER JOIN `Practice project`.sales_data AS S
ON c.customer_id =s.customer_id
GROUP BY c.payment_method;
-- Do malls with more stores tend to have higher revenues?

SELECT 
m.shopping_mall AS shopping_mall ,
m.store_count AS NUM_stores,
ROUND(SUM(s.price),0) AS price, 
ROUND(SUM(s.price)/ m.store_count,0) AS Average_revenue_per_store
FROM `Practice project`.shopping_mall_data AS m
INNER JOIN `Practice project`.sales_data AS s 
ON m.shopping_mall = s.shopping_mall
GROUP BY m.shopping_mall,m.store_count
ORDER BY price DESC;


-- Are certain malls more popular among specific demographics (e.g., age, gender)?-- failed 
SELECT 
CASE WHEN c.age <=25 THEN 'young'
WHEN c.age BETWEEN 25 AND 45 THEN 'middle age'
ELSE "Older people" 
END AS Age_category,
ROUND(SUM(s.price),0) AS price
FROM `Practice project`.customer_data AS c
INNER JOIN `Practice project`.sales_data AS s
ON c.customer_id = s.customer_id
GROUP BY Age_category
ORDER BY price DESC;



-- Are certain payment methods linked to higher transaction amounts?

CREATE VIEW  Retail_sales_data AS 
SELECT  c.age, c.gender, c.payment_method, s.customer_id, s.quantity, s.price, m.shopping_mall, m.construction_year, m.location, m.store_count
FROM `Practice project`.customer_data c
INNER JOIN `Practice project`.sales_data  AS s ON c.customer_id = s.customer_id
INNER JOIN `Practice project`.shopping_mall_data AS m ON s.shopping_mall = m.shopping_mall;


SELECT * 
FROM Retail_sales_data;

-- Are certain payment methods linked to higher transaction amounts?
SELECT payment_method,
 ROUND(SUM(price),0)  AS price 
FROM Retail_sales_data
GROUP BY payment_method,gender
ORDER BY price DESC;

-- How does payment method preference vary by age group?
SELECT CASE
WHEN age <= 25 THEN 'young'
WHEN age BETWEEN 25 AND 45 THEN 'middle age'
ELSE 'old' END AS age_category,payment_method,
 COUNT(*) AS count,
ROW_NUMBER() OVER (PARTITION BY payment_method ORDER BY COUNT(*) DESC) AS top 
FROM Retail_sales_data
GROUP BY
CASE WHEN age <= 25 THEN 'young'
WHEN age BETWEEN 25 AND 45 THEN 'middle age'
ELSE 'old' END,payment_method
ORDER BY age_category, count DESC;





