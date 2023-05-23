# Витрина RFM

## 1.1. Выясните требования к целевой витрине.

{См. задание на платформе}
-----------
Расположение витрины: схема analysis;
Структура витрины: user_id, recency (число от 1 до 5), frequency(число от 1 до 5), monetary_value(число от 1 до 5);
Глубина данных: 2022 год;
Название витрины: dm_rfm_segments;
Частота обновления: без обновления;
Статус выполненного заказа: Closed.

## 1.2. Изучите структуру исходных данных.

{См. задание на платформе}

-----------
Для построения итоговой витрины потребуются данные таблиц:
- analysis.users (id);
- analysis.orders (order_id, order_ts, user_id, payment);
- production.orderstatuslog (order_id, status_id).
Для создания таблиц tmp_rfm_ на первом шаге необходимо взять status_id
из таблицы production.orderstatuslog, чтобы использовать в дальнейшем
для фильтрации.
Для наполнения таблиц tmp_rfm_ разбить шаги расчета на временные таблицы, что позволит 
проконтролировать на каждом шаге результаты расчета

## 1.3. Проанализируйте качество данных

{См. задание на платформе}
-----------
Проведенная проверка:
- Поиск дублей по id;
- Поиск пропущенных значений полей нужных для расчета.

## 1.4. Подготовьте витрину данных

{См. задание на платформе}
### 1.4.1. Сделайте VIEW для таблиц из базы production.**

{См. задание на платформе}
```SQL
create view analysis.users as
    select *
from production.users;

create view analysis.orderitems as
    select *
from production.orderitems

create view analysis.orderstatuses as
    select *
from production.orderstatuses;

create view analysis.products as
    select *
from production.products;

create view analysis.orders as
    select *
from production.orders;


```

### 1.4.2. Напишите DDL-запрос для создания витрины.**

{См. задание на платформе}
```SQL
create table analysis.dm_rfm_segments (
    user_id int4 NOT NULL PRIMARY KEY,
    recency int2 NOT NULL,
    frequency int2 NOT NULL,
    monetary_value int2 NOT NULL
);


```

### 1.4.3. Напишите SQL запрос для заполнения витрины

{См. задание на платформе}
```SQL
insert into analysis.dm_rfm_segments
select t1.user_id,
       t1.recency,
       t2.frequency,
       t3.monetary_value
from analysis.tmp_rfm_recency t1
join analysis.tmp_rfm_frequency t2 on (t1.user_id = t2.user_id)
join analysis.tmp_rfm_monetary_value on t3 (t1.user_id = t3.user_id);


```



