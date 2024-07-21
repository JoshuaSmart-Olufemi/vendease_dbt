with 

base as (

    select * from {{ ref('int_product_details') }}

)


select * from base