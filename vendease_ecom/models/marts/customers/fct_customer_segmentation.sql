with

base as (

    select * from {{ ref('int_customer_segmentation') }}

)


select * from base 