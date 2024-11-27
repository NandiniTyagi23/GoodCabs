#City-level fare and trip summary report 
SELECT 
      dc.city_name, 
      COUNT(trip_id) AS total_trips, 
      ROUND((SUM(fare_amount)/SUM(distance_travelled_km)),1) AS avg_fare_per_km,
      ROUND((SUM(fare_amount)/COUNT(trip_id)),1) AS avg_fare_per_trip,
      ROUND(Count(trip_id)*100/(select count(trip_id) from fact_trips),1) AS total_trips_cont_pct 
FROM fact_trips ft
JOIN dim_city dc
     ON  dc.city_id = ft.city_id
GROUP BY ft.city_id
ORDER BY total_trips_cont_pct DESC


