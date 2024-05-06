Create database pizza_DB
use pizza_DB

select * from dbo.pizza_sales

--Total Revenue
select SUM(total_price) as Total_Revenue from dbo.pizza_sales

--Average order value
select SUM(total_price)/COUNT(distinct order_id) Average_order_value from dbo.pizza_sales

--Total pizza sold
select SUM(quantity) as Total_orders from dbo.pizza_sales

--Average pizza per order
select cast(cast(SUM(quantity) AS decimal(10,2))/cast(COUNT(Distinct order_id) as decimal(10,2)) 
as decimal(10,2)) as Avg_pizza_per_order from dbo.pizza_sales

--Charts Requirement

--Daily trends for total orders
select DATENAME(DW,order_date) as order_day, COUNT(distinct order_id) as Total_orders
from dbo.pizza_sales
group by DATENAME(DW,order_date)

--Monthly Trend for total order
select DATENAME(MONTH,order_date) AS Month_Name, count(distinct order_id) as Total_orders
from dbo.pizza_sales
group by DATENAME(MONTH,order_date)

select * from dbo.pizza_sales

--Percentage of sales by pizza category
select pizza_category,SUM(total_price) as Total_Revenue ,
SUM(total_price)* 100/(select sum(total_price) from dbo.pizza_sales WHERE MONTH(order_date)=1) 
as PCT from pizza_sales
WHERE MONTH(order_date)=1
group by pizza_category



--Percentage of sales by pizza size
select pizza_size,CAST(SUM(total_price)AS decimal(10,2)) as Total_Revenue ,
cast(SUM(total_price)* 100/(select sum(total_price) from dbo.pizza_sales 
Where DATEPART(quarter, order_date)=1) AS decimal(10,2)) 
as PCT from pizza_sales
Where DATEPART(quarter, order_date)=1
group by pizza_size
order by pizza_size


--Top 5 best seller by Revenue
select TOP 5 pizza_name, SUM(total_price) as Total_Revenue from dbo.pizza_sales
group by pizza_name
order by Total_Revenue desc

--bottom 5 best seller by Revenue
select TOP 5 pizza_name, SUM(total_price) as Total_Revenue from dbo.pizza_sales
group by pizza_name
order by Total_Revenue 

--TOP 5 best seller by total Quantity
select TOP 5 pizza_name, SUM(quantity) as Total_Quantity from dbo.pizza_sales
group by pizza_name
order by Total_Quantity DESC


--TOP 5 best seller by total Quantity
select TOP 5 pizza_name, count(DISTINCT order_id) as Total_orders from dbo.pizza_sales
group by pizza_name
order by Total_orders DESC

--BOTTOM 5 best seller by total Quantity
select TOP 5 pizza_name, count(DISTINCT order_id) as Total_orders from dbo.pizza_sales
group by pizza_name
order by Total_orders 

