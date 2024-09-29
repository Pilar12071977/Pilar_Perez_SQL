WITH anterior_llamada AS (
    SELECT calls_ivr_id
        ,calls_phone_number
        ,calls_start_date
        ,IF( DATETIME_DIFF(calls_start_date,(LAG(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_ivr_id)), MINUTE) <= 1440,1,0) AS    repeated_phone_24H
    FROM `keepcoding.ivr_detail`
    GROUP BY calls_ivr_id, calls_phone_number ,calls_start_date
),
siguiente_llamada AS( 
    SELECT calls_ivr_id
        ,calls_phone_number
        ,calls_start_date
        ,IF( DATETIME_DIFF(calls_start_date,(LEAD(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_ivr_id)), MINUTE) <= 1440,1,0) AS cause_recall_phone_24H 
    FROM `keepcoding.ivr_detail`
    GROUP BY calls_ivr_id, calls_phone_number ,calls_start_date
)
SELECT anterior.calls_ivr_id
    ,anterior.calls_phone_number
    ,anterior.calls_start_date
    ,anterior.repeated_phone_24H
    ,siguiente.cause_recall_phone_24H
    
FROM anterior_llamada anterior
    LEFT 
    JOIN siguiente_llamada siguiente 
        ON anterior.calls_phone_number = siguiente.calls_phone_number
ORDER BY anterior.calls_start_date;
