
--Creating Database FIT-N-FINE----

use Fit_N_Fine2

create database Fit_N_Fine2
on primary
(name = 'Fit_N_Fine_Primary', Filename ='c:\DataClass1\dc_pm2.mdf',
size = 5mb, maxsize = 10mb, filegrowth = 1mb),
Filegroup Niit_Project_Group2_FG1
(name = 'Fit_N_Fine_FG_Dat1', Filename = 'c:\DataClass2\dc_fg2.ndf',
size = 1mb, maxsize = 10mb, filegrowth = 1mb)
LOG ON
(name = 'Niit_Project_Group2_Log', filename = 'c:\DataClass3\log2.ldf',
size = 1mb, maxsize = 10mb, filegrowth = 1mb)

drop database Fit_N_Fine

use Fit_N_Fine

--Creating Schema---

create schema HumanResources
create schema Transactions
create schema services
create schema Members

--Creating the HumanResources.staffdetails table----

create table HumanResources.StaffDetails
(
StaffID int constraint staff_pk primary key identity(100,1),
BranchID int,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Designation varchar(30)not null,
Address varchar(50) not null,
Phone varchar(20) constraint ck_phone check(Phone like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
)

--populate Staff Details Table--
insert into HumanResources.StaffDetails values(900,'Losene','Keita','Marketing Manager','03 chapel str','070-32-82-33-92')
insert into HumanResources.StaffDetails values(901,'Mohamed','Kaba','IT Professional','01 kabson str','081-12-47-55-88')
insert into HumanResources.StaffDetails values(902,'Fatumata','Fofana','Secretary General','01 mama str','070-47-89-84-45')
insert into HumanResources.StaffDetails values(903,'Nouhan','Sanoh','Engineer','06 kankan str','080-78-52-45-78')
insert into HumanResources.StaffDetails values(904,'Amadou','Thiam','Software Engineer','02 love str','070-78-58-98-45')
insert into HumanResources.StaffDetails values(905,'Adaeze','Iloafunam','Sales Manager','10 leonard str','090-61-61-42-66')
insert into HumanResources.StaffDetails values(906,'Mary jane','Iloafunam','Senior Staff','02 labake str','080-78-78-25-41')
insert into HumanResources.StaffDetails values(907,'Emmanuel','Tubert','Communication Manager','08 kankan str','081-78-45-54-45')
insert into HumanResources.StaffDetails values(908,'Mary','Okoro','Marketing Director','01 kabson str','071-78-45-21-12')
insert into HumanResources.StaffDetails values(909,'Mariama','Camara','Assistant Secretary','02 matoto str','070-78-45-12-32')

select * from HumanResources.StaffDetails

drop table HumanResources.StaffDetails

--Creating table HumanResources.FollowUp table---

create table HumanResources.FollowUp
(
Pros_MemberID int constraint pk_ProsId primary key identity(800,1),
StaffID int constraint fk_staffid references HumanResources.StaffDetails(StaffID),
BranchID int not null,
Pros_FName varchar(20) not null,
Pros_LName varchar(20) not null,
Phone varchar(20) not null constraint ck_phone3 check(Phone like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
Visit_Date datetime not null
)

--Creating trigger on HumanResources.FollowUp's table---
create trigger visitdate
on HumanResources.FollowUp
for insert
as
declare @visitDate datetime
select @visitDate = Visit_Date from inserted
if(@visitDate > CURRENT_TIMESTAMP)
begin
print 'visit date must not be greater than today date'
rollback transaction
end

--populate follow up table--

insert into HumanResources.FollowUp values(100,900,'Mariama','Camara','070-45-78-96-45','02/02/2019')
insert into HumanResources.FollowUp values(102,901,'Kadiatou','Cisse','081-78-32-74-78',GETDATE())
insert into HumanResources.FollowUp values(103,902,'Amara','Conde','081-23-78-45-78','01/01/2019')
insert into HumanResources.FollowUp values(104,903,'Lansanah','Keita','070-96-78-65-32',GETDATE())
insert into HumanResources.FollowUp values(105,904,'Makemeh','Keita','090-78-00-00-20','02/01/2019')
insert into HumanResources.FollowUp values(106,905,'Fatumata', 'Massalay','082-78-02-05-04','02/02/2019')
insert into HumanResources.FollowUp values(107,906,'Vamuyan','Dukuly','081-43-37-00-05','03/02/2019')
insert into HumanResources.FollowUp values(108,907,'Vasekou','Fofana','070-00-28-00-00','01/20/2019')
insert into HumanResources.FollowUp values(109,908,'Mahawa','Bangura','070-00-00-00-00','02/12/2019')
insert into HumanResources.FollowUp values(101,909,'Adaeze','Rita','080-20-20-20-00',GETDATE())
insert into HumanResources.FollowUp values(109,910,'Kadiatou','Cisse','081-78-32-74-78','01/12/2019')

select * from HumanResources.followup

drop table HumanResources.FollowUp

--creating Services.MembershipDetails Table(PlanMaster)---
Create table Services.MembershipDetails
(
PlanID int constraint pk_planid primary key identity(600,1),
Plan_Type varchar(20) constraint chk_plantype check(Plan_Type like 'Premium' or Plan_Type like 'Standard' or Plan_Type like 'Guest'),
Pros_MemberID int constraint fk_prosmemberid references HumanResources.FollowUp(Pros_MemberID),
Fee money
)

--inserting data into Services.MembershipDetails table---


insert into services.MembershipDetails values('Premium',800,$5000)
insert into Services.MembershipDetails values('Guest',801,$2000)
insert into Services.MembershipDetails values('Premium',802,$5000)
insert into Services.MembershipDetails values('Standard',803,$4000)
insert into Services.MembershipDetails values('Standard',804,$4000)
insert into Services.MembershipDetails values('Guest',805,$2000)
insert into Services.MembershipDetails values('Premium',806,$5000)
insert into Services.MembershipDetails values('Premium',807,$5000)
insert into Services.MembershipDetails values('Standard',808,$4000)
insert into Services.MembershipDetails values('Guest',809,$2000)

select * from Services.MembershipDetails

drop table services.MembershipDetails

--triggers for Fee table--

create trigger trgfee
	on Services.MembershipDetails
	for insert
	as
	declare @PlanType varchar(20)
	declare @Fee Money
	
	select @PlanType = Plan_Type from inserted
	select @Fee = Fee from inserted

	if(@PlanType='Premium')
	if(@Fee !=$5000)
	begin
	print 'please input the right figure for Premium'
	rollback transaction
	end

	if(@PlanType='Standard')
	if(@Fee !=$4000)
	begin
	print 'please input the right figure for Standard'
	rollback transaction
	end

	if(@PlanType='Guest')
	if(@Fee !=$2000)
	begin
	print 'please input the right figure for Guest'
	rollback transaction
	end

--Creating Services.PlanDetails Table---

create table Services.PlanDetails
(
FacilityID int constraint pk_facility primary key identity(500,1),
PlanID int constraint fk_Planid references Services.MembershipDetails(PlanID),
Plan_Details varchar(50) not null
)
--inserting into Services.PlanDetails table ---

insert into Services.PlanDetails values(600,'Complete Equipments + Aerobics + Instructor')
insert into Services.PlanDetails values(601,'Complete Equipment')
insert into Services.PlanDetails values(602,'Complete Equipments + Aerobics + Instructor')
insert into Services.PlanDetails values(603,'Complete Equipments + Aerobics')
insert into Services.PlanDetails values(604,'Complete Equipments + Aerobics')
insert into Services.PlanDetails values(605,'Complete Equipment')
insert into Services.PlanDetails values(606,'Complete Equipments + Aerobics + Instructor')
insert into Services.PlanDetails values(607,'Complete Equipments + Aerobics + Instructor')
insert into Services.PlanDetails values(608,'Complete Equipments + Aerobics')
insert into Services.PlanDetails values(609,'Complete Equipment')

select * from Services.PlanDetails

drop table services.PlanDetails

--Creating Members.MemberDetails table--

Create table Members.MemberDetails
(
MemberID int constraint member_pk primary key identity(200,1),
FirstName varchar(20) not null,
LastName varchar(20) not null,
Gender char(10) not null constraint chk_genger check(Gender in ('Male','Female')),
Address varchar(50) not null,
Phone varchar(20) constraint ck_phone check(Phone like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
FacilityID int constraint fk_Planid references Services.PlanDetails(FacilityID)
)

--populating the Members.MemberDetails table ---

insert into Members.MemberDetails values('Losene','Keita','Male','03 chapel str','070-89-78-45-00',500)
insert into Members.MemberDetails values('Mariama','Camara','Female','04 love str','070-78-54-45-05',501)
insert into Members.MemberDetails values('Lansanah','Keita','Male','04 Niclatown lib','077-45-45-00-00',502)
insert into Members.MemberDetails values('Makrubo','Saleh','Female','06 love str','080-15-15-14-14',503)
insert into Members.MemberDetails values('Ibrahima','Keita','Male','04 keita str','080-00-25-33-45',504)
insert into Members.MemberDetails values('Mawatta','Camara','Female','09 thank str','070-78-78-88-89',505)
insert into Members.MemberDetails values('Fatumata','Keita','Female','01 keita str','070-78-45-00-00',506)
insert into Members.MemberDetails values('Sekoubah','Kromah','Male','09 keita str','070-50-28-25-25',507)
insert into Members.MemberDetails values('Pavarlee','Massalay','Male','03 losene str','070-45-69-58-89',508)
insert into Members.MemberDetails values('Mayamu','Massalay','Female','01 kassanka str','070-55-55-55-00',509)

select * from Members.MemberDetails

drop table Members.MemberDetails

--creating Transactions.Revenue table---

create table Transactions.Revenue
(
PaymentID int constraint pk_paymentid primary key identity(400,1),
MemberID int constraint fk_memberid references Members.MemberDetails(MemberID),
Payment_Date date constraint chk_paymentDate check(Payment_Date >= CURRENT_TIMESTAMP),
Payment_Method varchar(10) constraint chk_paymentmethod check(Payment_Method in('Cash', 'Cheque', 'Card')),
CC_Number int,
CC_Name varchar(30),
Check_Number bigint,
Payment_Status varchar(10) constraint chk_paymentstatus check(Payment_Status in('Paid','Pending'))
)

create trigger trgcreditcard
	on Transactions.Revenue
	for insert
	as
	declare @creditnum int
	declare @creditname varchar(30)
	declare @paymet varchar(10)
	select @creditnum = CC_Number from inserted
	select @creditname = CC_Name from inserted
	select @paymet = Payment_Method from inserted

	if(@paymet='Card')
	if(@creditname is null or @creditnum is null)
	begin
	print 'please input value for Credit Card details'
	rollback transaction
	end

create trigger trgcheck
	on Transactions.Revenue
	for insert
	as
	declare @chequenum int
	declare @paymet varchar(10)
	select @chequenum = Check_Number from inserted
	select @paymet = Payment_Method from inserted

	if(@paymet='Cheque')
	if(@chequenum is null)
	begin
	print 'please input number of Cheque'
	rollback transaction
	end

--inserting into Transactions.Revenue table --

insert into Transactions.Revenue values(200,GETDATE()+1,'Card',2365,'Keita',null,'Paid')
insert into Transactions.Revenue values(201,'04/03/2019','Cash',null,null,null,'Paid')
insert into Transactions.Revenue values(202,GETDATE()+1,'Card',1420,'Fofana',null,'Paid')
insert into Transactions.Revenue values(203,'04/03/2019','Cheque',null,null,45684,'Pending')
insert into Transactions.Revenue values(204,'04/03/2019','Cheque',null,null,12356,'Paid')
insert into Transactions.Revenue values(205,GETDATE()+1,'Cash',null,null,null,'Paid')
insert into Transactions.Revenue values(206,'04/03/2019','Card',1016,'Camara',null,'Pending')
insert into Transactions.Revenue values(207,GETDATE()+1,'Card',2517,'Joise',null,'Paid')
insert into Transactions.Revenue values(208,'04/03/2019','Cheque',null,null,10505,'Pending')
insert into Transactions.Revenue values(209,'04/03/2019','Cash',null,null,null,'Pending')

select * from Transactions.Revenue

drop table transactions.revenue


--Creating HumanResources.Booking table

create table HumanResources.Booking
(
BookingID int constraint pk_bookingid primary key identity(300,1),
StaffID int constraint fk_booking_staffid references HumanResources.StaffDetails(StaffID) not null,
MemberID int constraint fk_memberid references Members.MemberDetails(MemberID) not null,
PlanID int not null,
FacilityID int constraint fk_facilityid references Services.PlanDetails(FacilityID) not null,
Desire_Day varchar(10) not null,
Desire_Time time not null,
Max_Num tinyint not null,
Actual_Num tinyint not null,
Booking_Status varchar(10) constraint chk_status check(Booking_Status like 'Booked' or Booking_Status like 'Available') not null
)

--creating insert trigger on HumanResources.Booking table---
create trigger trgActNum
 on HumanResources.Booking 
 for insert
 as
 declare @ActNum int
 declare @maxNum int
 select @ActNum = Actual_Num from Inserted
 select @maxNum = Max_Num from inserted
 
 if(@ActNum > @maxNum)
 begin
 print 'The Actual number should not be greater than the Maximum number'
 rollback transaction
 end
 
create trigger trgbookingstatus
 on HumanResources.Booking 
 for insert
 as
 declare @ActNum int
 declare @maxNum int
 declare @status varchar(10)
 select @ActNum = Actual_Num from Inserted
 select @maxNum = Max_Num from inserted
 select @status = Booking_Status from inserted

 if(@maxNum=@ActNum)
 if( @status='Available')
 begin
 print 'Please change status to Booked'
 rollback transaction
 end
 


--Populating HumanResources.Booking Table---

insert into HumanResources.Booking values(100,200,600,500,'Monday','12:00',20,20,'Booked')
insert into HumanResources.Booking values(101,201,601,501,'Monday','12:30',25,25,'Booked')
insert into HumanResources.Booking values(102,202,602,502,'Tuesday','11:00',20,12,'Available')
insert into HumanResources.Booking values(103,203,603,503,'Tuesday','11:00',10,5,'Available')
insert into HumanResources.Booking values(104,204,604,504,'Wednesday','10:00',15,15,'Booked')
insert into HumanResources.Booking values(105,205,605,505,'Wednesday','11:00',15,12,'Available')
insert into HumanResources.Booking values(106,206,606,506,'Wednesday','10:00',20,14,'Available')
insert into HumanResources.Booking values(107,207,607,507,'Thursday','12:00',10,10,'Booked')
insert into HumanResources.Booking values(108,208,608,508,'Thursday','11:00',30,27,'Available')
insert into HumanResources.Booking values(109,209,609,509,'Friday','11:00',12,12,'Booked')

select * from HumanResources.Booking

drop table HumanResources.Booking

--creating HumanResources.Feedback table---

create table HumanResources.Feedback 
(
RefID int constraint pk_refID primary key identity(700,1),
StaffID int constraint fk_staffid1 references HumanResources.StaffDetails(StaffID),
BookingID int constraint fk_bookingid references HumanResources.Booking(BookingID),
MemberID int constraint fk_feedback_memberid references Members.MemberDetails(MemberID),
Feedback_Type varchar(20) constraint chk_feedback check(Feedback_Type like 'Complaint' or Feedback_Type like 'Suggestion' or Feedback_type like 'Appreciation')
)

--Populating HumanResources.Feedback's table---

insert into HumanResources.Feedback values(100,300,200,'Appreciation')
insert into HumanResources.Feedback values(101,301,201,'Suggestion')
insert into HumanResources.Feedback values(102,302,202,'Complaint')
insert into HumanResources.Feedback values(103,303,203,'Complaint')
insert into HumanResources.Feedback values(104,304,204,'Appreciation')
insert into HumanResources.Feedback values(105,305,205,'Complaint')
insert into HumanResources.Feedback values(106,306,206,'Appreciation')
insert into HumanResources.Feedback values(107,307,207,'Suggestion')
insert into HumanResources.Feedback values(108,308,208,'Appreciation')
insert into HumanResources.Feedback values(109,309,209,'Suggestion')

select * from HumanResources.Feedback

drop table HumanResources.Feedback
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Extracting Member details admitted to the club in a particular month--
USE Fit_N_Fine2
create VIEW HumanResources.vwBooking
with SCHEMABINDING
AS SELECT b.MemberID, m.FirstName, m.LastName, m.Gender, m.Phone
FROM HumanResources.Booking b JOIN Members.MemberDetails m
on b.MemberID=m.MemberID

CREATE UNIQUE CLUSTERED INDEX idx_vwBooking
ON HumanResources.vwBooking(MemberID, FirstName, LastName, Gender, Phone)

--Extracting the member details for each member whose payment is pending--

 CREATE VIEW Transactions.vwRevenue
 WITH SCHEMABINDING
 AS SELECT r.MemberID, m.FirstName, m.LastName, m.Phone, r.Payment_Status
 FROM Transactions.Revenue r JOIN Members.MemberDetails m
 ON r.MemberID = m.MemberID

 CREATE UNIQUE CLUSTERED INDEX idx_vwRevenue
 ON Transactions.vwRevenue(MemberID, FirstName, LastName, Phone, Payment_Status)

 --Extracting the plan details, such as the plan name, the facilities offered, and the fee structure for each plan.--

 CREATE VIEW Services.vwPlanDetails
 WITH SCHEMABINDING
 AS SELECT f.Pros_MemberID, mp.Plan_Type, p.Plan_Details, mp.Fee
 FROM services.PlanDetails p JOIN services.MembershipDetails mp
 ON p.PlanID = mp.PlanID
 JOIN HumanResources.FollowUp f ON f.Pros_MemberID = mp.Pros_MemberID

 CREATE UNIQUE CLUSTERED INDEX idx_vwPlanDetails
 ON services.vwPlanDetails(Pros_MemberID, Plan_Type, Plan_Details, Fee)

 --Displaying a list of all the prospective members who visited a branch in a particular month--

 CREATE VIEW HumanResources.vwFollowup
 WITH SCHEMABINDING
 AS SELECT s.BranchID, f.Pros_FName, f.Pros_LName, f.Phone
 FROM HumanResources.FollowUp f JOIN HumanResources.StaffDetails s
 ON f.BranchID = s.BranchID

 CREATE UNIQUE CLUSTERED INDEX idx_vwFollowup
 ON HumanResources.vwFollowup(BranchID, Pros_FName, Pros_LName, Phone)

 --Displaying a list of feedbacks received from the members in a month and the action taken against a complaint or suggestion--

 CREATE VIEW HumanResources.vwFeedback
 WITH SCHEMABINDING
 AS SELECT f.StaffID, f.MemberID, f.Feedback_Type
 FROM HumanResources.Feedback f
 where f.Feedback_Type != 'Appreciation'

 CREATE UNIQUE CLUSTERED INDEX idx_Feedback
 ON HumanResources.vwFeedback(StaffID,MemberID,Feedback_Type)
 
 select * from HumanResources.vwFeedback
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

BACKUP DATABASE Fit_N_Fine2 
TO DISK = 'C:\Fit_N_FIne_Backup\Fit_N_Fine2.Bak'  
GO 

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Stroing Crucial Data in Encrypted Format--
USE Fit_N_FIne2  
GO  

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'niitproject2';  
go  

CREATE CERTIFICATE MemberDetailsPhone 
   WITH SUBJECT = 'Member Details Phone Numbers'
GO  

CREATE SYMMETRIC KEY MDP_SYM_KEY 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE MemberDetailsPhone
GO  

-- Create a column in which to store the encrypted data.  
ALTER TABLE Members.MemberDetails 
    ADD PhoneNumber varbinary(128)   
GO  

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY MDP_SYM_KEY  
   DECRYPTION BY CERTIFICATE MemberDetailsPhone

-- Encrypt the value in column NationalIDNumber with symmetric   
-- key SSN_Key_01. Save the result in column EncryptedNationalIDNumber.  
UPDATE Members.MemberDetails  
SET PhoneNumber = EncryptByKey(Key_GUID('MDP_SYM_KEY'), Phone);  
GO  


--------------------------------------------------------------------------------------------------------------------------------------------------------------------