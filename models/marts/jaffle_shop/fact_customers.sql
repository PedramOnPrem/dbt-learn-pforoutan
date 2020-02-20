
with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
customer_order_amount as (
    select * from {{ ref('fact_orders') }}
),
customer_orders as (
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders
    from orders
    group by 1
),
customer_payments as (
    select
        customer_id,
        sum(amount) as amount
    from customer_order_amount
    group by 1
),
customer_info as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        customer_payments.amount as customer_lifetime_spend
    from customers
    left join customer_orders using (customer_id)
    left join customer_payments using (customer_id)

),
final as(
    select
        *,
        customer_info.customer_lifetime_spend/customer_info.number_of_orders as customer_avg_spend
    from customer_info
    where number_of_orders>0
)
select * from final