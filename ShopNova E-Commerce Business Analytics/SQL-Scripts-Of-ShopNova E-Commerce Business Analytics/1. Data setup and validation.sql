# DATABASE SETUP
# Create database
create database ShopNovaDB;
use ShopnovaDB;

# NOTE: Data was imported using MySQL Workbench's "Table Data Import Wizard". 

# Import Returns table
select * from returns;
desc returns;

# Import Campaigns table
Select * from campaigns;
desc campaigns;

# Import customers table
select * from customers;
desc customers;

# Import Products table
select * from products;
desc products;

# Import orders table
select * from orders;
desc orders;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
# DATA VALIDATION
# Verify row counts
select count(*) as total_orders from orders;
select count(*) as total_customers from customers;
select count(*) as total_products from products;
select count(*) as total_returns from returns;
select count(*) as total_campaigns from campaigns;

# Check for duplicate IDs
select order_id,count(*) as duplicate_count from orders group by order_id having count(*)>1;
select customer_id,count(*) as duplicate_count from customers group by customer_id having count(*)>1;
select product_id,count(*) as duplicate_count from products group by product_id having count(*)>1;
select return_id,count(*) as duplicate_count from returns group by return_id having count(*)>1;

# check for null values
select sum(order_id is null) as orderid_null,sum(customer_id is null) as customerid_null,sum(product_id is null) as productid_null,
	sum(order_date is null) as orderdate_null,sum(delivery_date is null) as deliverydate_null,sum(coupon_code is null) as couponcode_null from orders;
-- Note: NULLs Expected: coupon_code is null because many orders have no coupon and delivery_date is null for cancelled orders.

select sum(customer_id is null) as customerid_null,sum(full_name is null) as fullname_null,
	sum(registration_date is null) as registrationdate_null from customers;
    
select sum(product_id is null) as productid_null,sum(product_name is null) as productname_null from products;

select sum(return_id is null) as returnid_null,sum(order_id is null) as orderid_null,
	sum(return_date is null) as returndate_null from returns;
    
select sum(campaign_id is null) as campaignid_null,sum(channel is null) as channel_null,sum(month is null) as month_null from campaigns;

# Validate table relationships (should return 0 rows)
select o.order_id,o.customer_id from orders o
left join customers c on o.customer_id=c.customer_id where c.customer_id is null;

select o.order_id,o.product_id from orders o
left join products p on o.product_id=p.product_id where p.product_id is null;

select r.return_id,r.order_id from returns r
left join orders o on r.order_id=o.order_id where o.order_id is null;

select r.return_id,r.customer_id from returns r
left join customers c on r.customer_id=c.customer_id where c.customer_id is null;

select r.return_id,r.product_id from returns r
left join products p on r.product_id=p.product_id where p.product_id is null;