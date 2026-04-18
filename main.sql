-- 1-mashq
WITH monthly AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount) AS monthly_sales
    FROM orders
    GROUP BY month
)
SELECT 
    month,
    monthly_sales,
    SUM(monthly_sales) OVER (ORDER BY month) AS cumulative_sales,
    ROUND((monthly_sales * 100.0 / LAG(monthly_sales) OVER (ORDER BY month)) - 100, 2) AS growth_pct
FROM monthly
ORDER BY month;
-- 2-mashq
WITH all_friends AS (
    SELECT requester_id AS user_id FROM friend_requests WHERE status = 'accepted'
    UNION ALL
    SELECT accepter_id AS user_id FROM friend_requests WHERE status = 'accepted'
)
SELECT 
    user_id,
    COUNT(*) AS friends_count
FROM all_friends
GROUP BY user_id
ORDER BY friends_count DESC
LIMIT 1;
