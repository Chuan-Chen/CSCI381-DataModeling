
CREATE TABLE IF NOT EXISTS `Audit.VersionedEmployeeHistory`
(
	`EmployeeId` INTEGER COMMENT 'a unique identifier for employee IDs.' NOT NULL ,
	`EmployeeFullName` VARCHAR(60) COMMENT 'The full name of an employee.' NOT NULL ,
	`Department` VARCHAR(25) COMMENT 'The department name an employee works in.' NOT NULL ,
	`Salary` DOUBLE PRECISION COMMENT 'The salary of an employee.' NOT NULL ,
	`Notes` VARCHAR(200) COMMENT 'General notes.' NOT NULL ,
	`SysStart` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The start time of the system.' NOT NULL ,
	`SysEnd` DATETIME  DEFAULT '99991231' COMMENT 'The end time of the system.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'A unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL 
);

CREATE INDEX  `ix_VersionedEmployeeHistory` ON  `Audit.VersionedEmployeeHistory`
(
	`SysEnd`,
	`SysStart`
);

CREATE TABLE IF NOT EXISTS `DbSecurity.UserAuthorization`
(
	`UserAuthorizationId` INTEGER AUTO_INCREMENT  COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`ClassTime` CHAR(5)  DEFAULT '10:45' COMMENT 'The class time for CSCI-381 Data Modeling.' NULL ,
	`IndividualProject` VARCHAR(60)  DEFAULT 'CSCI381 Midterm Project' COMMENT 'The name of the individual project.' NULL ,
	`GroupMemberLastName` VARCHAR(35) COMMENT 'A group members last name.' NOT NULL ,
	`GroupMemberFirstName` VARCHAR(25) COMMENT 'A group members first name.' NOT NULL ,
	`GroupName` VARCHAR(20) COMMENT 'The groups name.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT XPKUserAuthorization PRIMARY KEY  ( `UserAuthorizationId` )
)
COMMENT = 'Authorization of transaction by a user.';


ALTER TABLE `DbSecurity.UserAuthorization`
ADD CONSTRAINT `CK_DbSecurity_UserAuthorization_ClassTime`
CHECK ( `ClassTime` LIKE '[0-1][0-9]:[0-5][0-9]'
OR
`ClassTime` LIKE '[0-2][0-4]:[0-5][0-9]' ) ;

ALTER TABLE `DbSecurity.UserAuthorization`
ADD CONSTRAINT `CK_DbSecurity_UserAuthorization_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `DbSecurity.UserAuthorization`
ADD CONSTRAINT `CK_DbSecurity_UserAuthorization_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `DigitRepresentation.Nums`
(
	`N` INTEGER AUTO_INCREMENT  COMMENT 'A unique identifier for Number.  Represents actual digits.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Nums PRIMARY KEY  ( `N` )
);


