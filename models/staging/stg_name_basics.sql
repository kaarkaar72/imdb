{{
    config(
        materialized='view'
    )
}}

SELECT
    nconst AS name_id,
    primaryName AS primary_name,
    CASE
        WHEN birthYear is NULL THEN NULL
        ELSE CAST(birthYear AS INT64)
    END AS birth_year,
    CASE
        WHEN deathYear is NULL THEN NULL
        ELSE CAST(deathYear AS INT64)
    END AS death_year,
    CASE
        WHEN primaryProfession = '\\N' THEN NULL
        ELSE SPLIT(primaryProfession, ',')  -- Convert string to array
    END AS primary_profession,
    CASE
        WHEN knownForTitles = '\\N' THEN NULL
        ELSE SPLIT(knownForTitles, ',')  -- Convert string to array
    END AS known_for_titles
from {{ source('staging','name_basics') }}
where nconst is not null 
