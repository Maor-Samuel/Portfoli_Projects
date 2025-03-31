------------------------------------------------Project one - Maor Samuel-----------------------------------------------------
------------------------------------------------Project one - Maor Samuel-----------------------------------------------------
------------------------------------------------Project one - Maor Samuel-----------------------------------------------------
USE MASTER 
USE MASTER 
USE MASTER 

CREATE DATABASE Sales --

USE Sales 

-------------------------------------------the order of table creation 
--1. SpecialOfferProducts
--2.CurrencyRate
--3.ShipMethod
--4.Address
--5.CreditCard
--6.SalesTerritory
--7.SalesPerson
--8.Customer
--9.SalesOrderHeader
--10.SalesOrderDetails




--1. SpecialOfferProducts create and inserts


CREATE TABLE SpecialOfferProducts
(
 SpecialOfferID int IDENTITY(1,1),
 ProductID int ,
 ModifiedDate DATETIME NOT NULL DEFAULT getdate(),
 CONSTRAINT SPO_SpecialOfferID_ProductID_PK PRIMARY KEY (SpecialOfferID,ProductID)
)

INSERT INTO SpecialOfferProducts
VALUES (10,'2020-09-01')

INSERT INTO SpecialOfferProducts
VALUES (15,'2021-010-20')

INSERT INTO SpecialOfferProducts
VALUES (20,'2022-07-01')

INSERT INTO SpecialOfferProducts
VALUES (25,'2020-11-01')

INSERT INTO SpecialOfferProducts
VALUES (30,'2023-03-19')

INSERT INTO SpecialOfferProducts
VALUES (35,'2021-02-12')

INSERT INTO SpecialOfferProducts
VALUES (40,'2020-02-24')

INSERT INTO SpecialOfferProducts
VALUES (45,'2023-03-03')

INSERT INTO SpecialOfferProducts
VALUES (50,DEFAULT)

INSERT INTO SpecialOfferProducts
VALUES (55,DEFAULT)



--2. CurrencyRate create and inserts

CREATE TABLE CurrencyRate
(
 CurrencyRateID int PRIMARY KEY IDENTITY(1,1),
 CurrencyRateDate DATETIME NOT NULL,
 FromCurrencyCode nchar(3) NOT NULL,
 ToCurrencyCode nchar(3)NOT NULL,
 AverageRate money NOT NULL,
 EndOfDayRate money NOT NULL,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT CR_FromCurrencyCode_CK CHECK (LEN(FromCurrencyCode) > 1),
 CONSTRAINT CR_ToCurrencyCode_CK CHECK (LEN(ToCurrencyCode) > 1),
 CONSTRAINT CR_AverageRate_CK CHECK (AverageRate > 0),
 CONSTRAINT CR_EndOfDayRate_CK CHECK (EndOfDayRate > 0)
)


INSERT INTO CurrencyRate
VALUES ('2020-01-01','PLN','USD', 77.1919, 80.0321 , '2020-01-02')

INSERT INTO CurrencyRate
VALUES ('2020-02-19','XCD','EUR', 52.6532, 66.9871 , '2020-02-20')

INSERT INTO CurrencyRate
VALUES ('2020-08-03','EUR','USD', 90.8321 , 91.5432 , '2020-08-04')

INSERT INTO CurrencyRate
VALUES ('2020-08-26','USD','EUR', 1.1919, 1.0643 , '2020-08-27')

INSERT INTO CurrencyRate
VALUES ('2021-01-18','AOA','USD', 126.0901, 120.4332 , '2021-01-19')

INSERT INTO CurrencyRate
VALUES ('2021-03-06','BDT','USD', 665.1502, 667.2221 , '2021-03-07')

INSERT INTO CurrencyRate
VALUES ('2021-06-21','USD','CAD', 1.6730, 1.8231 , '2021-06-022')

INSERT INTO CurrencyRate
VALUES ('2022-05-01','CAD','AOA', 1.4332, 1.2330 , '2022-05-02')

INSERT INTO CurrencyRate
VALUES ('2023-09-13','EUR','USD', 1.6547, 1.2213 , '2023-09-14')

INSERT INTO CurrencyRate
VALUES ('2024-07-24','USD','EUR', 1.8775, 1.9432 , DEFAULT)


--3.ShipMethod create and inserts
CREATE TABLE ShipMethod
(
 ShipMethodID int PRIMARY KEY IDENTITY(1,1),
 Name nvarchar(50) NOT NULL UNIQUE,
 ShipBase money NOT NULL ,
 ShipRate money NOT NULL ,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT SM_ShipBase_CK CHECK (ShipBase > 0.00),
 CONSTRAINT SM_ShipRate_CK CHECK (ShipRate > 0.00)
)



