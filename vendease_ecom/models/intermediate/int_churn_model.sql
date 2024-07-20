with 

base as (

    select 
        customer_id
        , max(order_purchase_ts) as last_purchase_date
        , case 
            when max(order_purchase_ts::date) < date '2018-12-31' - INTERVAL '6 months' then 'Likely To Churn'
            when max(order_purchase_ts::date) < date '2018-12-31' - INTERVAL '3 months' then 'Inactive'
            else 'Active'
        end as churn_status    
    from {{ ref('stg_ecom__orders') }}
    group by 1
)


select * from base











