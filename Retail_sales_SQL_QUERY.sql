SELECT * FROM public.retail_sales
ORDER BY transactions_id ASC 

--DATA CLEANING PROCESS

SELECT * FROM retail_sales
WHERE 
 transactions_id IS NULL
 OR
 sale_date IS NULL
 OR
 sale_time IS NULL
 OR
 customer_id IS NULL
 OR
 gender IS NULL
 OR
 age IS NULL
 OR
 category IS NULL
 OR
 quantiy IS NULL
 OR
 price_per_unit IS NULL
 OR
 cogs IS NULL
 OR
 total_sale IS NULL

SELECT COUNT(*) FROM retail_sales

DELETE  FROM retail_sales
WHERE 
 transactions_id IS NULL
 OR
 sale_date IS NULL
 OR
 sale_time IS NULL
 OR
 customer_id IS NULL
 OR
 gender IS NULL
 OR
 age IS NULL
 OR
 category IS NULL
 OR
 quantiy IS NULL
 OR
 price_per_unit IS NULL
 OR
 cogs IS NULL
 OR
 total_sale IS NULL

SELECT COUNT(*) FROM retail_sales

SELECT * FROM retail_sales
WHERE 
 transactions_id IS NULL
 OR
 sale_date IS NULL
 OR
 sale_time IS NULL
 OR
 customer_id IS NULL
 OR
 gender IS NULL
 OR
 age IS NULL
 OR
 category IS NULL
 OR
 quantiy IS NULL
 OR
 price_per_unit IS NULL
 OR
 cogs IS NULL
 OR
 total_sale IS NULL

 --DATA  EXPLORATION

 --How many sales we have?

 SELECT COUNT(*) AS total_sales FROM retail_sales

 SELECT COUNT(customer_id) AS total_sale FROM retail_sales

 SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales

 SELECT DISTINCT category FROM retail_sales

--DATA ANALYSIS - BUSINESS KEY PROBLEMS & ANSWERS

--My Analysis & Findings

--Q.1. Write a SQL query to retrive all columns for sales made on "2022-11-05".
--Q.2. Write a SQL query to retrive all transactions by "Female" where the category is "Clothing" with quantity greater than  or equal to 4.
--Q.3. Write a SQL query to calculate the total sales (total_sale) for each category.
--Q.4. Write a SQL query to find the average age of customers who purchased items from the "Beauty" category.
--Q.5. Write a SQL query to find all transactions where ther total_sale is greater than 1000.
--Q.6. Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.
--Q.7. Write a SQL query to calculate the average sale for each month, find out best selling month in each year.
--Q.8. Write a SQL query to find the top 5 customers based oh highest total sales.
--Q.9. Write a SQL query to find the number of unique customers who purchased items from each category.
--Q.10. Write a SQL query to create each shift and numbers of order (Example Morning<=12, Afternoon between 12&17, Evening>17).

--Q.1. Write a SQL query to retrive all columns for sales made on "2022-11-05".

SELECT * 
FROM retail_sales
WHERE sale_date= '2022-11-05 ';

--Q.2. Write a SQL query to retrive all transactions by" Female" where the category is "Clothing" with quantity greater than or equal to 4.

SELECT * FROM retail_sales

WHERE category='Clothing'
AND quantiy >=4
AND gender= 'Female' 

--Q.3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
    category,
    SUM(total_sale) AS total_category_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY total_category_sale DESC;

--Q.4. Write a SQL query to find the average age of customers who purchased items from the "Beauty" category.

 
SELECT 
  AVG (age) AS avg_customer_age
FROM retail_sales
WHERE category= 'Beauty';

--Q.5. Write a SQL query to find all transactions where ther total_sale is greater than 1000.

SELECT * 
 FROM retail_sales
 WHERE total_sale >1000;

--Q.6. Write a SQL query to find the total number of transactions(transactions_id) made by each gender in each category.

 SELECT  
  category,
  gender,
  COUNT(transactions_id) AS total_transactions
 FROM retail_sales
 GROUP BY category,gender
 ORDER BY category,gender

--Q.7. Write a SQL query to calculate the average sale for each month, find out best selling month in each year.
 
SELECT* FROM
(
   SELECT
      EXTRACT (YEAR FROM sale_date)AS year,
      EXTRACT (month FROM sale_date) AS month, 
      AVG (total_sale) AS avg_sales,
      RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date)ORDER BY AVG (total_sale) DESC)
   FROM retail_sales
   GROUP BY year,month
)AS t1
WHERE rank=1
--ORDER BY year,avg_sales DESC


 --Q.8. Write a SQL query to find the top 5 customers based oh highest total sales.

 SELECT
    customer_id,
	SUM(total_sale) AS total_spent
	FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

--Q.9. Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
  category,
  COUNT(DISTINCT customer_id) AS unique_customers
 FROM retail_sales
 GROUP BY category

--Q.10. Write a SQL query to create each shift and numbers of order (Example Morning<=12, Afternoon between 12&17, Evening>17).
 
SELECT
  CASE
   WHEN EXTRACT (HOUR FROM sale_time) <=12 THEN 'Morning'
   WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
   ELSE 'Evening'
  END AS Shift,
   COUNT(transactions_id) AS total_orders
FROM retail_sales
GROUP BY shift
ORDER BY total_orders DESC;

--END OF PROJECT
 

 
