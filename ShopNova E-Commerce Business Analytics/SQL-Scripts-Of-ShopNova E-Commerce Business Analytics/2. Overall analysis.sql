# Shop Nova overview
select 'Total Revenue' as KPI, concat(round(sum(final_amount_inr)/1000000,2),' M') as Value from orders
union all
select 'Net Revenue', concat(round(sum(final_amount_inr)/1000000,2),' M') from orders where order_status='Delivered'
union all
select 'Total Orders', count(order_id) from orders
union all
select 'Delivered Orders', count(order_id) from orders where order_status='Delivered'
union all
select 'Cancelled Orders', count(order_id) from orders where order_status='Cancelled'
union all
select 'Returned Orders', count(return_id) from returns
union all
select 'Total Customers', count(distinct customer_id) from customers
union all
select 'Total Products', count(distinct product_id) from products
union all
select 'Average Order Value', round(avg(final_amount_inr),2) from orders
union all
select 'Total Marketing Spend', concat(round(sum(amount_spent_inr)/1000000,2),' M') from campaigns
union all
select 'Campaign Revenue', concat(round(sum(revenue_generated_inr)/1000000,2),' M') from campaigns
union all
select 'Overall ROAS', round(sum(revenue_generated_inr)/sum(amount_spent_inr),2) from campaigns;

-- Revenue analysis
# Top 10 Customers by Revenue
select * from (select customer_id,concat(round(sum(final_amount_inr)/1000,2),' K') as revenue,
	dense_rank() over(order by sum(final_amount_inr) desc) as customer_rank 
		from orders group by customer_id)t where customer_rank<=10;

# Top 10 Products by Revenue
select * from (select product_id,product_name,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue,
	dense_rank() over(order by sum(final_amount_inr) desc) as product_rank 
		from orders group by product_id,product_name)t where product_rank<=10;

# Highest Revenue State
select c.state,concat(round(sum(o.final_amount_inr)/1000000,2),' M') as revenue 
	from customers c join orders o on c.customer_id=o.customer_id group by c.state 
		order by sum(o.final_amount_inr) desc;

# Highest Revenue City
select c.city,concat(round(sum(o.final_amount_inr)/1000000,2),' M') as revenue 
	from customers c join orders o on c.customer_id=o.customer_id 
		group by c.city order by sum(o.final_amount_inr) desc;

# Running Monthly Revenue
select year,month,concat(round(sum(final_amount_inr)/1000000,2),' M') as monthly_revenue,
	concat(round(sum(sum(final_amount_inr)) over(order by year,month_num)/1000000,2),' M') as cumulative_revenue 
		from orders group by year,month,month_num order by year,month_num;

# Category Contribution Percentage
select category,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue,
	concat(round(sum(final_amount_inr)*100/sum(sum(final_amount_inr)) over(),2),'%') as contribution 
		from orders group by category;

# Brand Contribution Percentage
select brand,concat(round(sum(final_amount_inr)/1000,2),' K') as revenue,
	concat(round(sum(final_amount_inr)*100/sum(sum(final_amount_inr)) over(),2),'%') as contribution 
		from orders group by brand order by contribution desc;

# Repeat Customer Revenue
select is_repeat_customer,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue from orders group by is_repeat_customer;

-- returns analysis
# Return Rate by Category
select o.category, count(o.order_id) as total_orders, count(r.return_id) as total_returns,
	concat(round(count(r.return_id)*100/count(o.order_id),2),'%') as return_rate 
		from orders o left join returns r on o.order_id=r.order_id group by o.category;

# Revenue Lost Due to Returns
select concat(round(sum(refund_amount_inr)/1000000,2),' M') as revenue_lost from returns;

# Average Resolution Days
select round(avg(resolution_days),2) as average_resolution_days from returns;

-- Campaign analysis
# Best Campaign Channel by ROAS
select channel,round(avg(roas),2) as average_roas from campaigns group by channel order by average_roas desc;

# Best Performing Month by ROAS
select month,round(avg(roas),2) as average_roas from campaigns group by month,month_num order by avg(roas) desc;

-- Product analysis
# Gross Margin by Category
select category,concat(round(avg(gross_margin_pct),2),'%') as average_gross_margin
	from products group by category order by avg(gross_margin_pct) desc;

# Product Price Category 
select product_id,product_name,selling_price_inr,
	case when selling_price_inr>=5000 then 'premium' 
		 when selling_price_inr>=2000 then 'mid range' 
         else 'budget' end as price_category 
from products order by selling_price_inr desc;

# Top 5 Products Priced Above Category Average 
select p1.product_name,p1.category,p1.selling_price_inr from products p1 where p1.selling_price_inr >
	(select avg(p2.selling_price_inr) from products p2 where p1.category=p2.category) order by p1.selling_price_inr desc limit 5;

# Top 10 Products by Quantity Sold
select product_name,sum(quantity) as units_sold from orders group by product_name order by units_sold desc limit 10;

# Brand Wise Quantity Sold
select brand,sum(quantity) as units_sold from orders group by brand order by units_sold desc;

-- Customer analysis
# Customer Segment Revenue
select c.customer_segment,concat(round(sum(o.final_amount_inr)/1000000,2),' M') as revenue 
	from customers c join orders o on c.customer_id=o.customer_id 
		group by c.customer_segment order by sum(o.final_amount_inr) desc;

# Email Subscribers Revenue
select c.email_subscribed,concat(round(sum(o.final_amount_inr)/1000000,2),' M') as revenue 
	from customers c join orders o on c.customer_id=o.customer_id group by c.email_subscribed;

# Customer Age Group Revenue
select c.age_group,concat(round(sum(o.final_amount_inr)/1000000,2),' M') as revenue 
	from customers c join orders o on c.customer_id=o.customer_id 
		group by c.age_group order by sum(o.final_amount_inr) desc;

# Revenue by Gender
select c.gender,concat(round(sum(o.final_amount_inr)/1000000,2),' M') as revenue 
	from customers c join orders o on c.customer_id=o.customer_id group by c.gender order by sum(o.final_amount_inr) desc;

# Customer Value Classification 
select customer_id,full_name,total_spend_lifetime_inr,
	case when total_spend_lifetime_inr>=100000 then 'high value customer' 
		 when total_spend_lifetime_inr>=50000 then 'medium value customer' 
         else 'low value customer' end as customer_category
from customers order by total_spend_lifetime_inr desc;

# Top 5 Customers Above Average Revenue 
select customer_id,full_name,concat(round(total_spend_lifetime_inr/1000,2),' K') as lifetime_spend 
	from customers where total_spend_lifetime_inr > 
		(select avg(total_spend_lifetime_inr) from customers) order by total_spend_lifetime_inr desc limit 5;

-- order analysis
# Average Shipping Days by Category
select category,round(avg(shipping_days),2) as average_shipping_days 
	from orders group by category order by average_shipping_days desc;

# Monthly Order Trend
select year,month,count(order_id) as total_orders from orders group by year,month,month_num order by year,month_num;

# Order Status Distribution
select order_status,count(order_id) as total_orders,concat(round(count(order_id)*100/(select count(*) from orders),2),'%') as percentage from orders group by order_status order by total_orders desc;

# Category Wise Average Order Value
select category,round(avg(final_amount_inr),2) as average_order_value from orders group by category order by average_order_value desc;

# Top 10 Highest Discount Orders
select order_id,product_name,concat(round(discount_amount_inr/1000,2),' K') as discount_given from orders order by discount_amount_inr desc limit 10;

