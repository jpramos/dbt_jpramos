
# Questions

## How many users do we have?

Query:
```sql
    select count(user_uuid) 
    from dbt_jpramos.stg_users;
```
Result: `130 users`
    
## On average, how many orders do we receive per hour?

Query:
```sql
    with orders_in_hour as (
        select 
            date_trunc('hour', created_at_utc),
            count(order_uuid) as count_orders 
        from dbt_jpramos.stg_orders 
        group by 1
    ) 
    select round(avg(count_orders), 2) from orders_in_hour;
```
Result: `8.16 orders/hour`

## On average, how long does an order take from being placed to being delivered?

Query:
```sql
    with time_diff as (
        select date_part('day', delivery_at_utc - created_at_utc)*24 + date_part('hour', delivery_at_utc - created_at_utc ) as time2delivery
        from dbt_jpramos.stg_orders

    )
    select round(avg(time2delivery::int), 2) from time_diff;
```
Result: `94.22 hours`

## How many users have only made one purchase? Two purchases? Three+ purchases?

Query;
```sql
    with users as (
        select user_uuid, count(order_uuid) orders_count
        from dbt_jpramos.stg_orders 
        group by 1  
    )
    select '1 purchase' "#purchases", count(*) "amount" from users
    where users.orders_count=1
    union all
    select '2 purchases', count(*) from users
    where users.orders_count=2
    union all
    select '3+ purchases', count(*) from users
    where users.orders_count>=3;
```
Result:
| #purchases   | amount |
|--------------|--------|
| 1 purchase   | 25     |
| 2 purchases  | 22     |
| 3+ purchases | 81     |

## On average, how many unique sessions do we have per hour?

Query:
```sql
    with sessions_in_hour as (
        select 
            date_trunc('hour', created_at_utc),
            count(distinct session_uuid) as count_sessions 
        from dbt_jpramos.stg_events 
        group by 1
    )
    select round(avg(count_sessions), 2) from sessions_in_hour;
```
Result: `7.39 orders/hour`