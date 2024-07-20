with 

base as (

    select 
    o.customer_id
    , count(distinct oi.order_id) as total_orders
    , max(o.order_purchase_ts::date) as last_purchase_date
    , sum(op.payment_value) as revenue
    from {{ ref('stg_ecom__orders') }} as o
    left join {{ ref('stg_ecom__order_items') }} as oi 
    on o.order_id = oi.order_id
    left join {{ ref('stg_ecom__order_payments') }} as op 
    on o.order_id = op.order_id 
    group by 1
)

, segment as (

    select *
    , case 
        when revenue <= 200 then 'Low Value'
        when revenue between 201 and 700 THEN 'Mid Value'
        else 'High Value '
    end as revenue_segment

    , case
        when total_orders <= 1 then 'Infrequent Buyer'
        when total_orders <=5 then 'Frequent Buyer'
        else 'Highly Frequent Buyer'
    end as customer_segment
    from base
)
select * from segment
order by 2 desc


