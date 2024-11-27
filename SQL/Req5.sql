#Month with highest Revenue for wach city

WITH city_ranking as (
SELECT
      ft.city_id,
      MONTHNAME(date) AS month , 
      SUM(fare_amount) as revenue,
      RANK() OVER(PARTITION BY city_id ORDER BY SUM(fare_amount) DESC) AS ranking
FROM fact_trips ft 
GROUP BY city_id, month
ORDER BY ranking)

SELECT 
      city_name, 
      month, 
      CONCAT(ROUND((revenue)/1000000,3), 'M') as revenue, 
      CONCAT(ROUND(revenue*100/sum(fare_amount),2), '%') as cont_pct
FROM fact_trips ft
JOIN dim_city dc
     ON ft.city_id = dc.city_id
JOIN city_ranking cr 
     ON ft.city_id = cr.city_id
WHERE ranking =1
GROUP BY ft.city_id
ORDER BY revenue DESC
 
