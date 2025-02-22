{{
    config(
        materialized='view'
    )
}}

SELECT
    tconst AS title_id,
    nconst AS name_id,
    category AS category,
    CASE 
        WHEN job = '\\N' THEN NULL
        ELSE job 
    END AS job,
    CASE 
        WHEN characters = '\\N' THEN NULL
        ELSE TRIM(REGEXP_REPLACE(characters, r'^\["|"\]$', ''), '"')  
    END AS characters, 
FROM {{ source('staging','title_principals') }}
where tconst is not null