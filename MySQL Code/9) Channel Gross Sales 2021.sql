/* 9.  Which channel helped to bring more gross sales in the fiscal year 2021 
and the percentage of contribution?  The final output  contains these fields, 
channel 
gross_sales_mln 
percentage 
,((gross_sales_mln)*100/sum(gross_sales_mln)) AS percentage
 */

WITH sales_monthly AS ( 
    SELECT 
        (sold_quantity * gross_price) AS gross_sales,
        customer_code
    FROM fact_sales_monthly fsm
    JOIN fact_gross_price fgp 
        ON fsm.product_code = fgp.product_code 
       AND fsm.fiscal_year = fgp.fiscal_year
    WHERE fsm.fiscal_year = 2021
),
sales_by_channel AS (
    SELECT 
        dc.channel,
        SUM(sm.gross_sales) / 1000000 AS gross_sales_mln
    FROM dim_customer dc
    JOIN sales_monthly sm 
        ON dc.customer_code = sm.customer_code
    GROUP BY dc.channel
)
SELECT 
    channel,
    CONCAT(ROUND(gross_sales_mln, 2),' M') AS gross_sales_mln,
    CONCAT(ROUND((gross_sales_mln * 100.0 / SUM(gross_sales_mln) OVER ()), 2),' %') AS percentage
FROM sales_by_channel
ORDER BY gross_sales_mln ASC;
