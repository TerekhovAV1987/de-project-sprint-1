insert into analysis.dm_rfm_segments
select t1.user_id,
       t1.recency,
       t2.frequency,
       t3.monetary_value
from analysis.tmp_rfm_recency t1
join analysis.tmp_rfm_frequency t2 on (t1.user_id = t2.user_id)
join analysis.tmp_rfm_monetary_value on t3 (t1.user_id = t3.user_id);

0	5	3	4
1	2	3	3
2	4	3	5
3	4	3	3
4	2	3	3
5	2	5	5
6	5	3	5
7	2	2	2
8	5	1	3
9	5	2	2