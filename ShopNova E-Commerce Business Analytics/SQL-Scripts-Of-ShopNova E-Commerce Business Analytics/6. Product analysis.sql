# PRODUCT ANALYSIS
# Total Products
select count(product_id) as total_products from products;

# Total Categories
select count(distinct category) as total_categories from products;

# Total Sub Categories
select count(distinct sub_category) as total_sub_categories from products;

# Total Brands
select count(distinct brand) as total_brands from products;

# Average Product Rating
select round(avg(avg_rating),2) as average_product_rating from products;

# Average Selling Price
select round(avg(selling_price_inr),2) as average_selling_price from products;

# Average Cost Price
select round(avg(cost_price_inr),2) as average_cost_price from products;

# Average Gross Margin
select concat(round(avg(gross_margin_pct),2),'%') as average_gross_margin from products;

# Total Inventory Units
select concat(round(sum(stock_units)/1000,2),' K') as total_inventory_units from products;

# Out of Stock Products
select count(product_id) as out_of_stock_products from products where stock_units=0;

# Revenue by Category
select category,concat(round(sum(final_amount_inr)/1000000,2),' M') as revenue 
	from orders group by category order by sum(final_amount_inr) desc;

# Gross Margin by Category
select category,concat(round(sum((selling_price_inr-cost_price_inr)*100)/(sum(selling_price_inr)),2),'%') as gross_margin 
	from products group by category order by gross_margin desc;

# Return Rate by Category
select o.category,concat(round(count(r.return_id)*100/count(o.order_id),2),'%') as return_rate 
	from orders o left join returns r on o.order_id=r.order_id 
		where o.order_status='Delivered' group by o.category order by return_rate desc;

# Average Product Rating by Category
select category,round(avg(avg_rating),2) as average_rating from products group by category order by average_rating desc;

# Products by Category
select category,count(product_id) as total_products from products group by category order by total_products desc;

# Products by Brand
select brand,count(product_id) as total_products from products group by brand order by total_products desc;

# Top 10 Highest Rated Products
select product_name,avg_rating from products order by avg_rating desc limit 10;

# Top 10 Best Selling Products
select product_name,sum(quantity) as units_sold from orders where order_status='Delivered' 
	group by product_name order by units_sold desc limit 10;

# Bottom 10 Selling Products
select product_name,sum(quantity) as units_sold from orders where order_status='Delivered' 
	group by product_name order by units_sold limit 10;

# Inventory by Category
select category,concat(round(sum(stock_units)/1000,2),' K') as inventory_units 
	from products group by category order by sum(stock_units) desc;

# Inventory by Brand
select brand,concat(round(sum(stock_units)/1000,2),' K') as inventory_units 
	from products group by brand order by sum(stock_units) desc;

