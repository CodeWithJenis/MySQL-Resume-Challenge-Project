/* 
4. Follow-up: Which segment had the most increase in unique products in 
2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference */

  WITH product_counts AS (
  SELECT 
	segment,
    COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN fsm.product_code END) AS product_count_2020,
    COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN fsm.product_code END) AS product_count_2021
  FROM fact_sales_monthly fsm
  JOIN dim_product dp
    ON fsm.product_code = dp.product_code
  GROUP BY segment
)
SELECT 
  segment,
  product_count_2020,
  product_count_2021,
  (product_count_2021 - product_count_2020) AS difference
FROM product_counts
ORDER BY difference DESC;
