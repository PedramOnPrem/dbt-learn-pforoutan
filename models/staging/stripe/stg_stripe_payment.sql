{{ config(materialized='view')}}
select 
    id as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    AMOUNT as amount,
    CREATED as created 
from {{source('stripe', 'payment')}}