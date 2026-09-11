# ORDER ANALYSIS
# Total Orders
select count(order_id) as total_orders from orders;

# Delivered Orders
select count(order_id) as delivered_orders from orders where order_status='Delivered';

# Cancelled Orders
select count(order_id) as cancelled_orders from orders where order_status='Cancelled';

# Pending Orders
select count(order_id) as pending_orders from orders where order_status='Pending';

# Returned Orders
select count(r.return_id) as returned_orders from returns r;

# Cancellation Rate
select concat(round(sum(case when order_status='Cancelled' then 1 else 0 end)*100/count(*),2),'%') as cancellation_rate from orders;

# Return Rate
select concat(round((select count(*) from returns)*100/count(*),2),'%') as return_rate from orders;

# Average Order Value (Delivered)
select round(avg(final_amount_inr),2) as average_order_value from orders where order_status='Delivered';

# COD Order Rate
select concat(round(sum(case when payment_method='Cash on Delivery' then 1 else 0 end)*100/count(*),2),'%') as cod_order_rate from orders;

# Orders by Status
select order_status,count(order_id) as total_orders from orders group by order_status order by total_orders desc;

# Orders by Category
select category,count(order_id) as total_orders from orders group by category order by total_orders desc;

# Orders by Sub Category
select sub_category,count(order_id) as total_orders from orders group by sub_category order by total_orders desc;

# Orders by Brand
select brand,count(order_id) as total_orders from orders group by brand order by total_orders desc;

# Orders by Month
select month,count(order_id) as total_orders from orders group by month,month_num order by month_num;

# Orders by Quarter
select quarter,count(order_id) as total_orders from orders group by quarter order by quarter;

# Orders by Day of Week
select day_of_week,count(order_id) as total_orders from orders group by day_of_week order by total_orders desc;

# Orders by Order Channel
select order_channel,count(order_id) as total_orders from orders group by order_channel order by total_orders desc;

# Orders by Payment Method
select payment_method,count(order_id) as total_orders from orders group by payment_method order by total_orders desc;

# Orders by Coupon Usage
select case when coupon_code is null then 'without coupon' else 'with coupon' end as coupon_usage,count(order_id) as total_orders
	from orders group by coupon_usage;

# Top 10 Products by Number of Orders
select product_name,count(order_id) as total_orders from orders group by product_name order by total_orders desc limit 10;

# Order Contribution by Channel
select order_channel,count(order_id) as total_orders,concat(round(count(order_id)*100/(select count(*) from orders),2),'%') as order_percentage 
	from orders group by order_channel order by total_orders desc;

# Order Contribution by Category
select category,count(order_id) as total_orders,concat(round(count(order_id)*100/(select count(*) from orders),2),'%') as order_percentage 
	from orders group by category order by total_orders desc;

# Average Shipping Days by Order Channel
select order_channel,round(avg(shipping_days),2) as average_shipping_days from orders group by order_channel;

# Orders Delivered Within 3 Days
select count(order_id) as orders_within_3_days from orders where order_status='Delivered' and shipping_days<=3;

# Orders Delivered After 3 Days
select count(order_id) as orders_after_3_days from orders where order_status='Delivered' and shipping_days>3;

