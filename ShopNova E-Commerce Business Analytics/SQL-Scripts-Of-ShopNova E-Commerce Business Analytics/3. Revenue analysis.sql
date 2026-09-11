# REVENUE ANALYSIS
# Total Revenue
select concat(round(sum(final_amount_inr)/1000000,2),' M') as total_revenue from orders;

# Gross Revenue
select concat(round(sum(gross_amount_inr)/1000000,2),' M') as gross_revenue from orders;

# Net Revenue
select concat(round(sum(net_amount_inr)/1000000,2),' M') as net_revenue from orders;

# Total Discount Given
select concat(round(sum(discount_amount_inr)/1000000,2),' M') as total_discount_given from orders;

# Total GST Collected
select concat(round(sum(gst_amount_inr)/1000000,2),' M') as total_gsr_collected from orders;

# Average Order Value
select round(avg(final_amount_inr),2) as average_order_value from orders;

# Highest Order Value
select format(max(final_amount_inr),2) as highest_order_value from orders;

# Lowest Order Value
select format(min(final_amount_inr),2) as lowest_order_value from orders;

# Gross Merchandise Value (GMV)
select concat(round(sum(gross_amount_inr)/1000000,2),' M') as gross_merchandise_value from orders;

# Net Revenue
select concat(round(sum(final_amount_inr)/1000000,2),' M') as net_revenue from orders where order_status='Delivered';

# Total Discount Given
select concat(round(sum(discount_amount_inr)/1000000,2),' M') as total_discount_given from orders where order_status='Delivered';

# Discount Rate
select concat(round(sum(discount_amount_inr)*100/sum(gross_amount_inr),2),'%') as discount_rate from orders where order_status='Delivered';

# GST Collected
select concat(round(sum(gst_amount_inr)/1000000,2),' M') as gst_collected from orders where order_status='Delivered';

/* Note: Net Revenue, Total Discount, Discount Rate and GST Collected are calculated only for 'Delivered' orders
	because revenue is recognized only after an order is successfully delivered.
		Cancelled, Pending and Returned orders do not contribute to actual revenue realised. */

# Revenue by Category
select category,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by category order by sum(final_amount_inr) desc;

# Revenue by Sub Category
select sub_category,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by sub_category order by sum(final_amount_inr) desc;

# Revenue by Brand
select brand,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by brand order by sum(final_amount_inr) desc;

# Monthly Revenue
select month,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by month,month_num order by month_num;

# Quarterly Revenue
select quarter,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by quarter order by quarter;

# Revenue by Day of Week
select day_of_week,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by day_of_week order by sum(final_amount_inr) desc;

# Revenue by Order Channel
select order_channel,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by order_channel order by sum(final_amount_inr) desc;

# Revenue by Payment Method
select payment_method,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by payment_method order by sum(final_amount_inr) desc;

# Top 10 Highest Revenue Orders
select order_id,format(final_amount_inr,2) as order_value from orders order by final_amount_inr desc limit 10;

# Top 10 Lowest Revenue Orders
select order_id,format(final_amount_inr,2) as order_value from orders order by final_amount_inr limit 10;

# Gross Revenue vs Discount vs Net Revenue
select concat(round(sum(gross_amount_inr)/1000000,2),' M') as gross_revenue,concat(round(sum(discount_amount_inr)/1000000,2),' M') as total_discount,
	concat(round(sum(net_amount_inr)/1000000,2),' M') as net_revenue from orders;

# Revenue Contribution by Category
select category,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue,concat(round(sum(final_amount_inr)*100/(select sum(final_amount_inr) 
	from orders),2),'%') as revenue_percentage from orders group by category order by sum(final_amount_inr) desc;

# Revenue Contribution by Order Channel
select order_channel,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue,
	concat(round(sum(final_amount_inr)*100/(select sum(final_amount_inr) from orders),2),'%') as revenue_percentage from orders group by order_channel order by sum(final_amount_inr) desc;

# Average Revenue by Category
select category,round(avg(final_amount_inr),2) as average_revenue from orders group by category order by avg(final_amount_inr) desc;

# Top 5 Revenue Generating Brands
select brand,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue from orders group by brand order by sum(final_amount_inr) desc limit 5;

# Top 5 Revenue Generating Categories
select category,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue from orders group by category order by sum(final_amount_inr) desc limit 5;

# Revenue by Repeat Customer
select is_repeat_customer,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue from orders group by is_repeat_customer;

# Revenue by Order Status
select order_status,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue from orders group by order_status order by sum(final_amount_inr) desc;

# Revenue by Coupon Usage
select case when coupon_code is null then 'without coupon' else 'with coupon' end as coupon_usage,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue from orders group by coupon_usage;

# Average Daily Revenue
select order_date,concat(round(sum(final_amount_inr)/1000000,2),' M') as daily_revenue from orders group by order_date order by order_date;