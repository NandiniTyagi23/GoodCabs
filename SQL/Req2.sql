#Monthly city-level trips target performance report

WITH monthly_performance AS(
SELECT 
      ft.city_id, 
      city_name, 
      ft.date, 
      month_name, 
      COUNT(DISTINCT(trip_id)) AS actual_trips 
FROM fact_trips ft
JOIN dim_city dc 
     ON ft.city_id = dc.city_id
JOIN dim_date dd 
     ON ft.date = dd.date
GROUP BY city_name, month_name
)

SELECT 
      city_name, 
      monthname(mp.date) AS month_name, 
      actual_trips, 
      total_target_trips,
CASE
    WHEN actual_trips > total_target_trips THEN 'Above Target'
    ELSE 'Below Target'
END AS performance_status,
      CONCAT(ROUND((actual_trips - total_target_trips) *100 / total_target_trips, 2), '%') AS diff_pct
FROM targets_db.monthly_target_trips tt
JOIN monthly_actual ma 
     ON ma.city_id = tt.city_id
GROUP BY city_name, month_name 
ORDER BY city_name, ma.date 
