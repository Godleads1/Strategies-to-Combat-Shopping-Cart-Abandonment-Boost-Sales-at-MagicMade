--1. SRUCTURE

--Create Database
CREATE DATABASE MagicMade_Ecommerce

--2 ways to use the Database created 
--1st is by use the function 'use' and the name of the database created, 2nd is to go to the available database area, and select the database to use.
USE MagicMade_Ecommerce

GO--'go' is used to seperate codes from one another to avoid red underlining in the next code.

--Create Schema
Create Schema MagicMadee    --A schema helps us to logically group our tables under one name, for easy identification & to keep our data organized.
GO

/*Create Table
CREATE TABLE MagicMade.Cart_Records
(
User_ID VARCHAR (30),
Location VARCHAR (20),
Gender VARCHAR (10),
Cart_Contents VARCHAR (20),
Cart_Value FLOAT (30),
Session_Date DATE,
Session_Duration INT,
Abandonment_Reason VARCHAR (30),
Purchase_Category VARCHAR (20),
Referral_Medium VARCHAR (20),
Device_Type VARCHAR (10),
Cart_Status VARCHAR (20)
);*/

--Import Data
  

-- 2. EDA

--View Data
SELECT *
FROM MagicMade.Cart_Records

--Check for duplicates
SELECT User_ID,	User_Location, Gender,	Cart_Contents,	Cart_Value,	Session_Date,	Session_Duration,	Abandonment_Reason,
Purchase_Category,	Referral_Medium,	Device_Type,	Cart_Status
FROM MagicMade.Cart_Records
GROUP BY User_ID,	User_Location, Gender,	Cart_Contents,	Cart_Value,	Session_Date,	Session_Duration,	Abandonment_Reason,
Purchase_Category,	Referral_Medium,	Device_Type,	Cart_Status
HAVING COUNT(*) > 1;   --Filters the duplicate


--Count number of rows
SELECT COUNT (*)
FROM MagicMade.Cart_Records;

--Sum of cart value
SELECT SUM(Cart_Value) AS Total_Value
FROM MagicMade.Cart_Records;

--Number of rows by cart status
SELECT Cart_Status, COUNT(*) AS Number
FROM MagicMade.Cart_Records
GROUP BY Cart_Status;

--Rows by gender
SELECT Gender, COUNT(*) AS Number
FROM MagicMade.Cart_Records
GROUP BY Gender;

--Gender by Abandoned Cart status
SELECT Gender, Cart_Status, Count (*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY Gender, Cart_Status;

--Rows by Location
SELECT User_Location, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Paid'
GROUP BY User_Location
ORDER BY 2 DESC;

--Abandoned Cart status by Location 
SELECT User_Location, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY User_Location
ORDER BY 2 DESC;

--Paid by Cart Contents
SELECT Cart_Contents, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Paid'
GROUP BY Cart_Contents
ORDER BY 2 DESC;

--Abandoned Cart status by cart contents 
SELECT Cart_Contents, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY Cart_Contents
ORDER BY 2 DESC;

--Abandnment reasons
SELECT Abandonment_Reason, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY Abandonment_Reason
ORDER BY 2 DESC;

--Paid by Purchase Category
SELECT Purchase_Category, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Paid'
GROUP BY Purchase_Category
ORDER BY 2 DESC;


--Top 10 Abandoned Cart status by Purchase Category
SELECT TOP 10 Purchase_Category, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY Purchase_Category
ORDER BY 2 DESC;

--Referral Medium by Paid Cart status
SELECT Referral_Medium, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Paid'
GROUP BY Referral_Medium
ORDER BY 2 DESC;

--Referral Medium by Abandoned Cart status
SELECT Referral_Medium, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY Referral_Medium
ORDER BY 2 DESC;

--Device Type by Paid Cart status
SELECT Device_Type, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Paid'
GROUP BY Device_Type
ORDER BY 2 DESC;

--Device Type by Abandoned Cart status
SELECT Device_Type, COUNT(*) AS Number
FROM MagicMade.Cart_Records
WHERE Cart_Status = 'Abandoned'
GROUP BY Device_Type
ORDER BY 2 DESC;

--Create ranges for session duration
SELECT Duration_Range, COUNT(*) AS Number
FROM(SELECT
    CASE
        WHEN Session_Duration >= 5 AND Session_Duration <= 28 THEN '5-28'
        WHEN Session_Duration >= 29 AND Session_Duration <= 52 THEN '29-52'
        WHEN Session_Duration >= 53 AND Session_Duration <= 76 THEN '53-76'
		WHEN Session_Duration >= 77 AND Session_Duration <= 100 THEN '77-100'
        ELSE '101-120'
    END AS Duration_Range
FROM MagicMade.Cart_Records
--WHERE Cart_Status = 'Abandoned'
) AS Ranges
GROUP BY Duration_Range
ORDER BY Number DESC;

--Conect to Power BI for Visualization
