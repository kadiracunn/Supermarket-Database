--Creating Tables
create table BRAND (
brandName nvarchar(50) primary key NOT NULL,
--Using a unique constraint except the primary key(unique) constraint.
phoneNumber varchar(25) unique,
emailAddress varchar(50),
city nvarchar(25),
state nvarchar(25),
zipCode char(5),
dayForSell varchar(10)
);

create table SECTION (
--By using identity, increment the section ID one by one.
sectionID tinyint primary key NOT NULL identity (1,1),
sectionName nvarchar(50)
);

create table PRODUCT_INFO(
--By using identity, increment the productIDForInfo one by one.
productIDForInfo int primary key NOT NULL identity (1,1),
productName nvarchar(50),
price float(24),
brandName nvarchar(50) foreign key references BRAND(brandName),
sectionNo tinyint foreign key references SECTION(sectionID),
discount float(24) default(NULL)
);

create table PRODUCT (
--This attribute is defined for barcode number and we want to initialize it from one billion.
--After this definition, by using identity keyword, increment the product ID one by one.
productID int primary key NOT NULL identity (1000000000,1),
productIDForInfo int foreign key references PRODUCT_INFO(productIDForInfo),
buyDate date,
sellDate date default(NULL),
expirationDate date,
--Defining constraints for buying and seling dates.
constraint buyAndSellCheck check (buyDate <= sellDate),
constraint expirationForProduct check (expirationDate >= sellDate)
);

create table EMPLOYEE (
SSN varchar(11) primary key NOT NULL,
firstName nvarchar(25),
lastName nvarchar(25),
birthDate date,
age smallint,
phoneNumber varchar(25),
salary smallint,
sectionID tinyint foreign key references SECTION(sectionID),
cStartDate date,
cEndDate date,
daysOff nvarchar(20),
workingDay smallint,
--Defining constraints for employees.
constraint controlForEmployee check (cStartDate < cEndDate)
);

create table REGULAR_CUSTOMER (
customerID smallint primary key NOT NULL,
firstName nvarchar(25),
lastName nvarchar(25),
phoneNumber varchar(25)
);

create table PROMOTION (
--By using identity, increment the promotionID one by one.
promotionID tinyint primary key NOT NULL identity(1,1),
promotionName nvarchar(50),
startDate date,
endDate date,
discountAmount float,
brandName nvarchar(50) foreign key references BRAND(brandName),
--Defining constraints for employees.
constraint controlForPromotion check (startDate < endDate)
);

create table PAYMENT (
--By using identity, increment the paymentID one by one.
paymentID bigint primary key NOT NULL identity(1,1),
paymentDescription char(5),
customerID smallint foreign key references REGULAR_CUSTOMER(customerID),
productID int foreign key references PRODUCT(productID) unique,
promotionID tinyint foreign key references PROMOTION(promotionID) default(NULL),
--Defining paymentDate as default. If it is not entered, it takes the date of same day.
paymentDate date default (format(GETDATE(), 'yyyy-mm-dd')),
amount float(24)
);

--Required indices/indexes
create index customer_fullName
on REGULAR_CUSTOMER (firstName, lastName);

create index employee_fullName
on EMPLOYEE (firstName, lastName);

--Defining a computed column for age
Update EMPLOYEE
Set age = DATEDIFF(year, birthDate, GETDATE())

--Copy for control stock
INSERT INTO PRODUCT (productIDForInfo, buyDate, sellDate, expirationDate)
SELECT
 productIDForInfo, buyDate, sellDate, expirationDate
FROM
  PRODUCT
  where 
  productID >= 1000000000 and productID <= 1000000036 


---------------------------------------------------------------------------------------
-------Stored Procedures--------

--Stored Procedure for Brand
--Inserting New Brand
create procedure sp_insertBrand
@brandName nvarchar(50), 
@phoneNumber varchar(25),
@emailAddress varchar(50),
@city nvarchar(25),
@state nvarchar(25),
@zipCode char(5),
@dayForSell varchar(10)
 AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO BRAND(brandName,phoneNumber,emailAddress,city,state,
	                  zipCode,dayForSell)
    VALUES (@brandName,@phoneNumber,@emailAddress,@city,@state,
	                  @zipCode,@dayForSell);
    -- Insert statements for procedure here
    END

