
with payments as (
    select * from {{ ref('stg_payments') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
order_payment as (
    select
        orders.order_id,
        orders.customer_id,
        payments.payment_method,
        payments.amount
    from orders
    left join payments using (order_id)
)

Select * from order_payment