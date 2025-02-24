{{
    config(
        materialized='table'
    )
}}

WITH writer_ids AS (
  SELECT DISTINCT
    TRIM(writer) AS writer_id
  FROM {{ref('stg_title_crew')}},
  UNNEST(writers) AS writer
  WHERE writer IS NOT NULL
),
writers AS (
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
    WHERE profession = 'writer'
  )
)

SELECT
  w.writer_id,
  COALESCE(n.primary_name, 'Unknown') AS writer_name,
  COALESCE(n.birth_year, 0) AS birth_year,
  COALESCE(n.death_year, 0) AS death_year,
  COALESCE(ARRAY_TO_STRING(n.primary_profession, ', '), 'Unknown') AS primary_professions
FROM writer_ids w
INNER JOIN writers n
  ON TRIM(w.writer_id) = TRIM(n.name_id)