CREATE OR REPLACE TABLE keepcoding.ivr_summary AS
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

SELECT detail.calls_ivr_id AS ivr_id
      ,detail.calls_phone_number AS phone_number
      ,detail.calls_ivr_result AS ivr_result
      , CASE 
          WHEN detail.calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
          WHEN detail.calls_vdn_label LIKE 'TECH%' THEN 'TECH'
          WHEN detail.calls_vdn_label LIKE 'ABSORPTION%' THEN 'ABSORPTION'
                        ELSE 'RESTO'
          END AS vdn_aggegation
      ,detail.calls_start_date AS start_date
      ,detail.calls_end_date AS end_date
      ,detail.calls_total_duration AS total_duration
      ,detail.calls_customer_segment AS customer_segment
      ,detail.calls_ivr_language AS ivr_language
      ,detail.step_module_sequece AS steps_module
      ,detail.calls_module_aggregation AS module_aggregation
      ,COALESCE(MAX(detail.step_document_type), 'UNKNOWN') AS document_type
      ,COALESCE(MAX(detail.step_document_identification), 'UNKNOWN') AS document_identification
      ,COALESCE(MAX(detail.step_billing_account_id), 'UNKNOWN') AS billing_account_id
      ,MAX(CASE 
        WHEN detail.module_name = 'AVERIA_MASIVA' THEN 1
        ELSE 0
      END) AS masiva_lg
      ,MAX(CASE 
               WHEN (detail.step_name = 'CUSTOMERINFOBYDNI.TX' AND detail.step_result = 'OK') THEN 1
               ELSE 0
           END) AS info_by_phone_lg
      ,MAX(CASE 
               WHEN (detail.step_name = 'CUSTOMERINFOBYDNI.TX' AND detail.step_result = 'OK') THEN 1
               ELSE 0
           END) AS info_dni_lg
      ,anterior.repeated_phone_24H AS repeated_phone_24H
      ,siguiente.cause_recall_phone_24H AS cause_recall_phone_24H