SELECT * FROM blinkitdb.blinkit_data;

SELECT count(*) FROM blinkitdb.blinkit_data;

ALTER TABLE blinkitdb.blinkit_data
RENAME COLUMN ï»¿item_fat_content TO Item_Fat_content;

SELECT * FROM blinkitdb.blinkit_data;

SELECT distinct(ITEM_FAT_CONTENT) FROM blinkitdb.blinkit_data;

SET SQL_SAFE_UPDATES = 0;

UPDATE blinkitdb.blinkit_data
SET Item_fat_content =
CASE
WHEN Item_fat_content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_fat_content = 'reg' THEN 'Regular'
ELSE Item_fat_content
END;
SELECT distinct(item_fat_content) FROM blinkitdb.blinkit_data;

-- Total Sales

SELECT SUM(Total_Sales) as Total_Sales
FROM blinkitdb.blinkit_data;

SELECT CAST(SUM(Total_Sales)/ 1000000 AS DECIMAL (10,2)) AS Total_Sales_Millions
FROM blinkitdb.blinkit_data;

-- Average Sales

SELECT AVG(Total_Sales) AS Avg_Sales
FROM blinkitdb.blinkit_data;

SELECT CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales
FROM blinkitdb.blinkit_data;

-- Number of Items

SELECT COUNT(*) AS No_Of_Items
FROM blinkitdb.blinkit_data;

SELECT CAST(SUM(Total_Sales)/ 1000000 AS DECIMAL (10,2)) AS Total_Sales_Millions
FROM blinkitdb.blinkit_data
WHERE Item_fat_content = 'Low Fat';

SELECT CAST(SUM(Total_Sales)/ 1000000 AS DECIMAL (10,2)) AS Total_Sales_Millions
FROM blinkitdb.blinkit_data
WHERE Outlet_Size = 'Small' ;

-- Average Rating

SELECT AVG(Rating_s) AS AVG_Rating
FROM blinkitdb.blinkit_data;

SELECT CAST(AVG(Rating_s) AS DECIMAL (10, 2)) AS AVG_Rating
FROM blinkitdb.blinkit_data;

-- Total Sales by Fat Content 

SELECT item_fat_content, 
		CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales,
        CAST(AVG(Rating_s) AS DECIMAL (10, 2)) AS AVG_Rating,
        COUNT(*) AS No_Of_Items
FROM blinkitdb.blinkit_data
WHERE Outlet_Size = 'Small'
GROUP BY item_fat_content
ORDER BY Total_Sales DESC;

-- Total Sales by Item Type

SELECT Item_Type, 
		CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales,
        CAST(AVG(Rating_s) AS DECIMAL (10, 2)) AS AVG_Rating,
        COUNT(*) AS No_Of_Items
FROM blinkitdb.blinkit_data
WHERE Outlet_Size = 'Small'
GROUP BY Item_Type
ORDER BY Total_Sales
LIMIT 5;

-- Fat content by outlet for Total Sales

SELECT Outlet_Location_Type, Item_Fat_content,
		CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales,
        CAST(AVG(Rating_s) AS DECIMAL (10, 2)) AS AVG_Rating,
        COUNT(*) AS No_Of_Items
FROM blinkitdb.blinkit_data
WHERE Outlet_Size = 'Small'
GROUP BY Outlet_Location_Type, Item_Fat_content
ORDER BY Total_Sales ASC
LIMIT 5;

-- Total Sales by outlet establishment year

Select`Outlet_Establishment Year`,
			CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
            CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales,
            COUNT(*) AS No_Of_Sales,
            CAST(AVG(Rating_s) AS DECIMAL (10,2)) AS Avg_Ratings
from blinkitdb.blinkit_data
GROUP BY `Outlet_Establishment Year`
ORDER BY Total_Sales DESC;

-- Percentage of Sales by outlet size

SELECT 
	Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales)* 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL (10,2)) AS Sales_Percentage
FROM blinkitdb.blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Sales by outlet location 

Select Outlet_Location_Type,
			CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
            CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales,
            COUNT(*) AS No_Of_Sales,
            CAST(AVG(Rating_s) AS DECIMAL (10,2)) AS Avg_Ratings
from blinkitdb.blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- All Metrics by outlet type

Select Outlet_Type,
			CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
            CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Avg_Sales,
            COUNT(*) AS No_Of_Sales,
            CAST(AVG(Rating_s) AS DECIMAL (10,2)) AS Avg_Ratings
from blinkitdb.blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

