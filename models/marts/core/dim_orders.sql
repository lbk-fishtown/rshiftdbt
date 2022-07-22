{{
    config(
        materialized = 'table'
    )
}}

with orders as (

    select * from {{ ref('stg_tpch_orders') }}

),
customer as (

    select * from {{ ref('stg_tpch_customers') }}

),
nation as (

    select * from {{ ref('stg_tpch_nations') }}
),
region as (

    select * from {{ ref('stg_tpch_regions') }}

),

final as (
    select 
        orders.order_key,
        customer.name as customer,
        nation.name as nation,
        region.name as region,
        orders.total_price,
        orders.order_date
    from
        orders
    inner join customer
            on orders.customer_key = customer.customer_key
    inner join nation
            on customer.nation_key = nation.nation_key
    inner join region
            on nation.region_key = region.region_key
)
select *
from final  