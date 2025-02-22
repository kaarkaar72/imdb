{{
    config(
        materialized='table'
    )
}}

SELECT
    title_id,
    TRIM(writer_id) as writer_id
FROM {{ ref('stg_title_crew') }}, UNNEST(writers) AS writer_id
WHERE writer_id is not null
