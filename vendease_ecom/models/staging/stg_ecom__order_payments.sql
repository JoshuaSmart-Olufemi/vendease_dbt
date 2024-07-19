with

base as (

    select * from {{ source('ecom', 'order_payments') }}

)

, cleaning as (

    select 
    order_id
    , payment_sequential :: int 
    , payment_type
    , payment_installments :: int 
    , payment_value :: numeric 
    from base 
)

select * from cleaning