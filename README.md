# MagicMade: Shopping Cart Abandonment Analysis Project Report

## Executive Summary

This report outlines the findings and strategic recommendations derived from the Shopping Cart Abandonment Analysis for MagicMade, based on 1,413 user sessions analyzed.<br>

The project confirmed a critical revenue leakage point, identifying the overall abandonment rate at 46.7% (significantly below the assumed industry standard of 70.0%). The root causes are overwhelmingly operational and experience-based, with the top three reasons for abandonment being 'No Guest Checkout Option,' 'Complex Checkout,' and 'No Total Order Upfront.'<br>

The analysis highlighted that mobile users (56.48% of abandoners) and female users (64.7%) represent the largest segments of lost revenue. Furthermore, Social Media (45.78%) is the leading source of traffic that results in abandonment.<br>

<strong>Key Recommendation:</strong> Implement a fast-tracked, mobile-first checkout process that includes a mandatory guest checkout option and clear, transparent pricing (including estimated shipping costs) displayed throughout the cart journey.

## Project Context and Objectives
| Category | Description |	
|----------|-----------------|
| Business Problem |	Significant revenue loss due to a high rate of shopping cart abandonment.     |
|Project Aim |  To identify the underlying causes of abandonment through data analysis, leading to actionable insights for optimizing the purchase journey and increasing conversion rates.    | 
| Goals | 1. Increase Conversions. 2. Enhance Customer Experience. 3. Optimize Marketing Strategies. |
| Tech Stack | MSSQL (Data Cleaning & Querying), Power BI (Data Analysis & Visualization). |

## Project Methodology and Execution Steps

This project followed a structured, six-step analytical process, moving from raw data ingestion to generating actionable business recommendations, ensuring all project goals were met.
### 1. Database and Data Ingestion (MSSQL):
 * Created the dedicated database (MagicMade_Ecommerce) and schema (MagicMadee) to house the raw data.
 * Imported the 1,500 rows of user and cart data into the primary table (MagicMade.Cart_Records).
```sql
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

# Create Table
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
);

--Import Data

```
### 2. Data Cleaning and Transformation (MSSQL):

Addressed data integrity issues by updating the Payment_Method field for all 'Abandoned' records to 'N/A - Abandoned' (as a payment method is irrelevant for an incomplete transaction).<br>
Validated the dataset by checking for duplicates and identifying outliers in Session_Duration for review.<br>
Created derived fields, such as custom ranges for Session_Duration, to facilitate advanced trend analysis.
```sql
SELECT User_ID,	User_Location, Gender,	Cart_Contents,	Cart_Value,	Session_Date,	Session_Duration,	Abandonment_Reason,
Purchase_Category,	Referral_Medium,	Device_Type,	Cart_Status
FROM MagicMade.Cart_Records
GROUP BY User_ID,	User_Location, Gender,	Cart_Contents,	Cart_Value,	Session_Date,	Session_Duration,	Abandonment_Reason,
Purchase_Category,	Referral_Medium,	Device_Type,	Cart_Status
HAVING COUNT(*) > 1;   --Filters the duplicate
```
### 3. Exploratory Data Analysis (EDA) and Querying (MSSQL):

Executed targeted SQL queries to calculate core metrics, including the overall Abandonment Rate (46.7%), total lost cart value, and abandonment counts segmented by key variables (Location, Cart Contents, Abandonment Reason).

This phase established the quantitative foundation for all subsequent findings.

### 4. Advanced Analysis and User Segmentation (Power BI):

Connected the clean MSSQL data to Power BI for interactive analysis.

Defined calculated fields (DAX) and created dimensional models to enable complex drill-down segmentation on user behavior (e.g., Device_Type, Referral_URL).

Segmented users based on behavior to isolate high-impact groups (e.g., Mobile users contributing 56.48% of abandonments).

<img width="1270" height="712" alt="Screenshot 2025-11-05 231519" src="https://github.com/user-attachments/assets/be0862af-4b06-41a2-b6ac-8c15fa3b1899" />

### 5. Visualization and Dashboard Creation (Power BI):

Designed a comprehensive, interactive dashboard to visualize key metrics, trends (e.g., Abandoned Users by Week), and segmentation results (e.g., Abandonment Reasons).

Ensured visualizations clearly highlighted the top three operational factors driving abandonment for clear business consumption.

<img width="1268" height="710" alt="Screenshot 2025-11-05 231452" src="https://github.com/user-attachments/assets/787043c0-e205-486e-b85a-d4fc2e14bdb3" />

### 6. Reporting and Strategy Recommendations:

Synthesized the quantitative findings (e.g., high Mobile abandonment) with the qualitative causes (e.g., No Guest Checkout).

Developed five targeted, measurable, and actionable recommendations (e.g., Guest Checkout, Price Transparency) linked directly to the data insights to drive revenue optimization.

## Data Description and Scope

### Data Set Overview

