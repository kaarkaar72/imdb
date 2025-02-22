{{
    config(
        materialized='table'
    )
}}

with titles as (
    select *
    from {{ ref('stg_title_basics') }}
)

SELECT
  title_id,
  primary_title,
  title_type,
  start_year,
  end_year
FROM titles
