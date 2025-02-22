{{
    config(
        materialized='table'
    )
}}


WITH split_genres AS (
  SELECT DISTINCT
    TRIM(genre) AS genre_name
  FROM
    {{ref('stg_title_basics')}},
    UNNEST(SPLIT(genres, ',')) AS genre
  WHERE
    genres IS NOT NULL
)

SELECT
  ROW_NUMBER() OVER () AS genre_id,  
  genre_name
FROM
  split_genres
GROUP BY
  genre_name