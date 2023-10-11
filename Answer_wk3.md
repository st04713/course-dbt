## answer from wk1 
What is our overall conversion rate? ~ 62.45 %

```
SELECT
    COUNT(DISTINCT session_id) AS num_session
    ,COUNT(DISTINCT CASE WHEN event_type='checkout' THEN session_id END) AS num_session_purchased
    ,COUNT(DISTINCT CASE WHEN event_type='checkout' THEN session_id END)/COUNT(DISTINCT session_id) AS conversion_rate
From DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.w3_int_item_sess
```

What is our conversion rate by product?

```
SELECT
    product_id
    ,COUNT(DISTINCT session_id) AS num_session
    ,COUNT(DISTINCT CASE WHEN event_type='checkout' THEN session_id END) AS num_session_purchased
    ,COUNT(DISTINCT CASE WHEN event_type='checkout' THEN session_id END)/COUNT(DISTINCT session_id) AS conversion_rate
From DEV_DB.DBT_ITTIGOONSAITHONNGHOTMAILCOM.w3_int_item_sess
GROUP BY 1
```