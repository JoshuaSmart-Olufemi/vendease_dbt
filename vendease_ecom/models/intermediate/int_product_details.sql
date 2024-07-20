with 

base as (

    select 
    distinct product_category_name
    , sum(op.payment_value) as revenue
    , count(distinct oi.order_id) as order_count
    , count(distinct pr.product_id) as product_count
    from {{ ref('stg_ecom__products') }} as pr
    left join {{ ref('stg_ecom__order_items') }} as oi
    on pr.product_id = oi.product_id
    left join {{ ref('stg_ecom__order_payments') }} as op
    on oi.order_id = op.order_id
    where product_category_name is not null
    group by 1
    
    )

    select * from base
    order by 2 desc



