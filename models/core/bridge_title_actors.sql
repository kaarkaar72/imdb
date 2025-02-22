{{
    config(
        materialized='table'
    )
}}

SELECT
    title_id,
    name_id,
    TRIM(characters) as character_name
FROM {{ ref('stg_title_principals') }}
Where category = 'actor'
