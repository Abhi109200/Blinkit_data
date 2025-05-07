# Blinkit_data
This repository contains the SQL script used for analyzing Blinkit data. The goal of this analysis is to extract actionable insights and better understand the operational metrics of Blinkit.

📋 File Information
File Name: Blinkit_data.sql
Purpose: This file contains SQL queries designed for data analysis, including:
Data cleaning and transformation.
Aggregate analysis and key performance indicator (KPI) extraction.
Identifying trends and patterns across the dataset.

🌟 Insights Gained
Through this SQL analysis, the following insights can be derived:
Order Trends: Identify peak order times and seasonal trends.
Customer Behavior: Analyze customer purchase frequency and preferences.
Revenue Insights: Understand revenue contributions by product categories or regions.
Operational Metrics: Evaluate delivery efficiency and identify bottlenecks.
Top Products/Services: Pinpoint high-demand products or services.
These insights can drive decisions such as inventory management, customer retention strategies, and marketing campaigns.

🛠️ Technologies Used
Database: SQL
Tools: MySQL, PostgreSQL, or any compatible SQL database engine.

### SQL Analysis for Blinkit Data

Here are the insights and key SQL queries derived from the Blinkit dataset:

#### Database and Table Creation
- **Database Creation**: 
  ```sql
  CREATE DATABASE blinkitdb;
  ```
- **Table Schema**:
  ```sql
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
  ```

#### Data Cleaning
- **Standardizing `Item_Fat_Content` Values**:
  ```sql
  SET SQL_SAFE_UPDATES = 0;

  UPDATE blinkit_data
  SET Item_Fat_Content =
  CASE
      WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
      WHEN Item_Fat_Content = 'reg' THEN 'Regular'
      ELSE Item_Fat_Content
  END;

  SET SQL_SAFE_UPDATES = 1;
  ```
- This query ensures consistency in the `Item_Fat_Content` column by merging variants like `LF` and `low fat` into `Low Fat`.

#### Data Exploration
- **Distinct Fat Content Types**:
  ```sql
  SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data;
  ```

- **Viewing Full Table**:
  ```sql
  SELECT * FROM blinkit_data;
  ```

#### Key Metrics
1. **Total Sales**:
   - Overall sales:
     ```sql
     SELECT SUM(Total_Sales) AS total_sales FROM blinkit_data;
     ```
   - Total sales in millions:
     ```sql
     SELECT CONCAT(
         CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10, 2)),
         ' million'
     ) AS Total_Sales_In_Millions
     FROM blinkit_data;
     ```

2. **Average Sales**:
   - Overall average sales:
     ```sql
     SELECT CAST(AVG(Total_Sales) AS DECIMAL(10, 0)) AS avg_sales FROM blinkit_data;
     ```

3. **Sales by Location Type**:
   ```sql
   SELECT Outlet_Location_Type, SUM(Total_Sales) AS location_sales
   FROM blinkit_data
   GROUP BY Outlet_Location_Type;
   ```

4. **Sales by Item Type**:
   ```sql
   SELECT Item_Type, SUM(Total_Sales) AS item_sales
   FROM blinkit_data
   GROUP BY Item_Type;
   ```

5. **Yearly Sales**:
   ```sql
   SELECT Outlet_Establishment_Year, SUM(Total_Sales) AS yearly_sales
   FROM blinkit_data
   GROUP BY Outlet_Establishment_Year
   ORDER BY Outlet_Establishment_Year;
   ```

6. **Top-Selling Outlets**:
   ```sql
   SELECT Outlet_Identifier, SUM(Total_Sales) AS outlet_sales
   FROM blinkit_data
   GROUP BY Outlet_Identifier
   ORDER BY outlet_sales DESC
   LIMIT 5;
   ```

#### Insights
- **Sales Trends**:
  - The total sales exceeded significant milestones, with detailed trends by location type and item categories.
  - Certain outlet locations consistently outperformed others.

- **Product Popularity**:
  - High sales in specific item types indicate customer preferences.

- **Historical Data**:
  - Sales performance trends over establishment years provide insights into outlet growth.

