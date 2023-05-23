drop table if exists tab1;
drop table if exists tab2;
drop table if exists tab3;

create temp table tab1 as
select t1.user_id,
	t1.order_ts,
	t1.payment,
	t2.status_id as status
from analysis.orders t1 left join
production.orderstatuslog t2 on
(t1.order_id = t2.order_id);

create temp table tab2 as
select user_id,
	sum(payment) as sum
from tab1
where extract(year from order_ts) = 2022
and status = 4
group by user_id;

create temp table tab3 as
select t1.id as user_id,
	case
		when t2.sum is null then 0
		else t2.sum
	end as sum
from analysis.users t1 left join
tab2 t2 on (t1.id = t2.user_id);

insert into analysis.tmp_rfm_monetary_value
select user_id,
	ntile(5) over (order by sum) as monetary_value
from tab3;