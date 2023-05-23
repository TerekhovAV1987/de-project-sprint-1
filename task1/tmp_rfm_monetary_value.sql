drop table if exists tab1;
drop table if exists tab2;

create temp table tab1 as
select user_id,
	sum(payment) as sum
from analysis.orders
where extract(year from order_ts) = 2022
and status = 4
group by user_id;

create temp table tab2 as
select t1.id as user_id,
	case
		when t2.sum is null then 0
		else t2.sum
	end as sum
from analysis.users t1 left join
tab1 t2 on (t1.id = t2.user_id);

insert into analysis.tmp_rfm_monetary_value
select user_id,
	ntile(5) over (order by sum) as monetary_value
from tab2;