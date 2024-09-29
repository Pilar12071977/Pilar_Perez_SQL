-- Generar los campos document_type y document_identification

SELECT DISTINCT calls_ivr_id
    ,COALESCE(MAX(step_document_type), 'UNKNOWN') AS document_type
    ,COALESCE(MAX(step_document_identification), 'UNKNOWN') AS document_identification
      
FROM keepcoding.ivr_detail
GROUP BY calls_ivr_id
ORDER BY calls_ivr_id

-- Tenemos un registro por cada llamada obteniendo su tipo de ocumento y su identificacion y si no tiene nada ponemos UNKNOWN