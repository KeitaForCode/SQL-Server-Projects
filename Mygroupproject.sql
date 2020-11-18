Drop Database ShopHere


---Storing the Database in the C:/drive---

	CREATE DATABASE Shop_Here
ON PRIMARY
(NAME='Shop_Here_PRIMARY',
FILENAME='C:\Keita\Shop_Here_PRM.MDF',
SIZE=20MB,
MAXSIZE=100MB,
FILEGROWTH=10MB),
FILEGROUP Shop_Here_FG1
( NAME = 'Shop_Here_FGI_DATA1',
FILENAME = 'C:\Keita\Shop_Here_FGI_1.NDF',
SIZE=20MB,
MAXSIZE=150MB,
FILEGROWTH=5MB),
(NAME= 'Shop_Here_FG1_DAT2',
FILENAME = 'C:\Keita\Shop_Here_FG1_2.NDF',
SIZE =20MB,
MAXSIZE = 150MB,
FILEGROWTH=5MB)
LOG ON 
( NAME='Shop_Here_LOG',
FILENAME='C:\Keita\Shop_Here.lDF',
SIZE=20MB,
MAXSIZE=150MB,
FILEGROWTH=5MB)
GO



Create Schema HumanResources

drop table HumanResources.Employee

Create table HumanResources.Employee
(
EmployeeID  int primary key  identity(101,1) not null,
FirstName varchar(20),
LastName varchar(20),
City varchar(20),
Phone varchar(30) check(Phone like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
)

select * from HumanResources.Employee

insert into HumanResources.Employee values('Losene','Keita','Conakry','070-124-7854')
insert into HumanResources.Employee values('Mayama', 'Massalay','Monrovia','070-928-2339')
insert into HumanResources.Employee values('Tom','Papailiou','Brisbane','081-145-4521')
insert into HumanResources.Employee values('Makrubo','Salleh','Zorzor','070-124-1578')
insert into HumanResources.Employee values('Lassana','Keita','Monrovia','070-258-4587')
insert into HumanResources.Employee values('Ibrahima','Keita','Kassanka','090-784-7885')
insert into HumanResources.Employee values('Sidiki','Gassamba','Kankan','081-785-8955')
insert into HumanResources.Employee values('Fatu','Massalay','Lagos','070-785-4578')
insert into HumanResources.Employee values('Makemeh','Douno','Conakry','070-784-7784')
insert into HumanResources.Employee values('Mawatta', 'Keita','Macenta','081-784-8899')

 

Create Schema Transactions

drop table Transactions.OrderDetails

Create table Transactions.OrderDetails
(
PurchaseOrderID int primary key identity(201,1) not null,
EmployeeID int not null references HumanResources.Employee(EmployeeID),
OrderDate Datetime check(OrderDate < GetDate()), 
ReceivingDate Datetime,
ItemID int not null foreign key references Items.ItemDetails(ItemID) ,
QuantityOrdered int check(QuantityOrdered>0),
QuantityReceived int check(QuantityReceived > 0),
UnitPrice money check(UnitPrice > 0),
ShipMethod varchar(20),
OrderStatus varchar(30)
)

insert into Transactions.OrderDetails values('101','02/03/2017','08/03/2017','501','500','400','$80','Import','Received')
insert into Transactions.OrderDetails values('103','03/04/2017','10/04/2017','502','250','150','$120','Home Produce','Received')
insert into Transactions.OrderDetails values('104','04/05/2017','1/05/2017','504','300','250','$300','Entreport','Cancelled')
insert into Transactions.OrderDetails values('105','05/06/2018','06/08/2018','505','150','100','$50','Import','Cancelled')
insert into Transactions.OrderDetails values('106','06/07/2018','08/08/2018','506','300','200','$250','Home Produce','Received')
insert into Transactions.OrderDetails values('107','04/04/2018','04/05/2018','508','400','300','$180','Entreport','Received')
insert into Transactions.OrderDetails values('108','05/05/2018','05/07/2018','509','150','50','$170','Import','Cancelled')
insert into Transactions.OrderDetails values('109','07/08/2018','09/08/2018','510','600','600','$280','Import','Received')
insert into Transactions.OrderDetails values('110','01/02/2018','02/03/2018','511','500','300','$140','Home Produce','Received')
insert into Transactions.OrderDetails values('111','02/05/2018','02/05/2018','512','200','200','$300','EntrePort','Received')

select * from Transactions.OrderDetails

Create Schema Supplier

Create table Supplier.SupplierDetails
(
SupplierID int primary key identity(301,1),
FirstName varchar(40),
LastName varchar(40),
Address Varchar(50),
Phone varchar(30) check(Phone like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
Country Varchar(30)
)

drop table Supplier.SupplierDetails

insert into Supplier.SupplierDetails values('Sekou','Sanoh','03 Chapel Street','072-785-7854','Nigeria')
insert into Supplier.SupplierDetails values('Amara','Sesay','05 Leonaed Street','021-785-7854','Nigeria')
insert into Supplier.SupplierDetails values('Amodou','Thiam','05 imam street','070-457-7854','Nigeria')
insert into Supplier.SupplierDetails values('Adaeze','Iloafunam','02 Sunny Ade Street','081-785-4575','Nigeria')
insert into Supplier.SupplierDetails values('Mary','Jane','05 Sunny Ade Street','090-784-7854','Nigeria')
insert into Supplier.SupplierDetails values('Luke','Shaw','02 keisoft Street','090-755-5555','Nigeria')
insert into Supplier.SupplierDetails values('Salif','Keita','05 love street','081-784-7854','Guinea')
insert into Supplier.SupplierDetails values('Losene','Massalay','06 Ibrahima Street','081-784-4584','Guinea')
insert into Supplier.SupplierDetails values('Casper','Michael','08 michael street','081-784-4444','Nigeria')
insert into Supplier.SupplierDetails values('Bobby','Flomo','12 Creeping Street','090-785-8585','Burkina Fasso')


select * from Supplier.SupplierDetails

Create Schema Items
drop table Items.ProductCategory

Create table Items.ProductCategory
(
CategoryID int primary key identity(401,1) not null,
CategoryName char(30) check(CategoryName like 'HouseHole' or CategoryName like 'Sport' or CategoryName like 'Accessories' or CategoryName like 'Clothing'),
CategoryDescription varchar(50)
)

insert into Items.ProductCategory values('HouseHole','Family Eatries')
insert into Items.ProductCategory values('Accessories','Mobile Phones')
insert into Items.ProductCategory values('Sport','Jersey')
insert into Items.ProductCategory values('Clothing','Childen Wear')
insert into Items.ProductCategory values('Accessories','Televission')
insert into Items.ProductCategory values('Clothing','Adult Wear')
insert into Items.ProductCategory values('HouseHole','Dining Table')
insert into Items.ProductCategory values('Sport','Football')
insert into Items.ProductCategory values('Clothing','Jeans')
insert into Items.ProductCategory values('Sport','Basket Ball')


Select * from Items.ProductCategory  

drop table Items.ItemDetails


Create table Items.ItemDetails
(
ItemID int primary key identity(501,1),
ItemName Varchar(20),
ItemDescription varchar(50),
UnitPrice Money  check (UnitPrice > 0),
QuantityInHand int  check (QuantityInHand > 0),
ReorderLevel int  check (ReorderLevel > 0),
ReorderQuantity int  check (ReorderQuantity > 0),
CategoryID int not null foreign key references Items.ProductCategory(CategoryID),
SupplierID int not null foreign key references Supplier.SupplierDetails(SupplierID)
)

insert into Items.ItemDetails values('Mobile Phones','For making Call','$180','200','2','50','401','301')
insert into Items.ItemDetails values('Cars','Automobile','$25000','50','3','10','402','301')
insert into Items.ItemDetails values('Laptops','Electronics','$400','600','2','300','404','303')
update Items.ItemDetails set SupplierID = '302' where ItemID = 502
insert into Items.ItemDetails values('Fan','Electronics','$50','250','3','150','405','304')
insert into Items.ItemDetails values('Desktops','Electronics','$300','500','4','300','406','305')
insert into Items.ItemDetails values('Kettle','Kitchen Appliances','$70','400','2','150','407','307')
insert into Items.ItemDetails values('Blender','Kitchen Appliances','$30','350','3','200','408','308')
insert into Items.ItemDetails values('Knife','Kitchen Appliances','$20','200','1','50','409','309')
insert into Items.ItemDetails values('Bluetooth Radio','Electronics','$60','800','4','450','410','310')
insert into Items.ItemDetails values('Wireless Mouse','Electronics','$50','600','3','300','411','311')

select * from Items.ItemDetails


--Trigger on transactions.orderdetails where QuantityRecieved should not be greater than QuantityOrdered

 create trigger trgTransactions On
 Transactions.OrderDetails
 For Insert
 As
 Declare @QuantityReceived int, @QuantityOrdered int
 Select @QuantityReceived=QuantityReceived from Transactions.OrderDetails
 Select @QuantityOrdered=quantityordered from Transactions.OrderDetails

	if(@QuantityReceived > @QuantityOrdered)
	Begin
		Print'Quantity Received should no be greater than Quantity Ordered'
		Rollback Transaction
	Return
End


  ---Trigger To Update QuantityInHand and ItemID automatically Whenever 
   ---a Record is Inserted into the Table---

	Create Trigger TrgTable
	On Transactions.OrderDetails
	after Insert, Update
	As
	Update Items.ItemDetails set QuantityInHand = Items.ItemDetails.QuantityInHand 
	+ t.ItemID From Transactions.OrderDetails t inner join inserted on
	t.ItemID  = t.ItemID

--- Calculations for the Transactions made for all the Order in a particular month--

select sum(QuantityOrdered) as 'Total' from Transactions.OrderDetails 


create login NewLogin 
with password ='losenekeita1',
Default_Database = master,
Default_Language = US_English

go

alter login NewLogin enable
go

create user LoseneKeita for login NewLogin 
with default_schema = [DBO]
go

create login NewLogin2
with password = 'callmeanyone',
 Default_Database = master,
 Default_Language = US_English
 go

 alter login NewLogin2 enable
 go

create user okaforchibuzor for login NewLogin2
with default_schema = [DBO]
go

create login NewLogin3
with password = 'callmenosa',
Default_Database = master,
Default_Language = US_English
go

alter login NewLogin3 enable
go

create user nosaone for login NewLogin3
with default_Schema = [DBO]
go
