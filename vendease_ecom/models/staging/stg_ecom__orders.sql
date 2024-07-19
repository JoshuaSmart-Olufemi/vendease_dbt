with 

base as (

    select * from {{ source('ecom','orders') }}

)

, cleaning as (

    select 
    order_id
    , customer_id
    , order_status
    , order_purchase_timestamp :: timestamp as order_purchase_ts 
    , order_approved_at :: timestamp 
    , order_delivered_carrier_date :: timestamp as order_delivered_carrier_dt 
    , order_delivered_customer_date :: timestamp as order_delivered_customer_dt
    , order_estimated_delivery_date :: timestamp as order_estimated_delivery_dt
    from base
)

select * from cleaning 