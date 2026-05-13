CREATE DATABASE Churn_analysis;
USE Churn_analysis;

SELECT * FROM telecom_data;

#1 what is the total number of customers,active customers,and churend customers.
SELECT COUNT(*) AS Total_customers,
       SUM(CASE WHEN customer_status = 'Stayed' THEN 1 ELSE 0 END) AS Active_customers,
       SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS Churned_customers
FROM telecom_data;


#2 What is the overall churn rate of customers.
SELECT COUNT(*) AS Total_customers,
	COUNT(CASE WHEN customer_status = 'Churned' THEN 1 END) * 100/COUNT(*)
    AS Churned_customers_rate
    FROM telecom_data;

    
#3 What is the average monthly charge and total revenue generated.
SELECT ROUND(AVG(monthly_charge),2) as Average_monthly_charges, 
ROUND(SUM(total_revenue),2) AS Total_revenue_generated 
FROM telecom_data;

#4 Which age group churns the most.

SELECT Age_group,Total_customers,Churned_customers,
Churned_customers *100/Total_customers AS Churn_rate_percentage
        FROM 
			(SELECT
				CASE
					WHEN age BETWEEN 15 AND 25 THEN '15-25'
                    WHEN age BETWEEN 26 AND 40 THEN '26-40'
                    WHEN age BETWEEN 41 AND 51 THEN '41-51'
                    ELSE '51+'
                    END AS Age_group,
                    COUNT(*) AS Total_customers,
                    SUM(CASE
						WHEN customer_status = 'Churned' THEN 1 ELSE 0
                        END) AS Churned_customers
                    FROM telecom_data
                    GROUP BY Age_group) AS S
                    ORDER BY Churn_rate_percentage DESC;


#5 Which gender has the highest churn rate.
SELECT gender,total_customers,Churned_customers,
ROUND(Churned_customers*100/total_customers,2) AS Churned_customers_rate
	FROM
		(SELECT Gender,
			    COUNT(*) AS total_customers,
			SUM(CASE
				WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) 
                AS Churned_customers
                FROM telecom_data
                GROUP BY gender) AS S
                ORDER BY Churned_customers_rate DESC;
                
                
#6 Do married customers churn less than unmarried customers.
SELECT married,total_customers,Churn_customers,
Churn_customers * 100/total_customers AS Total_churn_rate
	FROM
		(SELECT 
			married,
			COUNT(*) AS total_customers,
			SUM(CASE 
				WHEN customer_status = 'Churned' THEN 1 ELSE 0 END)
                AS Churn_customers
                FROM telecom_data
                GROUP BY married) as t;
                
                
#7 Which internet service type has the highest churn rate(DSL/FIBER/CABLE).
SELECT internet_type,total_customers,churn_customers,
churn_customers * 100/total_customers AS Churn_rate
	FROM 
		(SELECT
         internet_type,
         COUNT(*) AS total_customers,
         SUM(CASE
			WHEN customer_status = 'Churned' THEN 1 ELSE 0 END)
                AS churn_customers
			FROM telecom_data
            GROUP BY internet_type) AS t
            ORDER BY Churn_rate DESC LIMIT 1;
            
        
        
#8 Which payment method has the highest churn rate.
SELECT payment_method,total_customers,churn_customers,
churn_customers * 100/total_customers AS Churn_rate
	FROM 
		(SELECT
         payment_method,
         COUNT(*) AS total_customers,
         SUM(CASE
			WHEN customer_status = 'Churned' THEN 1 ELSE 0 END)
                AS churn_customers
			FROM telecom_data
            GROUP BY payment_method) AS t
            ORDER BY Churn_rate DESC;
            
		
        
#9 Which contract type has the highest churn rate.
SELECT contract,total_customers,churn_customers,
churn_customers * 100/total_customers AS Churn_rate
	FROM 
		(SELECT
         contract,
         COUNT(*) AS total_customers,
         SUM(CASE
			WHEN customer_status = 'Churned' THEN 1 ELSE 0 END)
                AS churn_customers
			FROM telecom_data
            GROUP BY contract) AS t
            ORDER BY Churn_rate DESC LIMIT 1;
            
            
#10 How much Total revenue is lost from the churned customers.
SELECT COUNT(*) AS Churned_customers,
ROUND(SUM(total_revenue),2) as total_revenue_lost
from telecom_data WHERE customer_status = 'Churned';


#11 Which cities have the highest churn count or churn rate.
SELECT COUNT(*) AS Churn_count,
city FROM telecom_data
WHERE customer_status = 'Churned'
GROUP BY city ORDER BY Churn_count DESC LIMIT 5;


#12 What are the top Churn categories and churn reasons.
SELECT count(*) AS Churn_customers,churn_category
FROM telecom_data
WHERE customer_status = 'Churned'
GROUP BY churn_category LIMIT 3;


SELECT count(*) AS Churn_customers,churn_reason
FROM telecom_data
WHERE customer_status = 'Churned'
GROUP BY churn_reason LIMIT 3;


    





   
