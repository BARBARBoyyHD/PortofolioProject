----
select 
*
From Project.dbo.['Supermart Grocery Sales - Retai$'] ;
--------
select 
SUM(Sales)
From Project.dbo.['Supermart Grocery Sales - Retai$']

insert into Project.dbo.Sales_Revenue(OrderID,[Customer Name],Category,SubCategory,Sales,Discount,Profit,Revenue)
select
	OrderID,
	[Customer Name],
	Category,
	SubCategory,
	Sales,
	Discount,
	profit,
	(Sales - Discount - Profit) as Revenue
From Project.dbo.['Supermart Grocery Sales - Retai$']

order by 
	Revenue desc
-----------------------
CREATE TABLE Sales_Revenue (
    OrderId VARCHAR(MAX),
    [Customer Name] VARCHAR(255), 
    Category VARCHAR(255), 
    SubCategory VARCHAR(255), 
    Sales DECIMAL(18, 2), 
    Discount DECIMAL(18, 2), 
    Profit DECIMAL(18, 2), 
    Revenue DECIMAl(18,2)
);
----------------------
drop table Project.dbo.Sales_Revenue
-----
select 
*
from Project.dbo.Sales_Revenue
-------
select
	OrderId,
	
from Project.dbo.['Supermart Grocery Sales - Retai$']

select
count(OrderID) as komal
from Project.dbo.['Supermart Grocery Sales - Retai$']
where [Customer Name] = 'Komal';

select 
[Customer Name],
count(OrderId) as Customer

from Project.dbo.['Supermart Grocery Sales - Retai$']
group by [Customer Name]
order by Customer

select
Count(SubCategory) as Product
from Project.dbo.['Supermart Grocery Sales - Retai$']
where SubCategory='Soft Drinks' 
and  Year(OrderDate) between 2016 and 2017; 

	SELECT 
		[Customer Name],
		Category,
		SubCategory,
		OrderDate,
		COUNT(OrderID) AS Unit_sold,
		(Sales/COUNT(OrderID)) as Unit_Price,
		(Sales-Profit) as Cost,
		Sales,
		Discount,
		profit,
		((Sales *  COUNT(OrderID))*Discount)as Revenue,
		 COUNT(*) * 1 / COUNT(DISTINCT OrderID) AS AverageBasketSize,
		 ((Sales *  COUNT(OrderID))*Discount) / COUNT(OrderID) as Avg_order_value
	FROM  Project.dbo.['Supermart Grocery Sales - Retai$']
	GROUP BY 
		[Customer Name],
		Category,
		SubCategory,
		OrderDate,
		Sales,
		Discount,
		profit
	order by Revenue;

Create table ABS_and_AOV(
	[Customer Name] varchar(225),
	Category varchar(225),
	SubCategory varchar(225),
	OrderDate datetime,
	Unit_sold decimal(18,2),
	Unit_Price decimal(18,2),
	Cost decimal(18,2),
	Sales decimal(18,2),
	Discount decimal(18,2),
	profit decimal(18,2),
	Revenue decimal(18,2),
	AverageBasketSize decimal(18,2),
	Avg_order_value decimal(18,2)
)

INSERT INTO Project.dbo.ABS_and_AOV (
    [Customer Name],
    Category,
    SubCategory,
    OrderDate,
    Unit_sold,
    Unit_Price,
	Cost,
    Sales,
    Discount,
    profit,
    Revenue,
    AverageBasketSize,
    Avg_order_value
)
--------------


with SalesData as (
	SELECT 
    [Customer Name],
    Category,
    SubCategory,
    OrderDate,
    COUNT(OrderID) AS Unit_sold,
    (Sales/COUNT(OrderID)) as Unit_Price,
    (Sales-Profit) as Cost, 
    Sales,
    Discount,
    profit,
    ((Sales *  COUNT(OrderID))*Discount) as Revenue,
    COUNT(*) * 1 / COUNT(DISTINCT OrderID) AS AverageBasketSize,
    ((Sales *  COUNT(OrderID))*Discount) / COUNT(OrderID) as Avg_order_value
	FROM  Project.dbo.['Supermart Grocery Sales - Retai$']
	GROUP BY 
    [Customer Name],
    Category,
    SubCategory,
    OrderDate,
    Sales,
    Discount,
    profit
	
)
INSERT INTO Project.dbo.ABS_and_AOV (
    [Customer Name],
    Category,
    SubCategory,
    OrderDate,
    Unit_sold,
    Unit_Price,
	Cost,
    Sales,
    Discount,
    profit,
    Revenue,
    AverageBasketSize,
    Avg_order_value
)
select 
  [Customer Name],
    Category,
    SubCategory,
    OrderDate,
    Unit_sold,
    Unit_Price,
    Cost,
    Sales,
    Discount,
    profit,
    Revenue,
    AverageBasketSize,
    Avg_order_value
from SalesData
order by Revenue


select 
*
from Project.dbo.ABS_and_AOV

-- Top category 

WITH top_category AS (
    SELECT
        Category,
        SUM(Revenue) AS Total_revenue
    FROM
        Project.dbo.ABS_and_AOV
    GROUP BY
        Category
)

SELECT 
    tc.Category,
    tc.Total_revenue
FROM 
    top_category AS tc
ORDER BY 
    tc.Total_revenue DESC;


-- TOP Product
with top_product as(
	select
		SubCategory,
        SUM(Revenue) AS Total_revenue
	from 
		Project.dbo.ABS_and_AOV
	group by 
		SubCategory
)

select 
	tp.SubCategory,
	tp.Total_revenue
from top_product as tp

order by tp.Total_revenue



