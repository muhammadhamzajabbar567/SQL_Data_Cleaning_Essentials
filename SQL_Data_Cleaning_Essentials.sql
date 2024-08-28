create Database SQL_Data_Cleaning_Essentials
use SQL_Data_Cleaning_Essentials

drop table SalesTbl
CREATE table SalesTbl (
SalesID int primary key not null identity(1,1),
ProductName varchar(100),
SalesAmount varchar(100),
SalesDate varchar(100)
)
insert into SalesTbl values('Laptop',50000, '2024-08-01' )
insert into SalesTbl values('iPhoneX',70000, '2022-08-02' )
insert into SalesTbl values(Null,50000, '2024-08-01' )
insert into SalesTbl values('Laptop',Null, '2024-08-01' )
insert into SalesTbl values('Tablet',59000, Null )
select * from SalesTbl

--Identifying Missing Data 
select * from SalesTbl where 
ProductName is Null or SalesAmount is null or SalesDate is null

CREATE table OrderTbl (
OrderID int primary key not null identity(1,1),
CustomerID int,
OrderDate varchar(100)
)
insert into OrderTbl values  (101, '2024-09-09')
insert into OrderTbl values  (102, '2023-02-03')
insert into OrderTbl values  (101, '2024-09-09')
insert into OrderTbl values  (103, '2014-12-07')
select * from OrderTbl

--Identify Duplicate Records
select OrderID,CustomerID,OrderDate,
COUNT(*) over (partition by CustomerID,OrderDate) as DuplicateRecords
from OrderTbl

-- Removing Duplicates Record
with CTE as (
select OrderID,CustomerID,OrderDate,ROW_NUMBER() over (partition by CustomerID,OrderDate order by OrderID)
as RowNum from OrderTbl
) 
delete from OrderTbl where OrderID in
(select OrderID from CTE where RowNum > 1)

select * from OrderTbl

--Handling Missing Values from SalesTbl
select * from SalesTbl
delete from SalesTbl 
where ProductName is null or SalesAmount is null or SalesDate is null

--if you want to replace missing values with default values 
Update SalesTbl set 
ProductName = 'Unknown'
where ProductName is Null

Update SalesTbl set 
SalesAmount = 0
where SalesAmount is Null

Update SalesTbl set 
SalesDate = '2024-01-01'
where SalesDate is Null

select * from SalesTbl