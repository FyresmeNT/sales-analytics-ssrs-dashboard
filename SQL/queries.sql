-- ============================================
-- SQL-запросы для отчета SalesOrders.rdl
-- Строго по лабораторной работе
-- ============================================

-- 1. ОСНОВНОЙ ЗАПРОС ДЛЯ НАБОРА ДАННЫХ AdventureWorksDataset
-- Используется в основном отчете
-- ----------------------------------------------------
SELECT soh.OrderDate AS [Date],
         soh.SalesOrderNumber AS [Order],
         pps.Name AS Subcat,
         pp.Name AS Product,
         SUM(sd.OrderQty) AS Qty,
         SUM(sd.LineTotal) AS LineTotal
FROM Sales.SalesPerson sp
INNER JOIN Sales.SalesOrderHeader AS soh
    ON sp.BusinessEntityID = soh.SalesPersonID
INNER JOIN Sales.SalesOrderDetail AS sd
    ON sd.SalesOrderID = soh.SalesOrderID
INNER JOIN Production.Product AS pp
    ON sd.ProductID = pp.ProductID
INNER JOIN Production.ProductSubcategory AS pps
    ON pp.ProductSubcategoryID = pps.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS ppc
    ON ppc.ProductCategoryID = pps.ProductCategoryID
GROUP BY  ppc.Name, soh.OrderDate, soh.SalesOrderNumber, pps.Name, pp.Name, soh.SalesPersonID
HAVING ppc.Name = 'Clothing' 
-- ----------------------------------------------------

-- 2. ЗАПРОС ДЛЯ ПАРАМЕТРА SubcatParameter
-- Используется в DataSet для значений параметра фильтрации
-- ----------------------------------------------------
-- Возвращает список подкатегорий для выпадающего списка
SELECT pps.Name AS Subcat
FROM Production.ProductSubcategory AS pps
INNER JOIN Production.ProductCategory AS ppc
    ON pc.ProductCategoryID = pps.ProductCategoryID
GROUP BY  ppc.Name, pps.Name
HAVING (ppc.Name = 'Clothing') 
