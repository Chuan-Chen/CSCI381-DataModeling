/*
CREATE VIEW Utils.uvw_Sales2018(
	YEAR(SaleDate),
	CustomerName,
	ManufacturerVehicleMakeName,
	ManufacturerModelName,
	CountryName,
	Cost,
	RepairsCharge,
	PartsCharge,
	DeliveryCharge,
	TotalSalePrice
)
AS
SELECT 
Sales.SalesOrderVehicle.SaleDate,
Sales.Customer.CustomerName,
Production.ManufacturerVehicleMake.ManufacturerVehicleMakeName,
Production.ManufacturerModel.ManufacturerModelName,
Locale.Country.CountryName,
Production.ManufacturerVehicleStock.Cost,
Production.ManufacturerVehicleStock.RepairsCharge,
Production.ManufacturerVehicleStock.PartsCharge,
Production.ManufacturerVehicleStock.DeliveryCharge,
Sales.SalesOrderVehicle.TotalSalePrice
	FROM Sales.SalesOrderVehicle,Sales.Customer,Production.ManufacturerVehicleStock,Production.ManufacturerModel,Production.ManufacturerVehicleMake,Locale.Country
		WHERE SaleDate = 2018
go
*/

SELECT YEAR(Sales.SalesOrderVehicle.SaleDate) AS SaleYear, 
Sales.Customer.CustomerName as CustomerName,
PMVM.Cost as Cost,
PMVM.RepairsCharge as RepairsCost,
PMVM.PartsCharge as PartsCost,
PMVM.DeliveryCharge as TransportinCost,
TRY_CONVERT(VARCHAR, Sales.SalesOrderVehicle.SaleDate, 101) as SaleDate

FROM Sales.SalesOrderVehicle 

INNER JOIN Sales.Customer on Sales.Customer.CustomerId = Sales.SalesOrderVehicle.CustomerId
INNER JOIN (SELECT StockCode, SalesOrderVehicleId from Sales.SalesOrderVehicleDetail) as StockCode on StockCode.SalesOrderVehicleId = Sales.SalesOrderVehicle.SalesOrderVehicleId
INNER JOIN (SELECT ManufacturerVehicleStockId, StockCode from Production.ManufacturerVehicleStock) as IJStockId on StockCode.StockCode = IJStockId.StockCode /* IJStockId.ManufacturerVehicleStockI */
INNER JOIN (SELECT Cost, RepairsCharge, PartsCharge, DeliveryCharge, ManufacturerVehicleStockId from Production.ManufacturerVehicleStock) as PMVM on IJStockId.ManufacturerVehicleStockId = PMVM.ManufacturerVehicleStockId 


WHERE 
YEAR(Sales.SalesOrderVehicle.SaleDate) = 2018;