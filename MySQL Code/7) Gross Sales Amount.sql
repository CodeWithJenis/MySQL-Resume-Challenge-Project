/* 7.  Get the complete report of the Gross sales amount for the customer  “Atliq 
Exclusive”  for each month  .  This analysis helps to  get an idea of low and 
high-performing months and take strategic decisions. 
The final report contains these columns: 
Month 
Year 
Gross sales Amount */

SELECT 
    MONTH(fsm.date) AS Month,
    YEAR(fsm.date) AS Year,
    SUM(fsm.sold_quantity * fgp.gross_price) AS `Gross sales Amount`
FROM fact_sales_monthly fsm
JOIN fact_gross_price fgp 
    ON fsm.product_code = fgp.product_code 
   AND fsm.fiscal_year = fgp.fiscal_year
JOIN dim_customer dc 
    ON fsm.customer_code = dc.customer_code
WHERE dc.customer = 'Atliq Exclusive'
GROUP BY MONTH(fsm.date), YEAR(fsm.date)
ORDER BY YEAR(fsm.date), Month;
