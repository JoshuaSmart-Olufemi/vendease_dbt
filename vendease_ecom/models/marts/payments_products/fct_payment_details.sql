with 

base as (

    select * from {{ ref('int_payment_details') }}

)


select * from base 