The analysis was conducted on a dataset of approximately 1,500 user rows, focusing on cart, session, and user behavior data.
| Column Name | Description |	Role in Analysis |
|----------|-----------------|-----------------|
| User ID  | Unique identifier.| Segmentation, history tracking|
| Purchase Status | Key Metric: 'Abandoned' or 'Completed'. | Calculation of Abandonment Rate.|
| Abandonment Reason | Primary driver of the analysis (e.g., Shipping Cost, Complex Checkout). |Identifying pain points.|
| Device Type | Desktop, Mobile, Tablet. |Mobile optimization strategy.|
| Referral URL | Source of traffic (Social, Search, Email). | Marketing optimization.|
| Cart Value | Total value of items in the cart. | Revenue impact calculation.|
| Customer Profile | 'New,' 'Returning,' 'Frequent'. | Behavioral segmentation.|

### Project Scope Breakdown (MSSQL & Power BI)

| Phase | Tool|	Key Deliverables |
|----------|-----------------|-----------------|
| Data Importation | MSSQL | Creation of MagicMade_CartData table.|
| Cleaning & Transformation | MSSQL |Handling of missing Payment Method values in 'Abandoned' records. Validation of Session Duration outliers. Data type standardization.|
| Querying & Manipulation | Primary driver of the analysis (e.g., Shipping Cost, Complex Checkout). |Identifying pain points.|
| Device Type | MSSQL |Calculation of abandonment rate by segment (e.g., Location, Device).|
| Analysis & Segmentation | Power BI/DAX | Creation of user segments (Gender, Device, Referral Source). Correlation of cart value to abandonment reason.|
|Visualization & Reporting | Power BI | Interactive Dashboard highlighting key metrics and trends.|

## Key Analytical Findings

The following insights were directly derived from the Power BI dashboard visualizations and MSSQL queries:

### A. Abandonment Rate & Revenue Impact

Overall Abandonment Rate: 46.7% (660 abandoned users out of 1,413 total users).

Abandoned Cart Value: The value of lost sales is substantial, with an average duration of 62.97 minutes indicating high-intent shoppers who were ultimately deterred.

### B. Root Causes for Abandonment
| Reason | Count |	Percentage of Abandoned Users | Business Implication|
|----------|-----------------|-----------------|-----------------|
|No Guest Checkout Option| 334| 50.6%| Severe friction at the beginning of the checkout process.|
| Complex Checkout | 199 | 30.2% | Usability issues and excessive form fields.|
| No Total Order Upfront | 101 | 15.3% |Lack of pricing transparency, particularly regarding shipping.|
| Shipping Cost |30 | 4.5% | Secondary cost issue, often related to the previous point.|

### C. User Segmentation & Behavior
| Segment | Key Insight |	Recommendation Link | 
|----------|-----------------|-----------------|
|Device Type| 56.48% of abandoned users are on Mobile devices, followed by tablets.| Mobile Optimization.| 
| Gender | 64.7% of abandoned users are Female.| Targeted marketing and UI/UX testing on this demographic. | 
| Referral Source |45.78% come from Social Media; 35.54% from Search Engines. | Retargeting campaigns are highly valuable for the social segment.|
| Geography |Abandonment is highest in Virginia, suggesting possible localized shipping or tax issues. | Investigate regional logistics/pricing models.|
| Product Category |Highest abandonment is seen in Accessories, Toys, and Footwear. Top individual items: Wristwatch, Sunglasses, Tablet.|Tailored recovery emails based on product category.|


## Insights & Recommendations
### Insights
1. The company's abandonment rate is lower than the industry standard rate with a difference of 22.2%.
2. The majority of abandoned users are on mobile devices (55.67%), followed by tablets and desktops.
3. The company's abandonment rate across devices is lower than the industry standard, especially on mobile.
4. The top reasons for cart abandonment are no guest checkout option, complex checkout, no total order upfront, and shipping costs.
5. Most abandoned users come from social media (44.42%), and the session range where abandonment is highest is between 77-100 sessions.
6. The cart contents with the highest abandonment are accessories, toys, and footwear.
7. The majority of abandoned users are female (64.55%).
8. The location data suggests that abandonment is spread across several regions in North America, with Virginia being notably higher.
9. The trend of abandoned users by week shows fluctuation with some peaks suggesting periodic increases in abandonment rates.
10. Items such as sunglasses, wristwatches, and tablets are among the top categories for abandoned purchases.
    
### Recommendation
1. Optimize for Mobile: Since most users abandon carts on mobile, optimizing the checkout process for mobile devices could reduce abandonment rates.
2. Simplify Checkout: Offering a guest checkout option and simplifying the checkout process could address the two top reasons for abandonment.
3. Transparency in Pricing: Clearly displaying total costs upfront, including shipping, could reduce abandonment due to no total order cost upfront.
4. Leverage Social Media: Since a significant portion of traffic comes from social media, retargeting campaigns on these platforms could help recover abandoned carts.
5. Tailored Marketing Strategies: Develop targeted marketing strategies for the top abandoned items like sunglasses, wristwatches, and tablets to improve conversions in these categories.
Address Shipping Costs: Offering free shipping thresholds or flat-rate shipping could mitigate abandonment due to shipping costs.

### MSSQL Code Samples

To demonstrate the data preparation and querying skills used to drive the analysis, the following MSSQL code examples were employed:
```sql
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

--Conect
```
