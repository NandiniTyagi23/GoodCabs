#Repeat Passenger Rate analysis

WITH monthly_repeat AS ( 
SELECT 
      city_name,
      month,
      monthname(month) AS month_name , 
      total_passengers, 
      repeat_passengers,
      CONCAT(ROUND((repeat_passengers*100/total_passengers),2), '%') AS monthly_repeat_passenger_rate
FROM fact_passenger_summary fps
JOIN dim_city dc 
     ON fps.city_id = dc.city_id
GROUP BY city_name, month_name
ORDER BY fps.month
),

city_repeat AS (
SELECT 
      city_name, 
      total_passengers, 
      repeat_passengers,  
      CONCAT(round((sum(repeat_passengers)*100/sum(total_passengers)),2), '%') AS city_repeat_passenger_rate
FROM fact_passenger_summary fps
JOIN dim_city dc ON fps.city_id = dc.city_id
GROUP BY city_name
)

SELECT 
       mr.city_name, 
       month_name, 
       mr.total_passengers, 
       mr.repeat_passengers, 
       monthly_repeat_passenger_rate, 
       city_repeat_passenger_rate 
FROM monthly_repeat mr
JOIN city_repeat cr
     ON mr.city_name = cr.city_name
ORDER BY mr.city_name, mr.month     

    






 