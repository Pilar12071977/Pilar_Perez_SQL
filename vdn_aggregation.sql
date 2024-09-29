
-- Generar el campo vdn_aggregation

SELECT DISTINCT calls_ivr_id 
      , CASE 
          WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
          WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
          WHEN calls_vdn_label LIKE 'ABSORPTION%' THEN 'ABSORPTION'
                        ELSE 'RESTO'
          END AS vdn_aggegation
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id, vdn_aggegation

--- Por cada llamada (no duplicada), hacemos una generalización del campo vdl_label. Si vdn_label empieza por ATC pondremos FRONT, si empieza por TECH pondremos TECH si es ABSORPTION dejaremos ABSORPTION y si no es ninguna de las anteriores pondremos RESTO.