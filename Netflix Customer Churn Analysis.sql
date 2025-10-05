-- Netflix Churn Analysis

-- Create Table

Create table Netflix
(
  customer_id varchar(50) primary key,
  age int not null,
  gender varchar(50),
  subscription_type varchar(50),
  watch_hours float,
  last_login_days int,
  region varchar(40),
  device varchar(20),
  monthly_fee float,
  churned int,
  payment_method varchar(50),
  number_of_profiles int,
  avg_watch_time_per_day float,
  favorite_genre varchar(50)
);

select * from Netflix


--Load the datasets


select * from Netflix

select count(*) from Netflix

-- CHURN & RETENTION

--Q.1 Which subscription type has the highest churn rate?
--    Helps decide if pricing plans need redesign.

select * from Netflix
select subscription_type,count(*) as total_customers,sum(churned)as churned_customers,
round(sum(churned)*100.0/count(*),2) as churn_rate_percentage
from Netflix
group by subscription_type;


--Q.2 What are the top regions with the highest churned customers?
--    Useful for region-specific marketing or retention offers.

select * from Netflix
select region,count(*) as total_customers,sum(churned) as churned_customer,
round(sum(churned)*100.0/count(*),2) as churn_rate_percentage
from Netflix
group by region;

--Q.3 How does churn vary across different payment methods (Credit Card, PayPal, Crypto, Gift Card)?
--    Reveals if certain payment methods indicate unreliable customers.

select * from Netflix
select payment_method,count(*) as total_customers,sum(churned) as chured_customers,
round(sum(churned)*100.0/count(*),2) as churned_rate_percentage
from Netflix
group by payment_method;


-- Customer Engagement

-- Q.4 What is the average watch_hours and avg_watch_time_per_day difference between churned vs retained users?
--     Shows if engagement predicts retention.

select * from Netflix
SELECT 
    churned,
    AVG(watch_hours)AS avg_watch_hours,
    AVG(avg_watch_time_per_day) AS avg_daily_watch_time
FROM Netflix
GROUP BY churned;



-- Q.5 Which devices (TV, Mobile, Tablet, etc.) are most commonly used by churned vs retained customers?
--     Useful for optimizing user experience on weaker platforms.

SELECT 
    device,
    churned,
    COUNT(*) AS customer_count
FROM Netflix
GROUP BY device, churned
ORDER BY device, churned;



-- Q.6 Which favorite genres are most popular among retained customers vs churned customers?
--     Guides personalized content recommendation.

SELECT 
    favorite_genre,
    churned,
    COUNT(*) AS customer_count
FROM netflix
GROUP BY favorite_genre, churned
ORDER BY customer_count DESC;



--   Revenue & Subscription Insights

-- Q.7 Which subscription plan (Basic, Standard, Premium) contributes the most revenue, and how much of it is lost due to churn?
-- Direct link between churn and revenue loss.


SELECT 
    subscription_type,
    ROUND(SUM(monthly_fee), 2) AS total_revenue,
    ROUND(SUM(CASE WHEN churned = 1 THEN monthly_fee ELSE 0 END), 2) AS lost_revenue_due_to_churn,
    ROUND(SUM(monthly_fee) - SUM(CASE WHEN churned = 1 THEN monthly_fee ELSE 0 END), 2) AS retained_revenue
FROM netflix
GROUP BY subscription_type
ORDER BY total_revenue DESC;




-- Q.8 What is the average monthly fee paid by churned vs retained users?
--     Helps identify if price sensitivity is a factor in churn.

SELECT 
    churned,
    AVG(monthly_fee) AS avg_monthly_fee
FROM netflix
GROUP BY churned;



--  USER BEHAVIOR & PROFILES

-- Q.9 Does the number_of_profiles (1, 2, 5, etc.) affect churn likelihood?
--     Shows if family/household usage reduces churn.

select * from Netflix
SELECT 
    number_of_profiles,
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(SUM(churned) * 100.0 / COUNT(*), 2) AS churn_rate_percentage
FROM netflix
GROUP BY number_of_profiles
ORDER BY churn_rate_percentage DESC;



-- Q.10 How does inactivity (last_login_days) correlate with churn probability?
--      Can be used to trigger re-engagement campaigns.


SELECT 
    churned,
    ROUND(AVG(last_login_days), 2) AS avg_last_login_days
FROM netflix
GROUP BY churned;

-- Let's End this project







