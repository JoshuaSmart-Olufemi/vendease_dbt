with

base as (

    select * from {{ ref('int_churn_model') }}

)

select * from base 