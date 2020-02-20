select 
    id as payment_id,
    "orderID" as order_id,
    "paymentMethod" as payment_method,
    AMOUNT as amount,
    CREATED as created 
from raw.stripe.payment


/*
select *
from raw.stripe.payment
*/