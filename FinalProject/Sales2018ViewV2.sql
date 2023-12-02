SELECT 
SC.CustomerName as CustomerName,
SSOV.CustomerId,
SSOVD.SalesOrderVehicleId,
PMM.ManufacturerModelId

FROM Sales.Customer as SC
INNER JOIN (SELECT * FROM Sales.SalesOrderVehicle) 
as SSOV ON SSOV.CustomerId = SC.CustomerId

INNER JOIN (SELECT * FROM Sales.SalesOrderVehicleDetail)
as SSOVD on SSOVD.SalesOrderVehicleId = SSOV.SalesOrderVehicleId

INNER JOIN (SELECT * FROM Production.ManufacturerVehicleStock) 
as PMV on PMV.ManufacturerVehicleStockId = SSOVD.ManufacturerVehicleStockId

INNER JOIN (SELECT * FROM Production.ManufacturerModel)
as PMM on PMM.ManufacturerModelId = PMV.ModelId
