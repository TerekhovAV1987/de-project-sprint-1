drop table if exists tab1;
drop table if exists tab2;
drop table if exists tab3;
drop table if exists tab4;

create temp table tab1 as
select t1.user_id,
	t1.order_ts,
	t2.status_id as status
from analysis.orders t1
left join production.orderstatuslog t2
on (t1.order_id = t2.order_id);

create temp table tab2 as
select user_id,
		max(order_ts) as last_order
from tab1
where extract(year from order_ts) = 2022
and status = 4
group by user_id;

create temp table tab3 as
select t1.id as user_id,
	t2.last_order
from analysis.users t1 left join
tab2 t2 on (t1.id = t2.user_id);

create temp table tab4 as
select user_id,
	extract (day from current_date - last_order) as cnt_days
from tab3;

insert into analysis.tmp_rfm_recency
select user_id,
       ntile(5) over (order by cnt_days) as recency
from tab4;