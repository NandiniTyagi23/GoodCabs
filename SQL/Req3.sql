# City-Level Repeat Passenger Trip Frequency Report

WITH repeat_passengers AS ( 
SELECT 
      city_name, 
      td.city_id,
      SUM(repeat_passenger_count) AS passenger
FROM dim_repeat_trip_distribution td
JOIN dim_city dc
     ON td.city_id = dc.city_id
GROUP BY city_name)

SELECT 
    city_name,
    ROUND(SUM(CASE 
    WHEN trip_count = '2-Trips' THEN repeat_passenger_count*100/passenger ELSE 0 
    END),2) AS 2_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '3-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 3_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '4-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 4_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '5-Trips' THEN repeat_passenger_count*100/passenger ELSE "0" 
    END),2) AS 5_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '6-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 6_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '7-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 7_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '8-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 8_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '9-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 9_Trips,
    ROUND(SUM(CASE 
    WHEN trip_count = '10-Trips' THEN repeat_passenger_count*100/passenger ELSE '0' 
    END),2) AS 10_Trips
FROM dim_repeat_trip_distribution td
JOIN repeat_passengers rp
     ON rp.city_id = td.city_id
GROUP BY city_name
ORDER BY city_name 
