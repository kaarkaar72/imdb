{{
    config(
        materialized='table'
    )
}}

with actors as (
  SELECT *
  FROM
    {{ref('stg_name_basics')}}
  WHERE "actor" in UNNEST(primary_profession)
)

Select 
    name_id,
    primary_name,
    birth_year,
    death_year,
    ARRAY_TO_STRING(primary_profession, ',') as primary_profession
from actors