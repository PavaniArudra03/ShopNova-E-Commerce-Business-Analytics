# RETURNS ANALYSIS
# Total Returns
select count(return_id) as total_returns from returns;

# Total Refund Amount
select concat(round(sum(refund_amount_inr)/1000000,2),' M') as total_refund_amount from returns;

# Average Refund Amount
select round(avg(refund_amount_inr),2) as average_refund_amount from returns;

# Return Rate
select concat(round((select count(*) from returns)*100/(select count(*) from orders),2),'%') as return_rate;

# Returns by Category
select category,count(return_id) as total_returns from returns group by category order by total_returns desc;

# Returns by Top 10 Return Reason 
select return_reason,count(return_id) as total_returns from returns group by return_reason order by total_returns desc limit 10;

# Returns by Refund Status
select refund_status,count(return_id) as total_returns from returns group by refund_status order by total_returns desc;

# Returns by Refund Method
select refund_method,count(return_id) as total_returns from returns group by refund_method order by total_returns desc;

# Refund Amount by Category
select category,concat(round(sum(refund_amount_inr)/1000000,2),' M') as refund_amount 
	from returns group by category order by sum(refund_amount_inr) desc;

# Top 10 Products with Highest Refund Amount
select product_name,concat(round(sum(refund_amount_inr)/1000000,2),' M') as refund_amount 
	from returns group by product_name order by sum(refund_amount_inr) desc limit 10;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# CAMPAIGN ANALYSIS
# Total Campaign Budget
select concat(round(sum(budget_inr)/1000000,2),' M') as total_budget from campaigns;

# Total  Spend
select concat(round(sum(amount_spent_inr)/1000000,2),' M') as total_marketing_spend from campaigns;

# Total Revenue from Campaigns
select concat(round(sum(revenue_generated_inr)/1000000,2),' M') as total_revenue_from_campaigns from campaigns;

# Return on Ad Spend (ROAS)
select round(sum(revenue_generated_inr)/sum(amount_spent_inr),2) as overall_roas from campaigns;

# Average ROAS
select round(avg(roas),2) as average_roas from campaigns;

# ROAS by Channel
select channel,round(sum(revenue_generated_inr)/sum(amount_spent_inr),2) as roas 
	from campaigns group by channel order by roas desc;

# Total Click Through Rate (CTR)
select concat(round(sum(clicks)*100/sum(impressions),2),'%') as overall_ctr from campaigns;

# CTR by Channel
select channel,concat(round(sum(clicks)*100/sum(impressions),2),'%') as ctr 
	from campaigns group by channel order by ctr desc;

# Overall Conversion Rate
select concat(round(sum(conversions)*100/sum(clicks),2),'%') as conversion_rate from campaigns;

# Conversion Rate by Channel
select channel,concat(round(sum(conversions)*100/sum(clicks),2),'%') as conversion_rate 
	from campaigns group by channel order by conversion_rate desc;

# Average Cost Per Click (CPC)
select round(sum(amount_spent_inr)/sum(clicks),2) as average_cpc from campaigns;

# CPC by Channel
select channel,round(sum(amount_spent_inr)/sum(clicks),2) as cpc from campaigns group by channel order by cpc;

# Total Impressions
select concat(round(sum(impressions)/1000000,2),' M') as total_impressions from campaigns;

# Total Clicks
select concat(round(sum(clicks)/1000,2),' K') as total_clicks from campaigns;

# Total Conversions
select concat(round(sum(conversions)/1000,2),' K') as total_conversions from campaigns;

# Budget Utilisation
select concat(round(sum(amount_spent_inr)*100/sum(budget_inr),2),'%') as budget_utilisation from campaigns;

# Revenue by Channel
select channel,concat(round(sum(revenue_generated_inr)/1000000,2),' M') as revenue 
	from campaigns group by channel order by sum(revenue_generated_inr) desc;

# Marketing Spend by Channel
select channel,concat(round(sum(amount_spent_inr)/1000000,2),' M') as marketing_spend
	from campaigns group by channel order by sum(amount_spent_inr) desc;

