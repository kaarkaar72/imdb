{{
    config(
        materialized='table'
    )
}}

with titles as (
    select *
    from {{ ref('stg_title_basics') }}
),
ratings as (
    select *
    from {{ ref('stg_title_ratings')}}
)


SELECT
  t.title_id AS movie_id,  -- Foreign key to dim_movies
  r.avg_rating AS average_rating,
  r.num_votes AS num_votes,
  t.runtime_minutes AS runtime_minutes,
FROM
  titles t
LEFT JOIN
  ratings r
ON
  t.title_id = r.title_id
WHERE
  t.title_type = 'movie'  -- Filter for movies only
AND
   r.avg_rating is not null
AND
   r.num_votes is not null

