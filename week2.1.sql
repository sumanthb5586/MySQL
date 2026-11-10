use info;

create table customers (
    customer_id int primary key,
    customer_name varchar(100),
    city varchar(50)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_amount decimal(10,2),
    order_status varchar(20),
    updated_at datetime
);

create table incoming_orders (
    record_id int primary key,
    order_id int,
    customer_id int,
    order_amount decimal(10,2),
    order_status varchar(20),
    updated_at datetime
);


insert into customers values
(1, 'John', 'Houston'),
(2, 'Sarah', 'Dallas'),
(3, 'David', 'Austin'),
(4, 'Emily', 'Houston'),
(5, 'Michael', 'Chicago');

insert into orders values
(101, 1, 250.00, 'delivered', '2026-11-01 10:00:00'),
(102, 2, 150.00, 'shipped', '2026-11-02 11:00:00'),
(103, 3, 300.00, 'pending', '2026-11-03 12:00:00');

insert into incoming_orders values
(1, 101, 1, 250.00, 'delivered', '2026-11-01 10:00:00'),
(2, 102, 2, 150.00, 'shipped', '2026-11-02 11:00:00'),
(3, 102, 2, 150.00, 'delivered', '2026-11-05 09:00:00'),
(4, 104, 4, 450.00, 'pending', '2026-11-04 14:00:00'),
(5, 104, 4, 450.00, 'shipped', '2026-11-06 10:00:00'),
(6, 105, 5, 200.00, 'pending', '2026-11-06 12:00:00'),
(7, 106, 3, null, 'pending', '2026-11-07 08:00:00'),
(8, 107, 1, -50.00, 'shipped', '2026-11-07 09:00:00');

select * from customers;

select * from orders;

select * from incoming_orders;

select 
    order_id, 
    count(*) as total_records
from incoming_orders
group by order_id
having total_records >=2;

with ranked_orders as (
    select record_id,
       order_id,
       customer_id,
       order_amount,
       order_status,
       updated_at,
       row_number() over (
        partition by order_id
        order by updated_at desc, order_id desc
       ) as row_num
    from incoming_orders
)
select
    order_id,
    customer_id,
    order_amount,
    order_status,
    updated_at
from ranked_orders
where row_num = 1
order by order_id;


select *
from incoming_orders
where order_id is null
   or customer_id is null
   or order_amount is null;

select 
    order_id
from incoming_orders
group by order_id
having count(*)>=2;


select
    count(*) as total_records,
    sum(case
        when order_amount is null then 1
        else 0
    end) as missing_amounts,
    sum(case
        when order_amount < 0 then 1
        else 0
    end) as negative_amounts
from incoming_orders;


with latest_orders as (
    select
        i.*,
        row_number() over (
            partition by order_id
            order by updated_at desc, record_id desc
        ) as rn
    from incoming_orders i
)
select
    order_id,
    customer_id,
    order_amount,
    order_status,
    updated_at
from latest_orders
where rn = 1
  and order_amount is not null
  and order_amount >= 0;

 
insert into orders (
    order_id,
    customer_id,
    order_amount,
    order_status,
    updated_at
)
select
    src.order_id,
    src.customer_id,
    src.order_amount,
    src.order_status,
    src.updated_at
from (
    select
        i.*,
        row_number() over (
            partition by i.order_id
            order by i.updated_at desc, i.record_id desc
        ) as rn
    from incoming_orders i
) as src
where src.rn = 1
  and src.order_amount is not null
  and src.order_amount >= 0
  and not exists (
      select 1
      from orders o
      where o.order_id = src.order_id
        and o.updated_at >= src.updated_at
  )
on duplicate key update
    customer_id = values(customer_id),
    order_amount = values(order_amount),
    order_status = values(order_status),
    updated_at = values(updated_at);


select *
from orders
order by order_id;