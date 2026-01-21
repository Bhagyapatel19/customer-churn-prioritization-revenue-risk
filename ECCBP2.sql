SELECT * FROM project2ecom.eccbp2;
select distinct count(customer_id)
from project2ecom.eccbp2;
select min(date) as min_date,
max(date) as max_date
from project2ecom.eccbp2;
select customer_id, min(date) as First_Purchase_date,
Max(date) as Last_Purchase_date, count(order_id) as total_orders,
sum(total_amount) as total_revenue, datediff('2024-3-25',max(date)) as days_since_last_purchase
from project2ecom.eccbp2
group by customer_id;
select customer_id, total_order, total_revenue, days_since_last_purchase,
case when days_since_last_purchase > 60 then 'Churn'
else 'Active'
end as churn_status
from(select customer_id, count(order_id) as total_order, sum(total_amount) as total_revenue, datediff('2024-03-25',max(date)) as days_since_last_purchase
from project2ecom.eccbp2
group by customer_id)t;
select churn_status, count(*) as customers
from (select customer_id, total_order, total_revenue, days_since_last_purchase,
case when days_since_last_purchase > 60 then 'Churn'
else 'Active'
end as churn_status
from(select customer_id, count(order_id) as total_order, sum(total_amount) as total_revenue, datediff('2024-03-25',max(date)) as days_since_last_purchase
from project2ecom.eccbp2
group by customer_id)t)x 
group by churn_status;

select customer_id, total_order, total_revenue, days_since_last_purchase
from(select customer_id, count(order_id) as total_order, sum(total_amount) as total_revenue, datediff('2024-03-25',max(date)) as days_since_last_purchase
from project2ecom.eccbp2
group by customer_id)t
having days_since_last_purchase between 30 and 60;

select customer_id, total_revenue, percent_rank () over (order by total_revenue) as Percentile_count
from  (select customer_id, SUM(total_amount) AS total_revenue
from project2ecom.eccbp2
group by customer_id)t;

select customer_id, total_revenue, percentile_count, round(percentile_count,4)*100 as percentile
from(select customer_id, total_revenue, percent_rank () over (order by total_revenue) as Percentile_count
from  (select customer_id, SUM(total_amount) AS total_revenue
from project2ecom.eccbp2
group by customer_id)t)x 
where  round(percentile_count,4)*100 ;


select percentile, sum(total_revenue), count(percentile), sum(total_revenue)/count(percentile) as avg_total_revenue
from(select distinct(round(percent_rank() over (order by total_revenue),2)) as Percentile,Total_revenue
from ( select customer_id, total_revenue, round(percent_rank() over (order by total_revenue),2) as Percentile_count
from  (select customer_id, SUM(total_amount) AS total_revenue
from project2ecom.eccbp2
group by customer_id)t)x
)t
group by percentile
having percentile = .80;

select customer_id, total_revenue, percentile, case when percentile >= .95 then 'Platinum'
when percentile > .90 then 'Gold'
when percentile > .85 then 'Silver'
else 'Bronze' 
end as Value_tier
from(select distinct(round(percent_rank() over (order by total_revenue),2)) as Percentile,Total_revenue, customer_id
from ( select customer_id, total_revenue, round(percent_rank() over (order by total_revenue),2) as Percentile_count
from  (select customer_id, SUM(total_amount) AS total_revenue
from project2ecom.eccbp2
group by customer_id)t)x)t;

select Customer_id, Total_revenue, case when days_since_last_purchase between 60 and 120  then 'A_Recent'
when days_since_last_purchase between 121 and 240 then 'B_Mid'
when days_since_last_purchase >241 then 'C_old'
else 'Active' 
end as Recency_Grade
from(select customer_id, count(order_id) as total_order, sum(total_amount) as total_revenue, datediff('2024-03-25',max(date)) as days_since_last_purchase
from project2ecom.eccbp2
group by customer_id)t;


WITH base AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_revenue,
        DATEdiff('2024-03-25',MAX(date)) AS days_since_last_purchase
    FROM project2ecom.eccbp2
    GROUP BY customer_id
),
recency AS (
    SELECT
        customer_id,
        CASE
            WHEN days_since_last_purchase BETWEEN 60 AND 120 THEN 'A_Recent'
            WHEN days_since_last_purchase BETWEEN 121 AND 240 THEN 'B_Mid'
            WHEN days_since_last_purchase > 240 THEN 'C_Old'
        END AS recency_grade
    FROM base
    WHERE days_since_last_purchase > 60

),
value AS (
   select customer_id, total_revenue, percentile, case when percentile >= .95 then 'Platinum'
when percentile > .90 then 'Gold'
when percentile > .80 then 'Silver'
else 'Bronze' 
end as Value_tier
from(select distinct(round(percent_rank() over (order by total_revenue),2)) as Percentile,Total_revenue, customer_id
from ( select customer_id, total_revenue, round(percent_rank() over (order by total_revenue),2) as Percentile_count
from  (select customer_id, SUM(total_amount) AS total_revenue
from project2ecom.eccbp2
group by customer_id)t)x)t
)
SELECT
    r.customer_id,
    r.recency_grade,
    v.value_tier,
    
    CASE
        WHEN r.recency_grade = 'A_Recent' AND v.value_tier = 'Platinum' THEN 'Priority 1'
        WHEN r.recency_grade = 'A_Recent' AND v.value_tier = 'Gold' THEN 'Priority 2'
        WHEN r.recency_grade = 'B_Mid' AND v.value_tier = 'Platinum' THEN 'Priority 2'
		WHEN r.recency_grade = 'B_Mid' AND v.value_tier = 'Gold' THEN 'Priority 3'
        WHEN r.recency_grade = 'A_Recent' AND v.value_tier = 'Silver' THEN 'Priority 3'
	    WHEN r.recency_grade = 'C_old' AND v.value_tier = 'Platinum' THEN 'Priority 3'
        ELSE 'Low Priority'
    END AS action_priority
FROM recency r
JOIN value v ON r.customer_id = v.customer_id;







 