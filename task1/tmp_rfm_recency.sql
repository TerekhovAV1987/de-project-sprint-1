drop table if exists tab1;
drop table if exists tab2;
drop table if exists tab3;

create temp table tab1 as
select user_id,
		max(order_ts) as last_order
from analysis.orders
where extract(year from order_ts) = 2022
and status = 4
group by user_id;

create temp table tab2 as
select t1.id as user_id,
	t2.last_order
from analysis.users t1 left join
tab1 t2 on (t1.id = t2.user_id);

create temp table tab3 as
select user_id,
	extract (day from current_date - last_order) as cnt_days
from tab2;

insert into analysis.tmp_rfm_recency
select user_id,
       ntile(5) over (order by cnt_days) as recency
from tab3;