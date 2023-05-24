create table analysis.dm_rfm_segments (
    user_id int4 NOT NULL PRIMARY KEY,
    recency int2 NOT NULL check (recency >= 1 and recency <= 5),
    frequency int2 NOT NULL check (frequency >= 1 and frequency <= 5),
    monetary_value int2 NOT NULL check (monetary_value >= 1 and monetary_value <= 5)
);