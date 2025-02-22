{{
    config(
        materialized='view'
    )
}}

SELECT
    tconst AS title_id,
    CASE
        WHEN directors = '\\N' THEN NULL
        ELSE SPLIT(directors, ',')  -- Convert string to array
    END AS directors,
    CASE
        WHEN writers = '\\N' THEN NULL
        ELSE SPLIT(writers, ',')  -- Convert string to array
    END AS writers
from {{ source('staging','title_crew') }}
where tconst is not null 


