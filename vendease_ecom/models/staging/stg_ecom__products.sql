with
base as (

    select * from {{ source('ecom', 'products') }}

)

, cleaning as (

    select 
    product_id
    , product_category_name
    , product_name_length :: numeric 
    , product_description_length :: numeric 
    , product_photos_qty :: numeric
    , product_weight_g :: numeric
    , product_length_cm :: numeric 
    , product_height_cm :: numeric
    , product_width_cm :: numeric

    from base
)

select * from cleaning