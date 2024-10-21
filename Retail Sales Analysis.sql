CREATE TABLE retail_sales (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate date,
    UnitPrice DECIMAL(10, 2),
    CustomerID VARCHAR(20),
    Country VARCHAR(50)
);

SELECT * FROM retail_sales LIMIT 10;

-- checking missing values

SELECT 
    COUNT(*) - COUNT(Quantity) AS missing_quantity,
    COUNT(*) - COUNT(UnitPrice) AS missing_unitprice,
    COUNT(*) - COUNT(CustomerID) AS missing_customerid
FROM retail_sales;

-- removing null customer IDs & quantity is negative

DELETE FROM retail_sales WHERE Quantity<0 OR CustomerID IS NULL;


SELECT 
    COUNT(*) - COUNT(Quantity<0) AS missing_quantity,
    COUNT(*) - COUNT(CustomerID) AS missing_customerid
FROM retail_sales; -- check if null rows were deleted

-- Key Metrics Calculations

-- Total Revenue by Invoice

SELECT
    InvoiceNo,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM
    retail_sales
GROUP BY
    InvoiceNo
ORDER BY
    TotalRevenue DESC;
	
-- Total Sales by Country

SELECT 
    Country, 
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM 
    retail_sales
GROUP BY 
    Country
ORDER BY 
    TotalRevenue DESC;
	
-- Monthly Revenue Trend

SELECT
    DATE_TRUNC('month', InvoiceDate) AS Month,
    SUM(Quantity * UnitPrice) AS MonthlyRevenue
FROM
    retail_sales
GROUP BY
    DATE_TRUNC('month', InvoiceDate)
ORDER BY
    Month;
	
-- Top 10 Best Selling Products

SELECT
    Description,
    SUM(Quantity) AS TotalQuantitySold,
	SUM(Quantity*UnitPrice) AS TotalRevenuefromProduct
FROM
    retail_sales
GROUP BY
    Description
ORDER BY
    TotalQuantitySold DESC
LIMIT 10;

-- Revenue per Customer

SELECT
    CustomerID,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM
    retail_sales
GROUP BY
    CustomerID
ORDER BY
    TotalRevenue DESC;






























