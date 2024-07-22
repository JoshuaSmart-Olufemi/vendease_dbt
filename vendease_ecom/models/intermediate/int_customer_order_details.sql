with 

base as (

    select 
    o.customer_id
    , count(o.order_id) as order_count
    , date_part ('day', o.order_estimated_delivery_dt - o.order_delivered_customer_dt )  as days_bw_order_and_delivery
    , sum(oi.price) as customer_spend
    , sum(oi.price + oi.freight_value) as order_value
    , round(sum(oi.price + oi.freight_value) / count(o.order_id) , 2) as average_order_value
    from {{ ref('stg_ecom__orders') }} as o
    left join {{ ref('stg_ecom__order_items') }} as oi
    on o.order_id = oi.order_id 
    group by 1,3

)

select * from base  
order by order_count desc 
