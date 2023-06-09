truncate table analysis.tmp_rfm_frequency;

with orders as (
    select user_id,
	    count(order_id) as cnt
    from analysis.orders
    where extract(year from order_ts) = 2022
    and status = 4
    group by user_id
),
users as (
    select t1.id as user_id,
		case
			when t2.cnt is null then 0
			else t2.cnt
		end as cnt
    from analysis.users t1 left join orders t2
    on (t1.id = t2.user_id)
)
insert into analysis.tmp_rfm_frequency
select user_id,
	ntile(5) over (order by cnt) as frequency
from users;