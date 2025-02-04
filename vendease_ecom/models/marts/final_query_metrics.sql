with customer_orders as (
	
	select 
	cu.customer_id
	, cu.customer_city
	, o.order_id
	, o.order_purchase_ts
	from {{ ref('stg_ecom__customers') }} as cu
	left join {{ ref('stg_ecom__orders') }} as o
	on cu.customer_id = o.customer_id
	)

, order_metrics as (
	
	select 
	o.customer_id
	, o.order_id
	, sum(oi.price::numeric + oi.freight_value::numeric) as total_order_value
	, round(sum(oi.price::numeric + oi.freight_value::numeric) / count(o.order_id), 2) as average_order_value
	, sum(oi.price::numeric) as total_spend_per_customer
	, count(o.order_id) as total_number_of_orders
	from {{ ref('stg_ecom__orders')}} as o
	left join {{ ref('stg_ecom__order_items') }} as oi
	on o.order_id = oi.order_id
	group by 1,2
	having sum(oi.price::numeric) is not null

)

, day_of_highest_purchase as (
	
	select
	o.customer_id
	, to_char(o.order_purchase_ts, 'day') as day_of_week
	, rank() over (partition by o.customer_id order by total_spend_per_customer desc) as day_rank
	from customer_orders as o
	left join order_metrics as om
	on om.order_id = o.order_id
	)
	
, third_order_value as (
    select
        customer_id,
        coalesce(max(case when row_num = 3 then total_order_value end), 0) as third_order_value
    from (select
            om.customer_id,
            total_order_value,
		    row_number() over (partition by om.customer_id order by co.order_purchase_ts) as row_num
        from order_metrics as om
		left join customer_orders as co
		on co.customer_id = om.customer_id
    ) sub
    group by customer_id
	
	)

, finals as (
	
	select
    co.customer_id,
    co.customer_city,
    om.average_order_value,
    om.total_spend_per_customer,
    om.total_number_of_orders,
    dhp.day_of_week as day_of_week_with_highest_purchase,
    tov.third_order_value
	from customer_orders co
	left join order_metrics as om 
	on co.customer_id = om.customer_id
	left join day_of_highest_purchase as dhp 
	on om.customer_id = dhp.customer_id and dhp.day_rank = 1
	left join third_order_value tov on co.customer_id = tov.customer_id
	order by co.customer_id

)
select * from finals
