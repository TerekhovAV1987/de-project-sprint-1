truncate table analysis.dm_rfm_segments;

insert into analysis.dm_rfm_segments
select t1.user_id,
       t1.recency,
       t2.frequency,
       t3.monetary_value
from analysis.tmp_rfm_recency t1
join analysis.tmp_rfm_frequency t2 on (t1.user_id = t2.user_id)
join analysis.tmp_rfm_monetary_value t3 on (t1.user_id = t3.user_id);

224	5	1	1
467	5	1	1
837	5	1	1
514	5	1	1
211	5	1	1
821	5	1	1
889	5	1	1
930	5	1	1
784	5	1	1
977	5	1	1