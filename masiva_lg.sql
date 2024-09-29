
--- Generar el campo masivo_lg

SELECT calls_ivr_id  
   , MAX(CASE 
        WHEN module_name = 'AVERIA_MASIVA' THEN 1
        ELSE 0
    END) AS masiva_lg
FROM `keepcoding.ivr_detail`
GROUP BY calls_ivr_id;

--- En la columna module_name hemos cogido donde pone AVERIA_MASIVA le hemos asignado el valor del flag 1 y sino 0, y lo hemos devuelto en una nueva columna masiva_lg, por cada llamada, usamos el MAX para que en caso de que haya mismas filas para la misma llamada, nos asegura que si alguna fila tiene "AVERIA_MASI", el valor de masiva_lg sea 1, sino 0