exec sp_insertBrand @brandName = 'Eker', @phoneNumber = '02324799687' , 
                    @emailAddress = 'info@eker.com' , @city = 'İzmir' , 
					@state = 'Bornova' , @zipCode = '35060' ,
					@dayForSell = 'Cuma'
---------------------------------------------------------------------------------------
--Stored Procedure for Brand
--Updating Brand's phone number if it changes
create procedure sp_brandPhone
@brandName nvarchar(50), 
@phoneNumber varchar(25)
AS
  BEGIN
         SET NOCOUNT ON;
    UPDATE BRAND
	SET phoneNumber = @phoneNumber
	FROM BRAND  
	WHERE brandName = @brandName 
 END

 exec sp_brandPhone @brandName = 'Eker', @phoneNumber = '01234567890' 

---------------------------------------------------------------------------------------

--Stored Procedure for Employee
--Inserting New Employee
create procedure sp_insertEmployee
@SSN varchar(11),
@firstName nvarchar(25),
@lastName nvarchar(25),
@birthDate date,
@age smallint,
@phoneNumber varchar(25),
@salary smallint,
@sectionID tinyint,
@cStartDate date,
@cEndDate date,
@daysOff nvarchar(20),
@workingDay smallint
AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO EMPLOYEE(SSN,firstName,lastName,birthDate,age,
                         phoneNumber,salary,sectionID,cStartDate,
                         cEndDate,daysOff,workingDay)
    VALUES (@SSN,@firstName,@lastName,@birthDate,@age,
            @phoneNumber,@salary,@sectionID,@cStartDate,
            @cEndDate,@daysOff,@workingDay);
    -- Insert statements for procedure here
    END 

exec sp_insertEmployee @SSN = '98765432100' , @firstName = 'Murat', 
                       @lastName = 'Gündoğdu' , @birthDate = '1995-05-17' ,
					   @age = NULL , @phoneNumber = '05398765432' , 
					   @salary = 3100 , @sectionID = 2 , 
					   @cStartDate = '2017-12-03' , @cEndDate = '2022-12-03' , 
					   @daysOff = 'Salı' , @workingDay = NULL




---------------------------------------------------------------------------------------

--Stored Procedure for Employee
--Deleting an Employee
create procedure sp_deleteEmployee
@SSN varchar(11)
AS
  BEGIN
         SET NOCOUNT ON;
    DELETE FROM EMPLOYEE
	WHERE SSN = @SSN
    -- Insert statements for procedure here
    END 

exec sp_deleteEmployee @SSN = '98765432100' 
---------------------------------------------------------------------------------------

--Stored Procedure for Employee
--Updating Employee's contract date and salary
create procedure sp_updateForEmployee
@SSN varchar(11),
@cEndDate date,
@salary smallint
AS
  BEGIN
         SET NOCOUNT ON;
    UPDATE EMPLOYEE
	SET cEndDate = @cEndDate , salary = @salary 
	FROM EMPLOYEE  
	WHERE SSN = @SSN 
 END

 exec sp_updateForEmployee @SSN = '44444444444' , @cEndDate ='2026-04-29' , @salary = 3500
---------------------------------------------------------------------------------------

--Stored Procedure for Payment
--Inserting Payment
  create procedure sp_insertPayment
  @description char(5), @customerId smallint, @productId int
  AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO PAYMENT(paymentDescription,customerID,productID,paymentDate)
    VALUES (@description,@customerId,@productId,GETDATE());
    -- Insert statements for procedure here
    END

exec sp_insertPayment @description ='card' , @customerId = 2 , @productId = 1000000441

---------------------------------------------------------------------------------------

--Stored Procedure for Product
--Inserting Product
create procedure sp_insertProduct
@productIDForInfo int,
@buyDate date,
@expirationDate date
 AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO PRODUCT(productIDForInfo,buyDate,expirationDate)
    VALUES (@productIDForInfo,@buyDate,@expirationDate);
    -- Insert statements for procedure here
    END

