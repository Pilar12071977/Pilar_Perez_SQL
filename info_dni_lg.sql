--- Generar el campo  info_dni_lg



WITH info_dni_lg AS (
    SELECT calls_ivr_id,
           document_identification,
           MAX(CASE 
               WHEN (step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK') THEN 1
               ELSE 0
           END) AS info_dni_lg
    FROM `keepcoding.ivr_detail`
    GROUP BY calls_ivr_id,  document_identification
)
SELECT calls_ivr_id, document_identification, info_dni_lg
FROM info_dni_lg;

--- he cogido la columna step_name y setp result y donde coincidan los campos 'CUSTOMERINFOBYDNI.TX' y 'OK', hemos puesto un flag 1, sino un 0