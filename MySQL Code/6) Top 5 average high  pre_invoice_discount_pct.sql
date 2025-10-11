/* 6.  Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
customer_code 
customer 
average_discount_percentage */

WITH pre_invoice_deductions AS (
SELECT 
customer_code,AVG(pre_invoice_discount_pct) AS average_discount_percentage
FROM fact_pre_invoice_deductions
WHERE fiscal_year = 2021
GROUP BY customer_code)

SELECT 
pid.customer_code,customer,ROUND(average_discount_percentage,4) AS average_discount_percentage
FROM dim_customer dc
JOIN pre_invoice_deductions pid ON dc.customer_code = pid.customer_code
WHERE market = 'India'
ORDER BY average_discount_percentage DESC LIMIT 5;

