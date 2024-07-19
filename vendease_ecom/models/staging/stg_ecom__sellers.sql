with 

base as (

    select * from {{ source('ecom', 'sellers') }}

)

, cleaning as (

    select 
    seller_id
    , seller_zip_code_prefix :: int 
    , seller_city
    , seller_state
    from base
)


select * from cleaning 