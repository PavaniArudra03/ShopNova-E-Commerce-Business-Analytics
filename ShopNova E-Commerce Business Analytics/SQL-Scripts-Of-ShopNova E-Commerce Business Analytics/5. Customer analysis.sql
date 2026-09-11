# CUSTOMER ANALYSIS
# Total Registered Customers
select count(customer_id) as total_registered_customers from customers;

# Total Lifetime Spend
select concat(round(sum(total_spend_lifetime_inr)/1000000,2),' M') as total_lifetime_spend from customers;

# Average Customer Lifetime Value (CLV)
select round(avg(total_spend_lifetime_inr),2) as average_clv from customers;

# Average Orders per Customer
select round(avg(total_orders_lifetime),2) as average_orders_per_customer from customers;

# Customer Lifetime Value by Segment
select customer_segment,concat(round(avg(total_spend_lifetime_inr)/1000,2),' K') as average_clv from customers group by customer_segment order by avg(total_spend_lifetime_inr) desc;

# Customer Segment Distribution
select customer_segment,count(customer_id) as total_customers from customers group by customer_segment order by total_customers desc;

# Customers by Gender
select gender,count(customer_id) as total_customers from customers group by gender;

# Customers by Age Group
select age_group,count(customer_id) as total_customers from customers group by age_group order by total_customers desc;

# Customers by State
select state,count(customer_id) as total_customers from customers group by state order by total_customers desc;

# Customers by City
select city,count(customer_id) as total_customers from customers group by city order by total_customers desc limit 10;

# Acquisition Channel Distribution
select acquisition_channel,count(customer_id) as total_customers,concat(round(count(customer_id)*100/(select count(*) from customers),2),'%') as customer_percentage from customers group by acquisition_channel order by total_customers desc;

# Monthly New Customer Trend
select month(registration_date) as month,count(customer_id) as new_customers from customers group by month(registration_date) order by month(registration_date);

# Email Subscription Status
select email_subscribed,count(customer_id) as total_customers from customers group by email_subscribed;

# Push Notification Status
select push_notif_enabled,count(customer_id) as total_customers from customers group by push_notif_enabled;

# Email Engagement Rate
select concat(round(sum(case when email_subscribed='Yes' then 1 else 0 end)*100/count(*),2),'%') as email_engagement_rate from customers;

# Push Notification Engagement Rate
select concat(round(sum(case when push_notif_enabled='Yes' then 1 else 0 end)*100/count(*),2),'%') as push_notification_rate from customers;

# Top 10 Customers by Lifetime Spend
select full_name,concat(round(total_spend_lifetime_inr/1000,2),' K') as lifetime_spend from customers order by total_spend_lifetime_inr desc limit 10;

# Top 10 Customers by Orders
select full_name,total_orders_lifetime from customers order by total_orders_lifetime desc limit 10;

# Average Lifetime Spend by Acquisition Channel
select acquisition_channel,concat(round(avg(total_spend_lifetime_inr)/1000,2),' K') as average_spend from customers group by acquisition_channel order by avg(total_spend_lifetime_inr) desc;

# Customer Distribution by Registration Year
select year(registration_date) as registration_year,count(customer_id) as total_customers from customers group by year(registration_date) order by registration_year;