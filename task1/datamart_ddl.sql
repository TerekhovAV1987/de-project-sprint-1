create table analysis.dm_rfm_segments (
    user_id int4 NOT NULL PRIMARY KEY,
    recency int2 NOT NULL,
    frequency int2 NOT NULL,
    monetary_value int2 NOT NULL
);