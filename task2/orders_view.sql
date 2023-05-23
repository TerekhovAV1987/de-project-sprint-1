create or replace view analysis.orders as
select t1.order_id,
		order_ts,
		user_id,
		bonus_payment,
		payment,
		cost,
		bonus_grant,
		t2.status_id as status
from production.orders t1
join (
select order_id,
	status_id,
	row_number () over (partition by order_id order by dttm desc) as rn
from production.orderstatuslog
) t2 on t2.order_id = t1.order_id
where t2.rn = 1;