ALTER TABLE `DigitRepresentation.Nums`
ADD CONSTRAINT `CK_DigitRepresentation_Nums_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `DigitRepresentation.Nums`
ADD CONSTRAINT `CK_DigitRepresentation_Nums_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `HumanResources.Employee`
(
	`EmployeeId` INTEGER AUTO_INCREMENT  COMMENT 'The unique identifier for employee IDs.' NOT NULL ,
	`EmployeeLastName` VARCHAR(35) COMMENT 'The last name of an employee.' NOT NULL ,
	`EmployeeFirstName` VARCHAR(25) COMMENT 'The first name of an employee' NOT NULL ,
	`EmployeeTitle` VARCHAR(30) COMMENT 'The title/role of an employee.' NOT NULL ,
	`EmployeeTitleOfCourtesy` VARCHAR(4) COMMENT 'The title of courtesy of an employee.' NOT NULL ,
	`BirthDate` DATETIME  DEFAULT '19000101' COMMENT 'The birthdate of an employee.' NOT NULL ,
	`HireDate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The hiredate of an employee.' NOT NULL ,
	`EmployeeAddress` VARCHAR(60) COMMENT 'The street address of an employee.' NOT NULL ,
	`EmployeeCity` VARCHAR(40) COMMENT 'The city of an employee.' NULL ,
	`EmployeeRegion` VARCHAR(30) COMMENT 'The state/region of an employee.' NULL ,
	`EmployeePostalCode` CHAR(5) COMMENT 'The postal code of an employee.' NULL ,
	`EmployeeCountry` VARCHAR(40) COMMENT 'The country of an employee.' NOT NULL ,
	`EmployeePhoneNumber` CHAR(10) COMMENT 'The phone number of an employee.' NOT NULL ,
	`EmployeeManagerId` INTEGER COMMENT 'The identifier for an employees manager.' NULL ,
	`UserAuthorizationId` INTEGER NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Employees PRIMARY KEY  ( `EmployeeId` )
)
COMMENT = 'A person employed by the business that is responsible for processing orders.';


ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_EmployeeTitleOfCourtesy`
CHECK ( `EmployeeTitleOfCourtesy`='Mr.'
OR 
`EmployeeTitleOfCourtesy`='Ms.'
OR 
`EmployeeTitleOfCourtesy`='Mrs.'
OR 
`EmployeeTitleOfCourtesy`='Dr.' ) ;

ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_Birthdate`
CHECK ( `BirthDate` BETWEEN '19000101' AND SYSDATE() ) ;

ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_HireDate`
CHECK ( `HireDate` BETWEEN '19000101' AND '99991231' ) ;

ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_EmployeePostalCode`
CHECK ( `EmployeePostalCode` LIKE '[0-9][0-9][0-9][0-9][0-9]'
 ) ;

ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_EmployeePhoneNumber`
CHECK ( `EmployeePhoneNumber` LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) ;

ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `HumanResources.Employee`
ADD CONSTRAINT `CK_HumanResources_Employee_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Production.Category`
(
	`CategoryId` INTEGER AUTO_INCREMENT  COMMENT 'A unique identifier for category IDs.' NOT NULL ,
	`CategoryName` VARCHAR(40) COMMENT 'The name of a product category.' NOT NULL ,
	`Description` VARCHAR(200) COMMENT 'The description of a products category.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Categories PRIMARY KEY  ( `CategoryId` )
)
COMMENT = 'A classification of type for products.';


ALTER TABLE `Production.Category`
ADD CONSTRAINT `CK_Production_Category_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Production.Category`
ADD CONSTRAINT `CK_Production_Category_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Production.Product`
(
	`ProductId` INTEGER AUTO_INCREMENT  COMMENT 'A unique identifier for Product IDs.' NOT NULL ,
	`ProductName` VARCHAR(40) COMMENT 'The name of a product.' NOT NULL ,
	`SupplierId` INTEGER COMMENT 'A unique identifier for supplier IDs.' NOT NULL ,
	`CategoryId` INTEGER COMMENT 'A unique identifier for category IDs.' NOT NULL ,
	`UnitPrice` DOUBLE PRECISION  DEFAULT 0 COMMENT 'The price per unit of a product.' NOT NULL ,
	`Discontinued` INTEGER  DEFAULT 0 COMMENT 'A flag bit to indicate if a product has been discontinued.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Products PRIMARY KEY  ( `ProductId` )
)
COMMENT = 'An item that is sold by the business.';


ALTER TABLE `Production.Product`
ADD CONSTRAINT `CK_Production_Product_UnitPrice`
CHECK ( `UnitPrice` >= 0 ) ;

ALTER TABLE `Production.Product`
ADD CONSTRAINT `CK_Production_Product_Discontinued`
CHECK ( `Discontinued`=0 OR `Discontinued`=1 ) ;

ALTER TABLE `Production.Product`
ADD CONSTRAINT `CK_Production_Product_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Production.Product`
ADD CONSTRAINT `CK_Production_Product_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Production.Supplier`
(
	`SupplierId` INTEGER AUTO_INCREMENT  COMMENT 'A unique identifier for supplier IDs.' NOT NULL ,
	`SupplierCompanyName` VARCHAR(50) COMMENT 'The company name of a supplier.' NOT NULL ,
	`SupplierContactName` VARCHAR(60) COMMENT 'The full name of a contact at the supplier company.' NOT NULL ,
	`SupplierContactTitle` VARCHAR(30) COMMENT 'The title of a contact at the supplier company.' NOT NULL ,
	`SupplierAddress` VARCHAR(60) COMMENT 'The street address of a supplier company.' NOT NULL ,
	`SupplierCity` VARCHAR(40) COMMENT 'The city of a supplier company.' NOT NULL ,
	`SupplierRegion` VARCHAR(30) COMMENT 'The state/region of a supplier company.' NULL ,
	`SupplierPostalCode` CHAR(5) COMMENT 'The postal code of a supplier company.' NULL ,
	`SupplierCountry` VARCHAR(40) COMMENT 'The country of a supplier company.' NOT NULL ,
	`SupplierPhoneNumber` CHAR(10) COMMENT 'The phone number of a supplier company.' NOT NULL ,
	`SupplierFaxNumber` CHAR(10) COMMENT 'The fax number of a supplier company.' NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Suppliers PRIMARY KEY  ( `SupplierId` )
)
COMMENT = 'A company that is responsible for supplying the inventory of specific products.';


ALTER TABLE `Production.Supplier`
ADD CONSTRAINT `CK_Production_Supplier_PostalCode`
CHECK ( `SupplierPostalCode` LIKE '[0-9][0-9][0-9][0-9][0-9]'
 ) ;

ALTER TABLE `Production.Supplier`
ADD CONSTRAINT `CK_Production_Supplier_SupplierPhoneNumber`
CHECK ( `SupplierPhoneNumber` LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) ;

ALTER TABLE `Production.Supplier`
ADD CONSTRAINT `CK_Production_Supplier_SupplierFaxNumber`
CHECK ( `SupplierFaxNumber` LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) ;

ALTER TABLE `Production.Supplier`
ADD CONSTRAINT `CK_Production_Supplier_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Production.Supplier`
ADD CONSTRAINT `CK_Production_Supplier_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Sales.Customer`
(
	`CustomerId` INTEGER AUTO_INCREMENT  COMMENT 'Unique identifier of customer IDs.' NOT NULL ,
	`CustomerCompanyName` VARCHAR(50) COMMENT 'The company name of a customer business.' NOT NULL ,
	`CustomerContactName` VARCHAR(60) COMMENT 'The full contact name of a customer.' NOT NULL ,
	`CustomerContactTitle` VARCHAR(30) COMMENT 'The title/role of customer contact.' NOT NULL ,
	`CustomerAddress` VARCHAR(60) COMMENT 'The street address of a customer.' NOT NULL ,
	`CustomerCity` VARCHAR(40) COMMENT 'The city of a customer.' NOT NULL ,
	`CustomerRegion` VARCHAR(30) COMMENT 'The state/region of a customer.' NULL ,
	`CustomerPostalCode` CHAR(5) COMMENT 'The postal code of a customer.' NULL ,
	`CustomerCountry` VARCHAR(40) COMMENT 'The country of a customer.' NOT NULL ,
	`CustomerPhoneNumber` CHAR(10) COMMENT 'The phone number of a customer.' NOT NULL ,
	`CustomerFaxNumber` CHAR(10) COMMENT 'The fax number of a customer.' NULL ,
	`UserAuthorizationId` INTEGER NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Customers PRIMARY KEY  ( `CustomerId` )
)
COMMENT = 'A person or business entity that purchases Products.';


ALTER TABLE `Sales.Customer`
ADD CONSTRAINT `CK_Sales_Customer_CustomerPostalCode`
CHECK ( `CustomerPostalCode` LIKE '[0-9][0-9][0-9][0-9][0-9]'
 ) ;

ALTER TABLE `Sales.Customer`
ADD CONSTRAINT `CK_Sales_Customer_CustomerPhoneNumber`
CHECK ( `CustomerPhoneNumber` LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) ;

ALTER TABLE `Sales.Customer`
ADD CONSTRAINT `CK_Sales_Customer_CustomerFaxNumber`
CHECK ( `CustomerFaxNumber` LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) ;

ALTER TABLE `Sales.Customer`
ADD CONSTRAINT `CK_Sales_Customer_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Sales.Customer`
ADD CONSTRAINT `CK_Sales_Customer_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Sales.Order`
(
	`OrderId` INTEGER AUTO_INCREMENT  COMMENT 'The unique identifier of order IDs.' NOT NULL ,
	`CustomerId` INTEGER COMMENT 'Unique identifier of customer IDs.' NULL ,
	`EmployeeId` INTEGER COMMENT 'The unique identifier for employee IDs.' NOT NULL ,
	`ShipperId` INTEGER COMMENT 'A unique identifier for shipper IDs.' NOT NULL ,
	`OrderDate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date of an order.' NOT NULL ,
	`RequiredDate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an order is required by.' NOT NULL ,
	`ShipToDate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an order is shipped to a customer.' NULL ,
	`Freight` DOUBLE PRECISION  DEFAULT 0 COMMENT 'The cost of freight.' NOT NULL ,
	`ShipToName` VARCHAR(60) COMMENT 'The name of a recipient the shipment will be delivered to.' NOT NULL ,
	`ShipToAddress` VARCHAR(60) COMMENT 'The street address of a recipient the shipment will be delivered to.' NOT NULL ,
	`ShipToCity` VARCHAR(40) COMMENT 'The city of a recipient the shipment will be delivered to.' NOT NULL ,
	`ShipToRegion` VARCHAR(30) COMMENT 'The state/region of a recipient the shipment will be delivered to.' NULL ,
	`ShipToPostalCode` CHAR(5) COMMENT 'The postal code of a recipient the shipment will be delivered to.' NULL ,
	`ShipToCountry` VARCHAR(40) COMMENT 'The country of a recipient the shipment will be delivered to.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	 CONSTRAINT PK_Orders PRIMARY KEY  ( `OrderId` )
)
COMMENT = 'An order made by a customer.';


ALTER TABLE `Sales.Order`
ADD CONSTRAINT `CK_Sales_Orders_OrderDate`
CHECK ( RequiredDate >= OrderDate ) ;

ALTER TABLE `Sales.Order`
ADD CONSTRAINT `CK_Sales_Order_RequiredDate`
CHECK ( RequiredDate >= OrderDate ) ;

ALTER TABLE `Sales.Order`
ADD CONSTRAINT `CK_Sales_Order_ShipToDate`
CHECK ( ShipToDate >= OrderDate ) ;

ALTER TABLE `Sales.Order`
ADD CONSTRAINT `CK_Sales_Order_ShipToPostalCode`
CHECK ( `ShipToPostalCode` LIKE '[0-9][0-9][0-9][0-9][0-9]'
 ) ;

ALTER TABLE `Sales.Order`
ADD CONSTRAINT `CK_Sales_Order_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Sales.Order`
ADD CONSTRAINT `CK_Sales_Order_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Sales.OrderDetail`
(
	`OrderId` INTEGER COMMENT 'A unique identifier for Order IDs.' NOT NULL ,
	`ProductId` INTEGER COMMENT 'A unique identifier for Product IDs.' NOT NULL ,
	`UnitPrice` DOUBLE PRECISION  DEFAULT 0 COMMENT 'The price per unit of a product purchased.' NOT NULL ,
	`Quantity` INTEGER  DEFAULT 1 COMMENT 'The quantity of product purchased.' NOT NULL ,
	`DiscountPercentage` DOUBLE  DEFAULT 0 COMMENT 'A percentage of discount applied to the price of product purchased.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_OrderDetails PRIMARY KEY  ( `OrderId`, `ProductId` )
)
COMMENT = 'A description of the sales order made by a customer.';


ALTER TABLE `Sales.OrderDetail`
ADD CONSTRAINT `CK_Sales_OrderDetail_Quantity`
CHECK ( `Quantity` > 0 ) ;

ALTER TABLE `Sales.OrderDetail`
ADD CONSTRAINT `CK_Sales_OrderDetail_DiscountPercentage`
CHECK ( `DiscountPercentage` BETWEEN 0 AND 1 ) ;

ALTER TABLE `Sales.OrderDetail`
ADD CONSTRAINT `CK_Sales_OrderDetail_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Sales.OrderDetail`
ADD CONSTRAINT `CK_Sales_OrderDetail_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Sales.Shipper`
(
	`ShipperId` INTEGER AUTO_INCREMENT  COMMENT 'A unique identifier for shipper IDs.' NOT NULL ,
	`ShipperCompanyName` VARCHAR(50) COMMENT 'The name of the shipping company.' NOT NULL ,
	`PhoneNumber` CHAR(10) COMMENT 'The phone number of the shipping company.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_Shippers PRIMARY KEY  ( `ShipperId` )
)
COMMENT = 'A business that is responsible for delivering purchased products.';


ALTER TABLE `Sales.Shipper`
ADD CONSTRAINT `CK_Sales_Shipper_PhoneNumber`
CHECK ( `PhoneNumber` LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) ;

ALTER TABLE `Sales.Shipper`
ADD CONSTRAINT `CK_Sales_Shipper_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Sales.Shipper`
ADD CONSTRAINT `CK_Sales_Shipper_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `SystemVersioned.Employee`
(
	`EmployeeId` INTEGER COMMENT 'The unique identifier for employee IDs.' NOT NULL ,
	`EmployeeFullName` VARCHAR(60) COMMENT 'The full name of an employee.' NOT NULL ,
	`Department` VARCHAR(25) COMMENT 'The department name an employee works in.' NOT NULL ,
	`Salary` DOUBLE PRECISION COMMENT 'The salary of an employee.' NOT NULL ,
	`Notes` VARCHAR(200) COMMENT 'General notes.' NOT NULL ,
	`SysStart` DATETIME  DEFAULT '19000101' COMMENT 'The start time of the system.' NOT NULL ,
	`SysEnd` DATETIME  DEFAULT '99991231' COMMENT 'The end time of the system.' NOT NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_EmployeeVersioned PRIMARY KEY  ( `EmployeeId` )
);


ALTER TABLE `SystemVersioned.Employee`
ADD CONSTRAINT `CK_SystemVersioned_Employee_SysStart`
CHECK ( SysEnd >= SysStart ) ;

ALTER TABLE `SystemVersioned.Employee`
ADD CONSTRAINT `CK_SystemVersioned_Employee_SysEnd`
CHECK ( SysEnd >= SysStart ) ;

ALTER TABLE `SystemVersioned.Employee`
ADD CONSTRAINT `CK_SystemVersioned_Employee_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `SystemVersioned.Employee`
ADD CONSTRAINT `CK_SystemVersioned_Employee_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Triggered.AuditTriggeredEmployeeHistory`
(
	`TriggeredEmployeeHistoryId` INTEGER AUTO_INCREMENT  COMMENT 'A unique identifier for triggered employee history IDs.' NOT NULL ,
	`AuditTriggeredEmployeeHistoryTimestamp` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'A timstamp for triggered employee history.' NULL ,
	`TriggerOption` CHAR(1)  DEFAULT 'U' COMMENT 'A flag to indicate the trigger option.' NULL ,
	`EmployeeId` INTEGER COMMENT 'The unique identifier for employee IDs.' NOT NULL ,
	`EmployeeFullName` VARCHAR(60) COMMENT 'The full name of an employee.' NOT NULL ,
	`Department` VARCHAR(25) COMMENT 'The department name an employee works in.' NOT NULL ,
	`Salary` DOUBLE PRECISION COMMENT 'The salary of an employee' NOT NULL ,
	`Notes` VARCHAR(200) COMMENT 'General notes.' NOT NULL ,
	`IsDeleted` CHAR(1)  DEFAULT 'N' COMMENT 'A flag to indicate if the record was deleted.' NULL ,
	`TransactionNumber` INTEGER  DEFAULT 1 COMMENT 'A transaction number.' NULL ,
	`UserAuthenticatedKey` INTEGER  DEFAULT 37 COMMENT 'A key that symbolizes user authenication.' NULL ,
	`SysStartTime` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The start time of the system.' NULL ,
	`SysEndTime` DATETIME  DEFAULT '99991231' COMMENT 'The end time of a system.' NULL ,
	`TimestampRowChanged` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'A timestamp to indicate when a row was changed.' NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_TriggeredEmployeeHistoryId PRIMARY KEY  ( `TriggeredEmployeeHistoryId` )
);


ALTER TABLE `Triggered.AuditTriggeredEmployeeHistory`
ADD CONSTRAINT `CK_Triggered_AuditTriggeredEmployeeHistory_SysStartTime`
CHECK ( SysEndTime >= SysStartTime ) ;

ALTER TABLE `Triggered.AuditTriggeredEmployeeHistory`
ADD CONSTRAINT `CK_Triggered_AuditTriggeredEmployeeHistory_SysEndTime`
CHECK ( SysEndTime >= SysStartTime ) ;

ALTER TABLE `Triggered.AuditTriggeredEmployeeHistory`
ADD CONSTRAINT `CK_Triggered_AuditTriggeredEmployeeHistory_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Triggered.AuditTriggeredEmployeeHistory`
ADD CONSTRAINT `CK_Triggered_AuditTriggeredEmployeeHistory_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE TABLE IF NOT EXISTS `Triggered.Employee`
(
	`EmployeeId` INTEGER COMMENT 'The unique identifier for employee IDs.' NOT NULL ,
	`EmployeeFullName` VARCHAR(60) COMMENT 'The full name of an employee.' NOT NULL ,
	`Department` VARCHAR(25) COMMENT 'The department name an employee works in.' NOT NULL ,
	`Salary` DOUBLE PRECISION COMMENT 'The salary of an employee.' NOT NULL ,
	`Notes` VARCHAR(200) COMMENT 'General notes.' NOT NULL ,
	`IsDeleted` CHAR(1)  DEFAULT 'N' COMMENT 'A flag to indicate an entry was deleted.' NULL ,
	`TransactionNumber` INTEGER  DEFAULT 1 COMMENT 'A transaction number.' NULL ,
	`UserAuthenticatedKey` INTEGER  DEFAULT 37 COMMENT 'A key that symbolizes user authenication.' NULL ,
	`SysStartTime` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The start time of the system.' NULL ,
	`SysEndTime` DATETIME  DEFAULT '99991231' COMMENT 'The end time of the system.' NULL ,
	`TimestampRowChanged` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'A timestamp when a row was changed.' NULL ,
	`UserAuthorizationId` INTEGER COMMENT 'The unique identifier for user authorization IDs.' NOT NULL ,
	`DateAdded` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was added.' NULL ,
	`DateOfLastUpdate` DATETIME  DEFAULT CURRENT_TIMESTAMP COMMENT 'The date an entry was last updated.' NULL ,
	 CONSTRAINT PK_TriggeredEmployee PRIMARY KEY  ( `EmployeeId` )
);


ALTER TABLE `Triggered.Employee`
ADD CONSTRAINT `CK_Triggered_Employee_SysStartTime`
CHECK ( SysEndTime >= SysStartTime ) ;

ALTER TABLE `Triggered.Employee`
ADD CONSTRAINT `CK_Triggered_Employee_SysEndTime`
CHECK ( SysEndTime >= SysStartTime ) ;

ALTER TABLE `Triggered.Employee`
ADD CONSTRAINT `CK_Triggered_Employee_DateAdded`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

ALTER TABLE `Triggered.Employee`
ADD CONSTRAINT `CK_Triggered_Employee_DateOfLastUpdate`
CHECK ( DateOfLastUpdate >= DateAdded ) ;

CREATE VIEW `JsonOutput.uvw_HumanResourcesEmployee` (
`EmployeeObjectId`,
`EmployeeLastName`, 
`EmployeeFirstName`,
`EmployeeTitle`,
`EmployeeTitleOfCourtesy`,
`BirthDate`,
`HireDate`,
`EmployeeAddress`,
`EmployeeCity`,
`EmployeeRegion`,
`EmployeePostalCode`,
`EmployeeCountry`,
`EmployeePhoneNumber`,
`EmployeeManagerId`)
AS 
SELECT 
E.`EmployeeId`,
E.`EmployeeLastName`,
E.`EmployeeFirstName`,
E.`EmployeeTitle`,
E.`EmployeeTitleOfCourtesy`,
E.`BirthDate`,
E.`HireDate`,
E.`EmployeeAddress`,
E.`EmployeeCity`,
E.`EmployeeRegion`,
E.`EmployeePostalCode`,
E.`EmployeeCountry`,
E.`EmployeePhoneNumber`,
E.`EmployeeManagerId`
FROM `HumanResources.Employee` E;

CREATE VIEW `JsonOutput.uvw_ProductionCategory` (
`CategoryObjectId`,
`CategoryName`,
`Description`)
AS 
SELECT 
`Production.Category`.`CategoryId`,
`Production.Category`.`CategoryName`,
`Production.Category`.`Description`
FROM `Production.Category` ;


CREATE VIEW `JsonOutput.uvw_ProductionSupplier` (
`SupplierObjectId`,
`SupplierCompanyName`,
`SupplierContactName`,
`SupplierContactTitle`,
`SupplierAddress`,
`SupplierCity`,
`SupplierRegion`,
`SupplierPostalCode`,
`SupplierCountry`,
`SupplierPhoneNumber`,
`SupplierFaxNumber`)
AS 
SELECT 
S.`SupplierId`,
S.`SupplierCompanyName`,
S.`SupplierContactName`,
S.`SupplierContactTitle`,
S.`SupplierAddress`,
S.`SupplierCity`,
S.`SupplierRegion`,
S.`SupplierPostalCode`,
S.`SupplierCountry`,
S.`SupplierPhoneNumber`,
S.`SupplierFaxNumber`
FROM `Production.Supplier` S;

CREATE VIEW `JsonOutput.uvw_SalesCustomer` (
`CustomerObjectId`,
`CustomerCompanyName`,
`CustomerContactName`,
`CustomerContactTitle`,
`CustomerAddress`,
`CustomerCity`,
`CustomerRegion`,
`CustomerPostalCode`,
`CustomerCountry`,
`CustomerPhoneNumber`,
`CustomerFaxNumber`)
AS 
SELECT 
C.`CustomerId`,
C.`CustomerCompanyName`,
C.`CustomerContactName`,
C.`CustomerContactTitle`,
C.`CustomerAddress`,
C.`CustomerCity`,
C.`CustomerRegion`,
C.`CustomerPostalCode`,
C.`CustomerCountry`,
C.`CustomerPhoneNumber`,
C.`CustomerFaxNumber`
FROM `Sales.Customer` C;

CREATE VIEW `JsonOutput.uvw_SalesShipper` (
`ShipperObjectId`,
`ShipperCompanyName`,
`PhoneNumber`)
AS 
SELECT 
S.`ShipperId`,
S.`ShipperCompanyName`,
S.`PhoneNumber`
FROM `Sales.Shipper` S;

CREATE VIEW `JsonOutput.uvw_Order` (
`OrderId`,
`CustomerId`,
`EmployeeId`,
`ShipperId`,
`OrderDate`,
`RequiredDate`,
`ShipToDate`,
`Freight`,
`ShipToName`,
`ShipToAddress`,
`ShipToCity`,
`ShipToRegion`,
`ShipToPostalCode`,
`ShipToCountry`)
AS 
SELECT 
O.`OrderId`,
O.`CustomerId`,
O.`EmployeeId`,
O.`ShipperId`,
O.`OrderDate`,
O.`RequiredDate`,
O.`ShipToDate`,
O.`Freight`,
O.`ShipToName`,
O.`ShipToAddress`,
O.`ShipToCity`,
O.`ShipToRegion`,
O.`ShipToPostalCode`,
O.`ShipToCountry`
FROM `Sales.Order` O;

CREATE VIEW `JsonOutput.uvw_OrderDetail` (
`OrderId`,
`ProductId`,
`UnitPrice`,
`Quantity`,
`DiscountPercentage`)
AS 
SELECT 
OD.`OrderId`,
OD.`ProductId`,
OD.`UnitPrice`,
OD.`Quantity`,
OD.`DiscountPercentage`
FROM `Sales.OrderDetail` OD;
-- 
-- CREATE VIEW  `Utils.uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint` AS
-- SELECT  
--     concat(tbl.TABLE_SCHEMA, '.', tbl.TABLE_NAME) AS `FullyQualifiedTableName`, 
--     tbl.TABLE_SCHEMA AS `SchemaName`, 
--     tbl.TABLE_NAME AS `TableName`, 
--     col.COLUMN_NAME AS `ColumnName`, 
--     col.ORDINAL_POSITION AS `OrdinalPosition`,  
--     concat(col.TABLE_SCHEMA, '.', col.DOMAIN_NAME) AS `FullyQualifiedDomainName`, 
--     col.DOMAIN_NAME AS `DomainName`, 
--     CASE 
--         WHEN col.DATA_TYPE = 'character varying' THEN concat('varchar(', CHARACTER_MAXIMUM_LENGTH, ')')  
--         WHEN col.DATA_TYPE = 'character' THEN concat('char(', CHARACTER_MAXIMUM_LENGTH, ')')  
--         WHEN col.DATA_TYPE = 'character varying' THEN concat('nvarchar(', CHARACTER_MAXIMUM_LENGTH, ')')  
--         WHEN col.DATA_TYPE = 'character' THEN concat('nchar(', CHARACTER_MAXIMUM_LENGTH, ')')  
--         WHEN col.DATA_TYPE = 'numeric' THEN concat('numeric(', NUMERIC_PRECISION_RADIX, ', ', NUMERIC_SCALE, ')')  
--         WHEN col.DATA_TYPE = 'decimal' THEN concat('decimal(', NUMERIC_PRECISION_RADIX, ', ', NUMERIC_SCALE, ')')  
--         ELSE col.DATA_TYPE 
--     END AS `DataType`, 
--     col.IS_NULLABLE AS `IsNullable`, 
--     dcn.`DefaultName`, 
--     col.COLUMN_DEFAULT AS `DefaultNameDefinition`, 
--     cc.CONSTRAINT_NAME AS `CheckConstraintRuleName`, 
--     cc.CHECK_CLAUSE AS `CheckConstraintRuleNameDefinition` 
-- FROM (  
--     SELECT TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE 
--     FROM INFORMATION_SCHEMA.TABLES 
--     WHERE TABLE_TYPE = 'BASE TABLE'
-- ) AS tbl    
-- INNER JOIN (  
--     SELECT 
--         TABLE_CATALOG, 
--         TABLE_SCHEMA, 
--         TABLE_NAME, 
--         COLUMN_NAME, 
--         ORDINAL_POSITION, 
--         COLUMN_DEFAULT, 
--         IS_NULLABLE, 
--         DATA_TYPE, 
--         CHARACTER_MAXIMUM_LENGTH, 
--         CHARACTER_OCTET_LENGTH, 
--         NUMERIC_PRECISION, 
--         NUMERIC_PRECISION_RADIX, 
--         NUMERIC_SCALE, 
--         DATETIME_PRECISION, 
--         CHARACTER_SET_CATALOG, 
--         CHARACTER_SET_SCHEMA, 
--         CHARACTER_SET_NAME, 
--         COLLATION_CATALOG, 
--         COLLATION_SCHEMA, 
--         COLLATION_NAME, 
--         DOMAIN_NAME 
--     FROM INFORMATION_SCHEMA.COLUMNS
-- ) AS col ON col.TABLE_CATALOG = tbl.TABLE_CATALOG 
--     AND col.TABLE_SCHEMA = tbl.TABLE_SCHEMA 
--     AND col.TABLE_NAME = tbl.TABLE_NAME   
-- LEFT OUTER JOIN (  
--     SELECT 
--         c.table_name AS `TableName`,  
--         c.table_schema AS `SchemaName`, 
--         c.column_name AS `ColumnName`, 
--         kcu.constraint_name AS `DefaultName` 
--     FROM information_schema.columns c
--     INNER JOIN information_schema.key_column_usage kcu 
--         ON c.table_name = kcu.table_name 
--         AND c.column_name = kcu.column_name 
--         AND c.table_schema = kcu.table_schema
--     INNER JOIN information_schema.table_constraints tc 
--         ON kcu.constraint_name = tc.constraint_name 
--         AND kcu.table_name = tc.table_name 
--         AND kcu.table_schema = tc.table_schema 
--     WHERE tc.constraint_type = 'DEFAULT'
-- ) AS dcn ON dcn.`SchemaName` = tbl.TABLE_SCHEMA 
--     AND dcn.`TableName` = tbl.TABLE_NAME 
--     AND dcn.`ColumnName` = col.COLUMN_NAME
-- LEFT OUTER JOIN (  
--     SELECT 
--         cu.TABLE_CATALOG, 
--         cu.TABLE_SCHEMA, 
--         cu.TABLE_NAME, 
--         cu.COLUMN_NAME, 
--         c.CONSTRAINT_CATALOG, 
--         c.CONSTRAINT_SCHEMA, 
--         c.CONSTRAINT_NAME, 
--         c.CHECK_CLAUSE 
--     FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS cu   
--     INNER JOIN INFORMATION_SCHEMA.CHECK_CONSTRAINTS AS c 
--         ON c.CONSTRAINT_NAME = cu.CONSTRAINT_NAME 
-- ) AS cc ON cc.TABLE_SCHEMA = tbl.TABLE_SCHEMA 
--     AND cc.TABLE_NAME = tbl.TABLE_NAME 
--     AND cc.COLUMN_NAME = col.COLUMN_NAME;
--    
--    
-- CREATE OR REPLACE VIEW `Utils.uw_FindAllDatabaseColumnsOnTheServer` AS 
-- SELECT 
--     vw.`FullyQualifiedTableName`,
--     vw.`SchemaName`,
--     vw.`ColumnName`,
--     vw.`OrdinalPosition`,
--     vw.`FullyQualifiedDomainName`,
--     vw.`DataType`,
--     vw.`IsNullable`,
--     vw.`DefaultName`,
--     vw.`DefaultNameDefinition`,
--     vw.`CheckConstraintRuleName`,
--     vw.`CheckConstraintRuleNameDefinition`,
--     current_setting('server_version') as `Server Version`,
--     version(),
--     current_setting('cluster_name') as `Cluster Name` ,
--     current_database(),
--     inet_server_addr()
-- FROM `Utils.uvw_FindColumnDefinitionPlusDefaultAndCheckConstraint` vw
-- WHERE vw.`SchemaName` IN ('Sales', 'Production', 'HumanResources');;;


DELIMITER $$

CREATE TRIGGER `Triggered.uTdu_AuditTriggeredEmployeeHistory` AFTER DELETE ON `Triggered.Employee` FOR EACH ROW
BEGIN
  DECLARE action CHAR(1) DEFAULT 'I';
  DECLARE isDeleted CHAR(1) DEFAULT 'N';
  DECLARE deletedMessage VARCHAR(25) DEFAULT 'Rows has been deleted';
  
  IF EXISTS (SELECT * FROM Triggered.Employee) AND EXISTS (SELECT * FROM deleted) THEN
    SET action = 'U';
    
    INSERT INTO Triggered.AuditTriggeredEmployeeHistory (
      AuditTriggeredEmployeeHistoryTimestamp, 
      TriggerOption,
      EmployeeId,
      EmployeeFullName, 
      Department,
      Salary,
      Notes,
      IsDeleted,
      TransactionNumber,
      UserAuthenticatedKey,
      SysStartTime,
      SysEndTime,
      TimestampRowChanged,
      UserAuthorizationId
    ) VALUES (
      CURRENT_TIMESTAMP,
      action,
      OLD.EmployeeId,
      OLD.EmployeeFullName,
      OLD.Department,
      OLD.Salary,
      OLD.Notes,
      isDeleted,
      OLD.TransactionNumber,
      OLD.UserAuthenticatedKey,
      OLD.SysStartTime,
      CURRENT_TIMESTAMP,
      CURRENT_TIMESTAMP,
      OLD.UserAuthorizationId
    );
  ELSEIF EXISTS (SELECT * FROM deleted) THEN
    SET action = 'D';
    SET isDeleted = 'Y';
    
    INSERT INTO Triggered.AuditTriggeredEmployeeHistory (
      AuditTriggeredEmployeeHistoryTimestamp,
      TriggerOption,  
      EmployeeId,
      EmployeeFullName,
      Department,
      Salary,
      Notes,
      IsDeleted,
      TransactionNumber,
      UserAuthenticatedKey,
      SysStartTime,
      SysEndTime,    
      TimestampRowChanged,
      UserAuthorizationId       
    ) VALUES (
      CURRENT_TIMESTAMP,
      action,
      OLD.EmployeeId,
      OLD.EmployeeFullName,
      OLD.Department,
      OLD.Salary,
      deletedMessage,
      isDeleted,
      OLD.TransactionNumber,
      OLD.UserAuthenticatedKey,
      OLD.SysStartTime,
      CURRENT_TIMESTAMP,
      CURRENT_TIMESTAMP,
      OLD.UserAuthorizationId          
    );
  ELSE
    SET action = 'I';
  END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER `Triggered.uTdu_Employee` BEFORE UPDATE ON `Triggered.Employee` FOR EACH ROW
BEGIN
  SET NEW.TimestampRowChanged = CURRENT_TIMESTAMP;
  SET NEW.TransactionNumber = OLD.TransactionNumber + 1;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_HumanResourcesEmployee`() RETURNS json
BEGIN
  DECLARE json_data json;
  
  SELECT 
    JSON_OBJECT(
      'EmployeeObjectId', EmployeeId, 
      'EmployeeLastName', EmployeeLastName,
      'EmployeeFirstName', EmployeeFirstName,
      'EmployeeTitle', EmployeeTitle,
      'EmployeeTitleOfCourtesy', EmployeeTitleOfCourtesy,
      'BirthDate', BirthDate,
      'HireDate', HireDate,
      'EmployeeAddress', EmployeeAddress,
      'EmployeeCity', EmployeeCity,
      'EmployeeRegion', EmployeeRegion,
      'EmployeePostalCode', EmployeePostalCode,
      'EmployeeCountry', EmployeeCountry,
      'EmployeePhoneNumber', EmployeePhoneNumber,
      'EmployeeManagerId', EmployeeManagerId
    )
  INTO json_data
  FROM HumanResources.Employee;
  
  RETURN json_data;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_ProductionCategory`() RETURNS json
BEGIN
  DECLARE json_data json;
  
  SELECT 
    JSON_OBJECT(
      'CategoryObjectId', CategoryId, 
      'CategoryName', CategoryName,
      'Description', Description
    )
  INTO json_data
  FROM Production.Category;

  RETURN json_data;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_ProductionProduct`() RETURNS json
BEGIN
  DECLARE json_data json;

  SELECT 
    JSON_OBJECT(
        'ProductObjectId', P.ProductId,
        'ProductName', P.ProductName,
        'SupplierId', P.SupplierId,
        'CategoryId', P.CategoryId,
        'UnitPrice', P.UnitPrice,
        'Discontinued', P.Discontinued,
        'Production.CategoryObjectId', C.CategoryId,
        'Production.CategoryName', C.CategoryName,
        'Production.Description', C.Description,
        'Production.SupplierObjectId', S.SupplierId,
        'Production.SupplierCompanyName', S.SupplierCompanyName,
        'Production.SupplierContactName', S.SupplierContactName,
        'Production.SupplierPhoneNumber', S.SupplierPhoneNumber,
        'Production.SupplierFaxNumber', S.SupplierFaxNumber
      )
  INTO json_data
  FROM Production.Product AS P
  INNER JOIN Production.Category AS C 
    ON C.CategoryId = P.CategoryId
  INNER JOIN Production.Supplier AS S
    ON S.SupplierId = P.SupplierId;

  RETURN json_data;  
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_ProductionSupplier`() RETURNS json
BEGIN
  DECLARE json_data json;

  SELECT 
    JSON_OBJECT(
        'SupplierObjectId', S.SupplierId,
        'SupplierCompanyName', S.SupplierCompanyName,
        'SupplierContactName', S.SupplierContactName,
        'SupplierContactTitle', S.SupplierContactTitle,
        'SupplierAddress', S.SupplierAddress,  
        'SupplierCity', S.SupplierCity,
        'SupplierRegion', S.SupplierRegion,
        'SupplierPostalCode', S.SupplierPostalCode,
        'SupplierCountry', S.SupplierCountry,
        'SupplierPhoneNumber', S.SupplierPhoneNumber,
        'SupplierFaxNumber', S.SupplierFaxNumber
      )
  INTO json_data
  FROM Production.Supplier S;

  RETURN json_data;
END$$  

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_SalesCustomer`() RETURNS json
BEGIN
  DECLARE json_data json;

  SELECT 
    JSON_OBJECT(
      'CustomerObjectId', C.CustomerId,
      'CustomerCompanyName', C.CustomerCompanyName,
      'CustomerContactName', C.CustomerContactName,
      'CustomerContactTitle', C.CustomerContactTitle,
      'CustomerAddress', C.CustomerAddress,
      'CustomerCity', C.CustomerCity,
      'CustomerRegion', C.CustomerRegion,
      'CustomerPostalCode', C.CustomerPostalCode,
      'CustomerCountry', C.CustomerCountry,
      'CustomerPhoneNumber', C.CustomerPhoneNumber,
      'CustomerFaxNumber', C.CustomerFaxNumber
    )
  INTO json_data
  FROM Sales.Customer C;

  RETURN json_data;
END$$

DELIMITER ;  

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_SalesShipper`() RETURNS json
BEGIN
  DECLARE json_data json;

  SELECT 
    JSON_OBJECT(
      'ShipperObjectId', S.ShipperId, 
      'ShipperCompanyName', S.ShipperCompanyName,
      'PhoneNumber', S.PhoneNumber
    )
  INTO json_data
  FROM Sales.Shipper S;

  RETURN json_data;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_Order`() RETURNS json
BEGIN
  DECLARE json_data json;
  
  SELECT
    JSON_OBJECT(
      'OrderId', O.OrderId,
      'CustomerId', O.CustomerId,  
      'EmployeeId', O.EmployeeId,
      'ShipperId', O.ShipperId,
      'OrderDate', O.OrderDate,
      'RequiredDate', O.RequiredDate,
      'ShipToDate', O.ShipToDate,
      'Freight', O.Freight,
      'ShipToName', O.ShipToName,
      'ShipToAddress', O.ShipToAddress,
      'ShipToCity', O.ShipToCity,
      'ShipToRegion', O.ShipToRegion,
      'ShipToPostalCode', O.ShipToPostalCode,
      'ShipToCountry', O.ShipToCountry
    )
  INTO json_data
  FROM Sales.Order O;
  
  RETURN json_data;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION `JsonOutput.fn_OrderDetail`() RETURNS json 
BEGIN
  DECLARE json_data json;

  SELECT  
    JSON_OBJECT(
      'OrderId', OD.OrderId,
      'ProductId', OD.ProductId,
      'UnitPrice', OD.UnitPrice,
      'Quantity', OD.Quantity,
      'DiscountPercentage', OD.DiscountPercentage
    )
  INTO json_data
  FROM Sales.OrderDetail OD;

  RETURN json_data;
END$$

DELIMITER ;