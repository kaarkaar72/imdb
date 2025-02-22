{{
    config(
        materialized='view'
    )
}}


SELECT
    tconst AS title_id,
    primaryTitle AS primary_title,
    titleType as title_type,
    CAST(startYear AS INT) AS start_year,
    CAST(endYear AS INT) AS end_year,
    CAST(runtimeMinutes AS INT) AS runtime_minutes,
    CASE WHEN genres = '\\N' THEN 'Unknown' ELSE genres END AS genres
from {{ source('staging','title_basics') }}
where tconst is not null 