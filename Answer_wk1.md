## answer from wk1 
How many users do we have? ~  130 users 

```
SELECT COUNT(DISTINCT user_guid) FROM DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.STG_POSTGRES__USERS
```

On average, how many orders do we receive per hour? ~ 7 hours

```
WITH temp AS (
     SELECT 
         DATE(created_at_utc), 
         HOUR(created_at_utc),
         COUNT(DISTINCT ORDER_ID) AS num_order_hourly
     FROM DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.STG_POSTGRES__ORDERS
     GROUP BY 1,2
 )

SELECT FLOOR(AVG(num_order_hourly)) AS avg_orders_hourly FROM temp
```


On average, how long does an order take from being placed to being delivered? ~ 93.40 hours

```
SELECT 
     AVG(TIMEDIFF(HOUR,created_at_utc,delivered_at_utc)) AS avg_time_from_placed_to_delivered
FROM DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.STG_POSTGRES__ORDERS
WHERE status = 'delivered'
```

How many users have only made one purchase? Two purchases? Three+ purchases? ~ 1-purchase: 25 users, 2-purchases:28 users, 3-purchases:34 users

```
WITH temp AS (
     SELECT 
         user_guid,
         COUNT(DISTINCT order_id) AS num_orders
     FROM DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.STG_POSTGRES__ORDERS
     GROUP BY 1
     HAVING num_orders < 4
 )

SELECT 
    num_orders, 
    COUNT(DISTINCT user_guid)
FROM temp
GROUP BY 1
ORDER BY 1 

```
On average, how many unique sessions do we have per hour? ~ 16 hours

```
WITH temp AS (
     SELECT 
         DATE(created_at_utc), 
         HOUR(created_at_utc),
         COUNT(DISTINCT session_id) AS num_session_hourly
     FROM DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.STG_POSTGRES__EVENTS
     GROUP BY 1,2
 )

SELECT FLOOR(AVG(num_session_hourly)) AS avg_sessions_hourly FROM temp
```
