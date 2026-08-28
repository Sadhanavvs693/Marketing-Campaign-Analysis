-- ============================================================
-- QUERY 1
-- Campaign acceptance and response rate
-- ============================================================

SELECT
    SUM(AcceptedCmp1) AS Campaign1_Accepted,
    SUM(AcceptedCmp2) AS Campaign2_Accepted,
    SUM(AcceptedCmp3) AS Campaign3_Accepted,
    SUM(AcceptedCmp4) AS Campaign4_Accepted,
    SUM(AcceptedCmp5) AS Campaign5_Accepted,
    SUM(Response) AS Final_Response,

    ROUND(SUM(AcceptedCmp1) * 100.0 / COUNT(*), 2) AS Campaign1_Response_Rate,
    ROUND(SUM(AcceptedCmp2) * 100.0 / COUNT(*), 2) AS Campaign2_Response_Rate,
    ROUND(SUM(AcceptedCmp3) * 100.0 / COUNT(*), 2) AS Campaign3_Response_Rate,
    ROUND(SUM(AcceptedCmp4) * 100.0 / COUNT(*), 2) AS Campaign4_Response_Rate,
    ROUND(SUM(AcceptedCmp5) * 100.0 / COUNT(*), 2) AS Campaign5_Response_Rate,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Final_Response_Rate

FROM Customers_Clean;

-- ============================================================
-- QUERY 2
-- Spending patterns across product categories
-- ============================================================

-- Overall average spending by product category

SELECT
    ROUND(AVG(MntWines), 2) AS Avg_Wine_Spending,
    ROUND(AVG(MntFruits), 2) AS Avg_Fruit_Spending,
    ROUND(AVG(MntMeatProducts), 2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFishProducts), 2) AS Avg_Fish_Spending,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweet_Spending,
    ROUND(AVG(MntGoldProds), 2) AS Avg_Gold_Spending
FROM Customers_Clean;


-- ============================================================
-- QUERY 2
-- Spending patterns across age category
-- ============================================================

SELECT
    CASE
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS Age_Group,
    ROUND(AVG(MntWines), 2) AS Avg_Wine_Spending,
    ROUND(AVG(MntFruits), 2) AS Avg_Fruit_Spending,
    ROUND(AVG(MntMeatProducts), 2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFishProducts), 2) AS Avg_Fish_Spending,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweet_Spending,
    ROUND(AVG(MntGoldProds), 2) AS Avg_Gold_Spending
FROM Customers_Clean
GROUP BY Age_Group
ORDER BY Age_Group;

Spending patterns across income category

SELECT
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Medium Income'
        WHEN Income BETWEEN 60000 AND 90000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS Income_Group,

    ROUND(AVG(MntWines), 2) AS Avg_Wine_Spending,
    ROUND(AVG(MntFruits), 2) AS Avg_Fruit_Spending,
    ROUND(AVG(MntMeatProducts), 2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFishProducts), 2) AS Avg_Fish_Spending,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweet_Spending,
    ROUND(AVG(MntGoldProds), 2) AS Avg_Gold_Spending

FROM Customers_Clean
GROUP BY Income_Group
ORDER BY Income_Group;

--Spending patterns across marital status category
SELECT
    Marital_Status,

    ROUND(AVG(MntWines), 2) AS Avg_Wine_Spending,
    ROUND(AVG(MntFruits), 2) AS Avg_Fruit_Spending,
    ROUND(AVG(MntMeatProducts), 2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFishProducts), 2) AS Avg_Fish_Spending,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweet_Spending,
    ROUND(AVG(MntGoldProds), 2) AS Avg_Gold_Spending

FROM Customers_Clean
GROUP BY Marital_Status
ORDER BY Avg_Wine_Spending DESC;


--Spending patterns across country category
SELECT
    Country,

    COUNT(*) AS Customer_Count,

    ROUND(AVG(MntWines), 2) AS Avg_Wine_Spending,
    ROUND(AVG(MntFruits), 2) AS Avg_Fruit_Spending,
    ROUND(AVG(MntMeatProducts), 2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFishProducts), 2) AS Avg_Fish_Spending,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweet_Spending,
    ROUND(AVG(MntGoldProds), 2) AS Avg_Gold_Spending

FROM Customers_Clean
GROUP BY Country
ORDER BY Avg_Wine_Spending DESC;

 QUERY 3

-- Which channels are most used by high-value customers?
SELECT
    'High Value Customers' AS Customer_Segment,

    COUNT(*) AS Customer_Count,

    ROUND(AVG(NumWebPurchases), 2) AS Avg_Web_Purchases,
    ROUND(AVG(NumStorePurchases), 2) AS Avg_Store_Purchases,
    ROUND(AVG(NumCatalogPurchases), 2) AS Avg_Catalog_Purchases,
    ROUND(AVG(NumDealsPurchases), 2) AS Avg_Deal_Purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS Avg_Web_Visits_Per_Month

FROM Customers_Clean
WHERE TotalSpending >= 1020;

-- ============================================================
-- QUERY 4
-- Identify under-served customer segments
-- ============================================================

SELECT
    CASE
        WHEN TotalSpending < 640.33
             AND NumWebVisitsMonth >= 5
             AND Response = 0
        THEN 'Under-served Customers'
        ELSE 'Other Customers'
    END AS Customer_Segment,

    COUNT(*) AS Customer_Count,

    ROUND(AVG(TotalSpending), 2) AS Avg_Spending,
    ROUND(AVG(NumWebVisitsMonth), 2) AS Avg_Web_Visits,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate

FROM Customers_Clean
GROUP BY Customer_Segment;

-- ============================================================
-- QUERY 5
-- Characteristics of ideal target customers
-- ============================================================

SELECT
    CASE
        WHEN Response = 1 THEN 'Responders'
        ELSE 'Non-Responders'
    END AS Customer_Group,

    COUNT(*) AS Customer_Count,

    ROUND(AVG(Age), 2) AS Avg_Age,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(TotalSpending), 2) AS Avg_Total_Spending,
    ROUND(AVG(TotalChildren), 2) AS Avg_Total_Children,
    ROUND(AVG(NumWebVisitsMonth), 2) AS Avg_Web_Visits

FROM Customers_Clean
GROUP BY Customer_Group;

---Find the strongest age groups

SELECT
    CASE
        WHEN Age < 40 THEN 'Under 40'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS Age_Group,

    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(TotalSpending), 2) AS Avg_Spending

FROM Customers_Clean
GROUP BY Age_Group
ORDER BY Response_Rate DESC;

---- income band
SELECT
    CASE
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income BETWEEN 30000 AND 60000 THEN 'Medium Income'
        WHEN Income BETWEEN 60001 AND 90000 THEN 'High Income'
        ELSE 'Very High Income'
    END AS Income_Group,

    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate,
    ROUND(AVG(Age), 2) AS Avg_Age,
    ROUND(AVG(TotalSpending), 2) AS Avg_Spending

FROM Customers_Clean
GROUP BY Income_Group
ORDER BY Response_Rate DESC;


--- family composition
SELECT
    CASE
        WHEN TotalChildren = 0 THEN 'No Children'
        WHEN TotalChildren = 1 THEN '1 Child'
        WHEN TotalChildren = 2 THEN '2 Children'
        ELSE '3+ Children'
    END AS Family_Group,

    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(TotalSpending), 2) AS Avg_Spending

FROM Customers_Clean
GROUP BY Family_Group
ORDER BY Response_Rate DESC;

--- country

SELECT
    Country,
    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(TotalSpending), 2) AS Avg_Spending
FROM Customers_Clean
GROUP BY Country
ORDER BY Response_Rate DESC;