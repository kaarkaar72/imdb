{{
    config(
        materialized='table'
    )
}}

SELECT
    title_id,
    TRIM(director_id) as director_id
FROM {{ ref('stg_title_crew') }}, UNNEST(directors) AS director_id
WHERE director_id is not null
