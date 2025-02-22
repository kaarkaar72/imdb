{{
    config(
        materialized='table'
    )
}}

WITH split_genres AS (
  SELECT
    t.title_id AS title_id,
    TRIM(genre) AS genre_name
  FROM
    {{ ref("stg_title_basics")}} t,
    UNNEST(SPLIT(t.genres, ',')) AS genre
)

SELECT
  s.title_id,  
  g.genre_id   
FROM
  split_genres s
JOIN
 {{ ref("dim_genres")}} g
ON
  s.genre_name = g.genre_name