with 

base as (

    select * from {{ source ('ecom', 'order_items')}}

)

, cleaning as (

    select
    order_id
    , cast(order_item_id as int) 
    , product_id
    , seller_id
    , shipping_limit_date :: timestamp as shipping_limit_dt
    , price :: numeric 
    , freight_value :: numeric 
    from base
)

select * from cleaning