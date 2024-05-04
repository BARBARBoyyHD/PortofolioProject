select
	*
from dbo.Sales_transactions
where Quantity < 0

delete from dbo.Sales_transactions
where Quantity < 0

select
	*
from dbo.Sales_transactions
where TransactionNo like '%C'

delete from dbo.Sales_transactions
where ProductNo is null

select 
	count(TransactionNO)
from dbo.Sales_transactions

-- Find the total of revenue

select 
	sum(Revenue) as total_Revenue
from dbo.Sales_transactions

-- Find the Highest country by Revenue
select
	Country,
	sum(Revenue) as total_revenue
from  dbo.Sales_transactions

group by Country
order by total_revenue desc

-- Find the Highest Product by Revenue and quantity 

select 
	ProductName,
	sum(Quantity) as qt,
	sum(Revenue) as rev
from dbo.Sales_transactions
group by ProductName
order by rev desc
-- Find The Highest Product in UK

select 
	ProductName,
	sum(Quantity) as qt,
	sum(Revenue) as rev
from dbo.Sales_transactions
where Country = 'United Kingdom' 


group by ProductName
order by rev desc

update  dbo.Sales_transactions

set Country = 'Ireland'

where Country = 'EIRE'

-- Lets See Australia

select 
	ProductName,
	sum(Quantity) as qt,
	sum(Revenue) as rev
from dbo.Sales_transactions
where Country = 'Australia' 


group by ProductName
order by rev desc

-- Average CLV per Customer

select 
Country,
AVG(CLV) as CLV_avg
from dbo.Sales_transactions
group by Country
order by CLV_avg desc
