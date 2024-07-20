
with base

as  (

    select * from {{ ref('stg_ecom__order_payments')}}

)

, payment_types as (

    select 
    distinct(payment_type) as unique_payment_types
    , count(distinct (order_id)) as unique_orders
    from base
    group by 1
)
, final as (
    select *
    , round(unique_orders / sum(unique_orders) over () * 100 , 3) as payment_type_usage_percentage
    from payment_types
    group by 1,2

)

select * from final 
