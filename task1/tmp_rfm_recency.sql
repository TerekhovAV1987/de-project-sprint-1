with orders as (
    select user_id,
		max(order_ts) as last_order
    from analysis.orders
    where extract(year from order_ts) = 2022
    and status = 4
    group by user_id
    ),
users as (
    select t1.id as user_id,
	t2.last_order
    from analysis.users t1 left join
    orders t2 on (t1.id = t2.user_id)
    )
insert into analysis.tmp_rfm_recency (user_id, recency)
select user_id,
       ntile(5) over (order by last_order) as recency
from users;