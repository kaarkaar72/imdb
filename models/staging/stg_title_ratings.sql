{{
    config(
        materialized='view'
    )
}}

with titles as 
(
  select *,
    row_number() over(partition by tconst) as rn
  from {{ source('staging','title_ratings') }}
  where tconst is not null 
)

SELECT
    tconst AS title_id,
    CASE
        WHEN averageRating IS NULL THEN NULL  
        ELSE averageRating
    END AS avg_rating,
    CASE
        WHEN numVotes IS NULL THEN NULL  
        ELSE numVotes
    END AS num_votes
from {{ source('staging','title_ratings') }}
where tconst is not null 