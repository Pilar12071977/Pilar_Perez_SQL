-- Generar el campo customer_phone 

SELECT DISTINCT calls_ivr_id
      ,COALESCE(MAX(calls_phone_number), 'UNKNOWN') AS calls_phone_number
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id;

-- Esta consulta devuelve un registro único por cada llamada con un único número de teléfono, y si no lo tiene te devuelve un UNKNOWN