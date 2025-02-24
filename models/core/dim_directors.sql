{{
    config(
        materialized='table'
    )
}}

WITH director_ids AS (
  SELECT DISTINCT
    TRIM(director) AS director_id
  FROM {{ref('stg_title_crew')}},
  UNNEST(directors) AS director
  WHERE director IS NOT NULL
),
directors AS (
  SELECT
    TRIM(name_id) AS name_id,
    primary_name,
    birth_year,
    death_year,
    primary_profession
  FROM {{ref('stg_name_basics')}}
  WHERE EXISTS (
    SELECT 1
    FROM UNNEST(primary_profession) AS profession
    WHERE profession = 'director'
  )
)

SELECT
  d.director_id,
  COALESCE(n.primary_name, 'Unknown') AS director_name,
  COALESCE(n.birth_year, 0) AS birth_year,
  COALESCE(n.death_year, 0) AS death_year,
  COALESCE(ARRAY_TO_STRING(n.primary_profession, ', '), 'Unknown') AS primary_professions
FROM director_ids d
INNER JOIN directors n
  ON TRIM(d.director_id) = TRIM(n.name_id)