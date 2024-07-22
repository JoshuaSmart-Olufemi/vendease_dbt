with 

base as (

    select * from {{ ref('int_customer_order_details') }}

)

select * from base 