exec sp_insertProduct @productIDForInfo = 324 , @buyDate = '2020-12-06' , @expirationDate = '2022-12-06'
---------------------------------------------------------------------------------------

--Stored Procedure for Product_Info (Insert)
create procedure sp_insertProductInfo
@productName nvarchar(50),
@price float(24),
@brandName nvarchar(50),
@sectionNo tinyint,
@discount float
 AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO PRODUCT_INFO(productName,price,brandName,sectionNo,discount)
    VALUES (@productName,@price,@brandName,@sectionNo,@discount);
    -- Insert statements for procedure here
    END

exec sp_insertProductInfo @productName = 'Nescafe Gold 200gr' , @price = 47 , 
                          @brandName = 'Nestle' , @sectionNo = 2 , @discount = NULL

---------------------------------------------------------------------------------------

--Stored Procedure for Product_Info (Update)
create procedure sp_updateProductInfo
@productIDForInfo int,
@price float(24)
AS
  BEGIN
         SET NOCOUNT ON;
    UPDATE PRODUCT_INFO
	SET price = @price
	FROM PRODUCT_INFO  
	WHERE productIDForInfo = @productIDForInfo 
 END

 exec sp_updateProductInfo @productIDForInfo = 371 , @price = 52

---------------------------------------------------------------------------------------

--Stored Procedure for Promotion
--Inserting Promotion
create procedure sp_insertPromotion
@promotionName nvarchar(50),
@startDate date,
@endDate date,
@discountAmount float,
@brandName nvarchar(50)
 AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO PROMOTION(promotionName,startDate,
                             endDate,discountAmount,brandName)
    VALUES (@promotionName,@startDate,@endDate,
            @discountAmount,@brandName);
    -- Insert statements for procedure here
    END

exec sp_insertPromotion @promotionName = 'Okula Dönüş' , @startDate = '2020-09-01' ,
                        @endDate = '2021-03-01' , @discountAmount = 0.3 , @brandName = 'Faber-Castell'
---------------------------------------------------------------------------------------

--Stored Procedure for Customer
--Inserting Customer
create procedure sp_insertCustomer
@customerID smallint,
@firstName nvarchar(25),
@lastName nvarchar(25),
@phoneNumber varchar(25)
AS
  BEGIN
         SET NOCOUNT ON;
    INSERT INTO REGULAR_CUSTOMER(customerID,firstName,lastName,phoneNumber)
    VALUES (@customerID,@firstName,@lastName,@phoneNumber);
    -- Insert statements for procedure here
    END

exec sp_insertCustomer @customerID = 25,  @firstName = 'Kaan' , @lastName = 'Yavuz',
                       @phoneNumber = '05321233210'

---------------------------------------------------------------------------------------

--Stored Procedure for Customer
--Update Phone No for Customer
create procedure sp_updateTelForCustomer
@customerID smallint,
@phoneNumber varchar(25)
AS
  BEGIN
         SET NOCOUNT ON;
    UPDATE REGULAR_CUSTOMER
	SET phoneNumber = @phoneNumber
	FROM REGULAR_CUSTOMER  
	WHERE customerID = @customerID
 END

exec sp_updateTelForCustomer @customerID = 25 , @phoneNumber = '05999999999'

---------------------------------------------------------------------------------------

--------Triggers--------
--Trigger 1 (for amount)

create trigger trg_forAmount
ON  PAYMENT
   AFTER INSERT
AS 
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    UPDATE p
    set p.amount=pri.price
    from PAYMENT p inner join inserted i on i.paymentID=p.paymentID
    inner join PRODUCT pr on pr.productID=p.productID
    inner join PRODUCT_INFO pri on pri.productIDForInfo=pr.productIDForInfo
    -- Insert statements for trigger here

END
GO

---------------------------------------------------------------------------------------

--Trigger 2 (for promotion) and it updates promotion if it is exist

create trigger trg_afterPromotion
 ON  PAYMENT
   AFTER INSERT
