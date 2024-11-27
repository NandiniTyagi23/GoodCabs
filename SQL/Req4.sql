#Cities with highest and lowest Total New Passengers

WITH city_ranking AS (
SELECT 
      city_name, 
      total_passengers,
      DENSE_RANK() OVER(order by total_passengers desc) AS top_ranking,
      DENSE_RANK() over(order by total_passengers asc) AS bottom_ranking 
FROM fact_passenger_summary fps
JOIN dim_city dc 
     ON fps.city_id = dc.city_id
GROUP BY fps.city_id
)

SELECT 
      city_name, 
      total_passengers, 
CASE 
    WHEN top_ranking <=3 then 'Top 3'
    WHEN bottom_ranking <=3 then 'Bottom 3'
    ELSE NULL
END AS city_category
FROM city_ranking
WHERE top_ranking <=3 OR bottom_ranking <=3
ORDER BY total_passengers DESC     



