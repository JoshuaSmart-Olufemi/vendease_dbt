with 

base as (
    
    select * from {{ source('ecom','customers') }}

)

, cleaning as (

    select
    customer_id
    , customer_unique_id
    , cast(customer_zip_code_prefix as int) as customer_zip_code_prefix
    , customer_city
    , customer_state

    from base
)

select * from cleaning