INSERT INTO ShipMethod 
VALUES ('Standard Shipping', 5.00, 2.50 ,DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Express Shipping', 10.00, 5.00 ,DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Overnight Shipping', 20.00, 15.00, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Two Day Shipping', 15.00, 7.50, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Ground Shipping', 8.00, 3.00, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('International Shipping', 30.00, 20.00, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Local Delivery', 5.00, 1.00, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Same-Day Shipping', 25.00, 12.50, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Economy Shipping', 6.00, 1.50, DEFAULT)

INSERT INTO ShipMethod 
VALUES ('Pickup', 3.00, 4.00, DEFAULT)

--4. Address create and inserts
CREATE TABLE Address
(
 AddressID int PRIMARY KEY IDENTITY(1,1),
 AddressLine1 nvarchar(60) NOT NULL,
 AddressLine2 nvarchar(60),
 City nvarchar(30) NOT NULL ,
 StateProvinceID int NOT NULL,
 PostalCode nvarchar(15),
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT AD_AdressLine1_CK CHECK (LEN(AddressLine1) > 5), -- cant be a very short address
 CONSTRAINT AD_City_CK CHECK (LEN(City) >= 2), --there is no city in the world with 1 letter
 CONSTRAINT AD_PostalCode_CK CHECK (PostalCode > 4) --cant be shorter then this (change between countrys)

)


INSERT INTO Address 
VALUES ('123 Main St', 'Apt 101', 'New York', 1, '10001',DEFAULT)

INSERT INTO Address 
VALUES ('456 Elm St','Floor 1', 'Los Angeles', 2, '90001',DEFAULT)

INSERT INTO Address 
VALUES ('789 Oak Ave','Floor 16', 'Chicago', 3, '60601',DEFAULT)

INSERT INTO Address 
VALUES ('321 Pine Rd', NULL, 'Houston', 4, '77001',DEFAULT)

INSERT INTO Address 
VALUES ('555 Maple Blvd','Floor 26', 'Seattle', 5, '98101',DEFAULT)

INSERT INTO Address 
VALUES ('888 Cedar Ln','Floor 6', 'Boston', 6, '02101',DEFAULT)

INSERT INTO Address 
VALUES ('444 Birch Dr', 'Suite 201', 'San Francisco', 7, '94101',DEFAULT)

INSERT INTO Address 
VALUES ('777 Pineapple Ave','Floor 30', 'Miami', 8, '33101',DEFAULT)

INSERT INTO Address 
VALUES ('222 Orange St', 'Floor 3', 'Dallas', 9, '75201',DEFAULT)

INSERT INTO Address 
VALUES ('999 Banana Way','Floor 33', 'Atlanta', 10, '30301',DEFAULT)

--5. CreditCard create and inserts
CREATE TABLE CreditCard
(
 CreditCardID int PRIMARY KEY IDENTITY(1,1),
 CardType nvarchar(50) NOT NULL,
 CardNumber nvarchar(25) UNIQUE NOT NULL,
 ExpMonth tinyint NOT NULL ,
 ExpYear smallint NOT NULL,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT CC_CardNumber_CK CHECK (LEN(CardNumber) > 12)--from what i have checked the credit card numbers cant be shorter then 12
 )


INSERT INTO CreditCard 
VALUES ('Visa', '4111111111111111', 12, 2024 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('MasterCard', '5500000000000004', 11, 2025 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('American Express', '378282246310005', 10, 2023 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('Discover', '6011111111111117', 9, 2024 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('Visa', '4112345678901234', 8, 2025 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('MasterCard', '5555555555554444', 7, 2023 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('American Express', '371449635398431', 6, 2024 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('Discover', '6011000990139424', 5, 2025 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('Visa', '4012888888881881', 4, 2023 ,DEFAULT)

INSERT INTO CreditCard 
VALUES ('MasterCard', '5105105105105100', 3, 2024 ,DEFAULT)

--6. SalesTerritory create and inserts
CREATE TABLE SalesTerritory
(
 TerritoryID int PRIMARY KEY IDENTITY(1,1),
 Name nvarchar(50) NOT NULL UNIQUE,
 CountryRegionCode nvarchar(3) NOT NULL,
 [Group] nvarchar(50) NOT NULL ,
 SalesYTD money NOT NULL DEFAULT 0.00,
 SalesLastYear money NOT NULL DEFAULT 0.00,
 CostYTD money NOT NULL DEFAULT 0.00,
 CostLastYear money NOT NULL DEFAULT 0.00,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT ST_SalesYTD_CK CHECK (SalesYTD >= 0.00),
  CONSTRAINT ST_SalesLastYear_CK CHECK (SalesLastYear >= 0.00),
  CONSTRAINT ST_CostYTD_CK CHECK (CostYTD >= 0.00),
  CONSTRAINT ST_CostLastYear_CK CHECK (CostLastYear >= 0.00),
 )


INSERT INTO SalesTerritory 
VALUES ('North America', 'NA', 'Region', 1000000.00, 950000.00, 800000.00, 750000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Europe', 'EUR', 'Region', 800000.00, 780000.00, 600000.00, 580000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Asia Pacific', 'APA', 'Region', 600000.00, 550000.00, 400000.00, 350000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Latin America', 'LAT', 'Region', 400000.00, 380000.00, 300000.00, 280000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Middle East', 'MEA', 'Region', 200000.00, 180000.00, 150000.00, 130000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Africa', 'AFR', 'Region', 100000.00, 90000.00, 80000.00, 70000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Canada', 'CAN', 'Country', 300000.00, 280000.00, 250000.00, 230000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Australia', 'AUS', 'Country', 250000.00, 240000.00, 200000.00, 190000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Brazil', 'BRA', 'Country', 180000.00, 170000.00, 150000.00, 140000.00, DEFAULT)

INSERT INTO SalesTerritory 
VALUES ('Japan', 'JPN', 'Country', 150000.00, 140000.00, 120000.00, 110000.00, DEFAULT)

--7. SalesPerson create and inserts

CREATE TABLE SalesPerson
(
 BusinessEntityID int PRIMARY KEY ,
 TerritoryID int,
 SalesQuota money,-- you have asked to allow now in this colume 
 Bonus money NOT NULL DEFAULT 0.00,
 CommissionPct smallmoney NOT NULL DEFAULT 0.00,
 SalesYTD money NOT NULL DEFAULT 0.00,
 SalesLastYear money NOT NULL DEFAULT 0.00,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT SP_TerritoryID_FK FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
 )


INSERT INTO SalesPerson 
VALUES(1, 1, 50000.00, 500.00, 0.05, 15000.00, 12000.00, DEFAULT)

INSERT INTO SalesPerson 
VALUES(2, 2, 60000.00, 600.00, 0.06, 20000.00, 18000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(3, 3, 55000.00, 550.00, 0.04, 17000.00, 14000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(4, 4, 70000.00, 700.00, 0.07, 25000.00, 20000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(5, 5, 65000.00, 650.00, 0.065, 22000.00, 19000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(6, 6, 52000.00, 520.00, 0.055, 16000.00, 13000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(7, 7, 58000.00, 580.00, 0.045, 18000.00, 15000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(8, 8, 63000.00, 630.00, 0.05, 21000.00, 17000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(9, 9, 59000.00, 590.00, 0.05, 19000.00, 16000.00, DEFAULT)


INSERT INTO SalesPerson 
VALUES(10, 10, 61000.00, 610.00, 0.055, 20000.00, 18000.00, DEFAULT)

--8. Customer create and inserts

CREATE TABLE Customer
(
 CustomerID int PRIMARY KEY IDENTITY(1,10),
 PersonID int,
 StoreID int,
 TerritoryID int,
 AccountNumber int NOT NULL,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT C_TerritoryID_FK FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID)
 )
 

INSERT INTO Customer
VALUES
(1, 101, 1, 765464, DEFAULT),
(2, 102, 2, 654290, DEFAULT),
(3, 103, 3, 657907, DEFAULT),
(4, 104, 4, 315780, DEFAULT),
(5, 105, 5, 231454, DEFAULT),
(6, 106, 6, 213345, DEFAULT),
(7, 107, 7, 123456, DEFAULT),
(8, 108, 8, 567865, DEFAULT),
(9, 109, 9, 223451, DEFAULT),
(10, 110, 10, 675435, DEFAULT)



--9. SalesOrderHeader create and inserts
 CREATE TABLE SalesOrderHeader
 (
SalesOrderID int PRIMARY KEY IDENTITY(1,2),
RevisionNumber tinyint NOT NULL DEFAULT 0,
OrderDate DATETIME DEFAULT GETDATE() NOT NULL,
DueDate DATETIME DEFAULT GETDATE() NOT NULL,
ShipDate DATETIME DEFAULT GETDATE(),
Status tinyint NOT NULL,
SalesOrderNumber int NOT NULL,
CustomerID int NOT NULL, 
SalesPersonID int, 
TerritoryID int, 
BillToAddressID int NOT NULL,
ShipToAddressID int NOT NULL,
ShipMethodID int NOT NULL, 
CreditCardID int,
CreditCardApprovalCode VARCHAR(15),
CurrencyRateID int,
SubTotal money DEFAULT 0.00,
TaxAmt money DEFAULT 0.00,
Freight money DEFAULT 0.00,	
CONSTRAINT SO_TerritoryID_FK FOREIGN KEY (TerritoryID) REFERENCES SalesTerritory(TerritoryID),
CONSTRAINT SO_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT SO_SalesPersonID_FK FOREIGN KEY (SalesPersonID) REFERENCES SalesPerson(BusinessEntityID),
CONSTRAINT SO_ShipMethod_FK FOREIGN KEY (ShipMethodID) REFERENCES ShipMethod(ShipMethodID),
CONSTRAINT SO_CreditCardID_FK FOREIGN KEY (CreditCardID) REFERENCES CreditCard(CreditCardID),
CONSTRAINT SO_CurrencyRateID_FK FOREIGN KEY (CurrencyRateID) REFERENCES CurrencyRate(CurrencyRateID),
CONSTRAINT SO_BillToAddressID_FK FOREIGN KEY (BillToAddressID) REFERENCES Address(AddressID),
CONSTRAINT SO_ShipToAddressID_FK FOREIGN KEY (ShipToAddressID) REFERENCES Address(AddressID),
CONSTRAINT SO_DueDate_OrderDate_CK CHECK (DueDate >= OrderDate)-- the duedate will never be befor order date!
)


INSERT INTO SalesOrderHeader
VALUES
(1, '2024-05-13', '2024-05-14', DEFAULT, 1, 101, 1, 1, 1, 1, 1, 1, 1, '12345', 1, 100.00, 10.00, 5.00),
(2, '2024-06-02', '2024-06-03', DEFAULT, 2, 102, 11, 2, 2, 2, 2, 2, 2, '23456', 2, 200.00, 20.00, 10.00),
(3, '2024-07-20', '2024-07-21', DEFAULT, 3, 103, 21, 3, 3, 3, 3, 3, 3, '34567', 3, 300.00, 30.00, 15.00),
(4, '2024-07-01', '2024-07-02', DEFAULT, 4, 104, 31, 4, 4, 4, 4, 4, 4, '45678', 4, 400.00, 40.00, 20.00),
(5, '2024-04-13', '2024-04-14', DEFAULT, 5, 105, 41, 5, 5, 5, 5, 5, 5, '56789', 5, 500.00, 50.00, 25.00),
(6, '2024-05-22', '2024-05-23', DEFAULT, 1, 106, 51, 6, 6, 6, 6, 6, 6, '67890', 6, 600.00, 60.00, 30.00),
(7, '2024-04-17', '2024-04-18', DEFAULT, 2, 107, 61, 7, 7, 7, 7, 7, 7, '78901', 7, 700.00, 70.00, 35.00),
(8, '2024-07-24', '2024-07-25', DEFAULT, 3, 108, 71, 8, 8, 8, 8, 8, 8, '89012', 8, 800.00, 80.00, 40.00),
(9, '2024-07-19', '2024-07-20', DEFAULT, 4, 109, 81, 9, 9, 9, 9, 9, 9, '90123', 9, 900.00, 90.00, 45.00),
(10, '2024-05-06', '2024-05-07', DEFAULT, 5, 110, 91, 10, 10, 10, 10, 10, 10, '01234', 10, 1000.00, 100.00, 50.00)




--10. SalesOrderDetails create and inserts

CREATE TABLE SalesOrderDetails
(
 SalesOrderID int  ,
 SalesOrderDetailID int PRIMARY KEY IDENTITY (1,100),
 CarrierTrackingNumber nvarchar(25),
 OrderQty smallint NOT NULL,
 ProductID int NOT NULL ,
 SpecialOfferID int ,
 UnitPrice money,
 UnitPriceDiscount money DEFAULT 0.00,
 ModifiedDate DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT SOD_SalesOrderID_FK FOREIGN KEY (SalesOrderID) REFERENCES SalesOrderHeader(SalesOrderID),
 CONSTRAINT SOD_SpecialOfferID_ProductID_FK FOREIGN KEY (SpecialOfferID, ProductID) REFERENCES SpecialOfferProducts(SpecialOfferID, ProductID)
 )


INSERT INTO SalesOrderDetails (SalesOrderID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount)
VALUES
(1, 'ABC123456', 10, 10, 1, 100.00, 0.00),
(3, 'DEF234567', 5, 15, 2, 200.00, 10.00),
(5, 'GHI345678', 8, 20, 3, 150.00, 5.00),
(7, 'JKL456789', 12, 25, 4, 180.00, 0.00),
(9, 'MNO567890', 20, 30, 5, 250.00, 15.00),
(11, 'PQR678901', 15, 35, 6, 220.00, 10.00),
(13, 'STU789012', 7, 40, 7, 300.00, 0.00),
(15, 'VWX890123', 9, 45, 8, 400.00, 20.00),
(17, 'YZA901234', 11, 50, 9, 350.00, 5.00),
(19, 'BCD012345', 6, 55, 10, 500.00, 25.00)

 