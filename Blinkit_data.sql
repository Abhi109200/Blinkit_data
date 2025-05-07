create database blinkitdb;
CREATE TABLE blinkit_data (
    Item_Fat_Content VARCHAR(50),
    Item_Identifier VARCHAR(50),
    Item_Type VARCHAR(50),
    Outlet_Establishment_Year INT,
    Outlet_Identifier VARCHAR(50),
    Outlet_Location_Type VARCHAR(50),
    Outlet_Size VARCHAR(20),
    Outlet_Type VARCHAR(20),
    Item_Visibility FLOAT,
    Item_Weight FLOAT,
    Total_Sales FLOAT,
    Rating FLOAT
);
select * from blinkit_data;

SET SQL_SAFE_UPDATES = 0;

Update blinkit_data
set Item_Fat_Content =
case
When Item_Fat_Content in ('LF','low fat') then 'Low Fat'
When Item_Fat_Content = 'reg' then 'Regular'
ELSE Item_Fat_Content
END; 

SET SQL_SAFE_UPDATES = 1;

SELECT distinct(ITEM_FAT_CONTENT) from blinkit_data;
SELECT * FROM blinkit_data;

--- KPI
SELECT SUM(Total_Sales) AS total_sales 
FROM blinkit_data;
SELECT CONCAT(
    CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10,2)), 
    ' million'
) AS Total_Sales_In_Millions
FROM blinkit_data;

SELECT CAST(avg(TOTAL_SALES) AS DECIMAL(10,0))AS AVG_SALES
FROM blinkit_data;

SELECT count(*) AS NO_OF_ITEMS FROM blinkit_data;
SELECT CONCAT(
    CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10,2)), 
    ' million'
) AS Total_Sales_In_Millions
FROM blinkit_data where Item_Fat_Content = 'LOW FAT';

select * from blinkit_data;

SELECT CONCAT(
    CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10,2)), 
    ' million'
) AS Total_Sales_In_Millions
FROM blinkit_data where Outlet_Location_Type = 'TIER 3';

SELECT cast(AVG(RATING) AS DECIMAL(10,2)) AS RATING FROM BLINKIT_DATA;
SELECT cast(AVG(RATING) AS DECIMAL(10,2)) AS RATING FROM BLINKIT_DATA where 
OUTLET_LOCATION_TYPE = 'TIER 3';
SELECT cast(AVG(RATING) AS DECIMAL(10,2)) AS RATING FROM BLINKIT_DATA where 
OUTLET_LOCATION_TYPE = 'TIER 1';

--- Granular Requirements

---  Total Sales by Fat Content:
select ITEM_FAT_CONTENT,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by Item_Fat_Content
order by Total_Sales desc;
--- Total Sales by Item Type:
select ITEM_TYPE,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by Item_Type
order by Total_Sales desc;
--- Fat Content by Outlet for Total Sales:
select Outlet_Location_Type,Item_Fat_Content,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by OUTLET_LOCATION_TYPE,Item_Fat_Content
order by Total_Sales desc;

SELECT Outlet_Location_Type,
       COALESCE(SUM(CASE WHEN Item_Fat_Content IN ('Low Fat', 'LF') THEN Total_Sales ELSE 0 END), 0) AS Low_Fat,
       COALESCE(SUM(CASE WHEN Item_Fat_Content IN ('Regular', 'Reg') THEN Total_Sales ELSE 0 END), 0) AS Regular
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;
--- Total Sales by Outlet Establishment
select Outlet_Establishment_Year,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by Outlet_Establishment_Year
order by Total_Sales desc;
--- Percentage of Sales by Outlet Size:
select Outlet_Size,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by Outlet_Size
order by Total_Sales desc;
--- Sales by Outlet Location:
Select Outlet_Location_Type,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by Outlet_Location_Type
order by Total_Sales desc;
--- All Metrics by Outlet Type:
Select Outlet_Type,
       CAST(SUM(TOTAL_SALES) AS DECIMAL(10,2)) AS TOTAL_SALES,
       CAST(avg(TOTAL_SALES) AS DECIMAL(10,1)) AS AVG_SALES,
       count(*) as no_of_items,
       CAST(avg(Rating) AS DECIMAL(10,2)) AS AVG_RATING
FROM blinkit_data
group by Outlet_Type
order by Total_Sales desc;


