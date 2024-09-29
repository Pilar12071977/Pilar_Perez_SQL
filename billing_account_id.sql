-- Generar el campo billing_account_id

SELECT DISTINCT calls_ivr_id
      ,COALESCE(MAX(step_billing_account_id), 'UNKNOWN') AS billing_account_id
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id;
-- Esta consulta devuelve un registro único por cada llamada con un único billing_account_id, si no lo tiene devueve un UNKNON