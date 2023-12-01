{{ config(materialized='table') }}

select country,ioc from {{ ref('ioc_codes')}}