AS 
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    UPDATE p
    set p.amount=p.amount-(p.amount*pro.discountAmount)
    from PAYMENT p inner join inserted i on i.paymentID=p.paymentID
    inner join PRODUCT pr on pr.productID=p.productID
    inner join PRODUCT_INFO pri on pri.productIDForInfo=pr.productIDForInfo
    inner join BRAND b on b.brandName=pri.brandName
    inner join PROMOTION pro on pro.brandName=b.brandName
	where pro.startDate <= GETDATE() and pro.endDate >= GETDATE()
    -- Insert statements for trigger here

END
GO

---------------------------------------------------------------------------------------

--Trigger 3 (for promotion) and it updates promotionID fo payment
create trigger trg_forPromotion
ON  PAYMENT
   AFTER INSERT
AS 
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
        UPDATE p
    set p.promotionID=pro.promotionID
    from PAYMENT p inner join inserted i on i.paymentID=p.paymentID
    inner join PRODUCT pr on pr.productID=p.productID
    inner join PRODUCT_INFO pri on pri.productIDForInfo=pr.productIDForInfo
    inner join BRAND b on b.brandName=pri.brandName
    inner join PROMOTION pro on pro.brandName=b.brandName
	where pro.startDate <= GETDATE() and pro.endDate >= GETDATE()
    -- Insert statements for trigger here

END
GO

---------------------------------------------------------------------------------------

--Trigger 4 (for updating sell date) 

create trigger trg_forSellDate
ON  PAYMENT
   AFTER INSERT
AS 
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    update p
    set p.sellDate=GETDATE()
    from PRODUCT p inner join inserted i on i.productID=p.productID
    -- Insert statements for trigger here

END
GO

---------------------------------------------------------------------------------------

-----VIEWS-----
--First View For:
--Retrieve productID(barcode number), productIDForInfo, brandName
--productName and expiration dates of Products which are not sold 
--and have over expiration date
Create View expirationDateCheck 
AS
Select  p.productID, p.productIDForInfo, p_i.brandName, p_i.productName, p.expirationDate
From PRODUCT p inner join PRODUCT_INFO p_i 
     on p.productIDForInfo=p_i.productIDForInfo
Where p.expirationDate<GETDATE() and p.sellDate is NULL

---------------------------------------------------------------------------------------

--Second View For:
--Retrieve productIDForInfo, brandName, productName and the stock state of products
--which are not sold and ready to sale.
Create View stockStateCheck 
AS
Select p.productIDForInfo, p_i.brandName, p_i.productName, Count(*) stockState
From PRODUCT p inner join PRODUCT_INFO p_i on p.productIDForInfo=p_i.productIDForInfo
Where p.sellDate is NULL
Group By p.productIDForInfo , p_i.brandName, p_i.productName

---------------------------------------------------------------------------------------

--Third View For:
--Retrieve customerID, totalAmount, paymentDescription.
Create View totalCustomerPayment 
AS
Select p.customerID, Sum(p.amount) totalAmount, p.paymentDescription
From PAYMENT p inner join REGULAR_CUSTOMER rc on p.customerID = rc.customerID
Group By p.customerID, p.paymentDescription

---------------------------------------------------------------------------------------

--Forth View For:
--Retrieve productIDForInfo, productName, saleAmount.
Create View soldProductAmount 
AS
Select pi.productIDForInfo, pi.productName , Count(*) saleAmount
From Payment p inner join Product pro on p.productID = pro.productID
               inner join PRODUCT_INFO pi on pi.productIDForInfo = pro.productIDForInfo
Group by pi.productIDForInfo, pi.productName

---------------------------------------------------------------------------------------

--Fifth View For:
--Retrieve promotionID, brandName, startDate, endDate, paymentDifferences.
Create View promotionWithLoss
AS
Select prom.promotionID, prom.brandName, prom.startDate, prom.endDate , (Sum(pi.price) - Sum(pay.amount)) paymentDifferences 
From Payment pay inner join PROMOTION prom on pay.promotionID = prom.promotionID
                 inner join PRODUCT pro on pro.productID = pay.productID
                 inner join PRODUCT_INFO pi on pro.productIDForInfo = pi.productIDForInfo
Group By prom.promotionID, prom.brandName, prom.startDate, prom.endDate 


