
-- criação de janelas: criar calculos ou modelagem de dentro de agregações de dados
SELECT 
DATE(pickup_datetime) AS dia,
COUNT(*) AS total_corridas,
RANK() OVER (ORDER BY COUNT(*) DESC ) AS ranking
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2018`
WHERE
  pickup_datetime BETWEEN '2018-01-01' AND '2018-01-31'
GROUP BY  dia
ORDER BY total_corridas desc;

-- janelas utilizando o LAG - te permite olhar para trás, ou linhas anteriores x CTE(common table expression - criar subconsultas, para reutilizar) 
--criar uma CTE com janelas para calcular o resumo de corridas por dia

WITH total_corrida_por_dia as(
  SELECT 
  DATE(pickup_datetime) AS dia,
  COUNT(*) AS total_corridas,
  FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2018`
  WHERE
    pickup_datetime BETWEEN '2018-01-01' AND '2018-01-31'
  GROUP BY  dia
)
SELECT 
dia,
total_corridas,
LAG(total_corridas) OVER (ORDER BY dia) as dia_anterior,
total_corridas - LAG(total_corridas) OVER (ORDER BY dia) AS diferenca
FROM total_corrida_por_dia;


