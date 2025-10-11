/* 10.  Get the Top 3 products in each division that have a high 
total_sold_quantity in the fiscal_year 2021? The final output contains these 
fields, 
division 
product_code 
product 
total_sold_quantity 
rank_order */

WITH sales_monthly AS ( 
    SELECT 
        fsm.product_code,
        SUM(fsm.sold_quantity) AS total_sold_quantity
    FROM fact_sales_monthly fsm
    WHERE fsm.fiscal_year = 2021
    GROUP BY fsm.product_code
),
ranked_products AS (
    SELECT 
        dp.division,
        dp.product_code,
        CONCAT(dp.product,' ',dp.variant) AS product,
        sm.total_sold_quantity,
        RANK() OVER (PARTITION BY dp.division ORDER BY sm.total_sold_quantity DESC) AS rank_order
    FROM dim_product dp
    JOIN sales_monthly sm 
        ON dp.product_code = sm.product_code
    WHERE dp.division IS NOT NULL
)
SELECT *
FROM ranked_products
WHERE rank_order <= 3
ORDER BY division, rank_order;