--- Generar el campo  info_by_phone_lg

WITH info_by_phone AS (
    SELECT calls_ivr_id,
           calls_phone_number,
           MAX(CASE 
               WHEN (step_name = 'CUSTOMERINFOBYDNI.TX' AND step_result = 'OK') THEN 1
               ELSE 0
           END) AS info_by_phone_lg
    FROM `keepcoding.ivr_detail`
    GROUP BY calls_ivr_id, calls_phone_number
)
SELECT calls_ivr_id, calls_phone_number, info_by_phone_lg
FROM info_by_phone;




--- he cogido la columna step_name y setp result y donde coincidan los campos 'CUSTOMERINFOBYDNI.TX' y 'OK', hemos puesto un flag 1, sino un 0