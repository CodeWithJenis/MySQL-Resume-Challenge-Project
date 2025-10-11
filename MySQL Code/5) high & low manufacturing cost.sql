/* 5.  Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, 
product_code 
product 
manufacturing_cost */

SELECT 
    dp.product_code,
    dp.product,
    fmc.manufacturing_cost
FROM fact_manufacturing_cost fmc
JOIN dim_product dp 
    ON fmc.product_code = dp.product_code
WHERE fmc.manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost)
   OR fmc.manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost);




