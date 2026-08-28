-- ============================================================
-- QUERY 1
-- Overall Customer Summary
-- ============================================================

SELECT
    COUNT(*) AS Total_Customers,
    COUNT(DISTINCT ID) AS Unique_Customers,
    SUM(Response) AS Total_Responders,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(TotalSpending), 2) AS Avg_Spending,
    ROUND(AVG(TotalPurchases), 2) AS Avg_Purchases
FROM Customers_Clean;


-- ============================================================
-- QUERY 2
-- Response Rate by Education
-- ============================================================

SELECT
    Education,
    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM Customers_Clean
GROUP BY Education
ORDER BY Response_Rate DESC;


-- ============================================================
-- QUERY 3
-- Response Rate by Country
-- ============================================================

SELECT
    Country,
    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate
FROM Customers_Clean
GROUP BY Country
ORDER BY Response_Rate DESC;



-- ============================================================
-- QUERY 4
-- Response Rate by Spending Group
-- ============================================================

SELECT
    CASE
        WHEN TotalSpending < 300 THEN 'Low Spending'
        WHEN TotalSpending BETWEEN 300 AND 700 THEN 'Medium Spending'
        WHEN TotalSpending BETWEEN 701 AND 1200 THEN 'High Spending'
        ELSE 'Very High Spending'
    END AS Spending_Group,

    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate

FROM Customers_Clean
GROUP BY Spending_Group
ORDER BY Response_Rate DESC;


-- ============================================================
-- QUERY 5
-- Response Rate by Total Purchase Group
-- ============================================================

SELECT
    CASE
        WHEN TotalPurchases <= 5 THEN 'Low Purchases'
        WHEN TotalPurchases BETWEEN 6 AND 10 THEN 'Medium Purchases'
        WHEN TotalPurchases BETWEEN 11 AND 15 THEN 'High Purchases'
        ELSE 'Very High Purchases'
    END AS Purchase_Group,

    COUNT(*) AS Customer_Count,
    SUM(Response) AS Responders,
    ROUND(AVG(Response) * 100, 2) AS Response_Rate

FROM Customers_Clean
GROUP BY Purchase_Group
ORDER BY Response_Rate DESC;