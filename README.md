# Marketing Campaign Analysis

## 📌 Project Overview

This project analyzes customer marketing campaign data to understand customer behavior, spending patterns, campaign responses, and customer segments.

The project uses **Python, SQL/MySQL, and Power BI** to transform raw customer data into business insights and recommendations for future marketing campaigns.

---

## 🎯 Business Objectives

The analysis focuses on five key business questions:

1. Which customer segments have the highest campaign response rates?
2. How do product spending patterns vary across customer segments?
3. Which purchase channels are most used by high-value customers?
4. Which customer segments are under-served?
5. What characteristics define ideal target customers for future campaigns?

---

## 🛠️ Tools & Technologies

* Python
* Pandas
* Jupyter Notebook
* MySQL
* SQL
* Power BI
* VS Code
* GitHub

---

## 📂 Project Structure

```text
Marketing_Campaign_Project/
│
├── .gitignore
├── README.md
│
├── data/
│   ├── marketing_campaign_data.csv
│   └── marketing_data_dictionary.csv
│
├── notebooks/
│   ├── marketing_analysis.ipynb
│   └── customer_campaign_cleaned.csv
│
├── powerbi/
│   └── Marketing_Campaign_Analysis.pbix
│
├── reports/
│
└── sql/
    ├── marketing_campaign_analysis.sql
    └── top_5_queries.sql
```

---

## 🔍 Project Workflow

**Raw Data → Data Cleaning → Exploratory Data Analysis → Statistical Analysis → SQL Analysis → Power BI Dashboard → Business Recommendations**

---

## 🧹 Data Cleaning

The dataset was cleaned and prepared for analysis by:

* Identifying duplicate customer records
* Creating a cleaned customer dataset
* Checking data quality and missing values
* Creating derived variables such as Age
* Creating Total Spending
* Creating Total Purchases
* Creating customer spending and purchase groups

The original dataset contained **56,000 customer records**.

During SQL validation, duplicate records were identified and a cleaned customer table, `Customers_Clean`, was used for the final analysis.

---

## 📊 Exploratory Data Analysis

The analysis examined:

* Customer demographics
* Income
* Age
* Marital status
* Education
* Product spending
* Purchase channels
* Website visits
* Campaign acceptance
* Campaign response
* Country
* Family composition

---

## 🗄️ SQL Analysis

SQL was used to answer the project's main business questions and perform supporting analysis.

### Main SQL Analysis

The `top_5_queries.sql` file contains the five major business-question analyses:

1. Campaign acceptance and response
2. Product spending patterns
3. High-value customer purchase channels
4. Under-served customer segments
5. Ideal target customer characteristics

### Supporting SQL Analysis

The `marketing_campaign_analysis.sql` file contains supporting queries including:

* Overall customer summary
* Response rate by education
* Response rate by country
* Response rate by spending group
* Response rate by total purchase group

---

## 📈 Key Findings

### Campaign Response

The dataset contains:

* **56,000 customers**
* **8,265 responders**
* Overall response rate of approximately **14.76%**

### 👵 Age

The 60+ age group had the highest response rate:

**17.65%**

Response rate increased across the age groups analyzed.

### 💰 Income

The Very High Income group had the highest response rate:

**25.36%**

It also had average spending of approximately:

**1,141.32**

### 👨‍👩‍👧 Family Composition

Customers with **no children** had the highest response rate:

**21.51%**

They also had the highest average income and average spending among the family groups analyzed.

### 🛍️ High-Value Customers

Among high-value customers, based on the top 25% spending threshold:

* Average web purchases: **5.19**
* Average store purchases: **5.93**
* Average catalog purchases: **3.03**
* Average deal purchases: **2.05**
* Average website visits: **4.30 per month**

Store purchasing was the most frequently used purchase channel.

### 🎯 Under-served Customers

An under-served segment of **22,121 customers** was identified based on:

* Low spending
* High website visits
* No campaign response

This segment averaged approximately:

* **182.65** total spending
* **6.91** website visits per month

This represents a potential opportunity for targeted offers and personalized campaigns.

---

## 🎯 Ideal Target Customer

Based on the analysis, stronger campaign targets tend to have:

* Higher income
* Higher spending
* Older age, particularly 60+
* No children
* Strong purchasing behavior
* Higher likelihood of campaign response

The analysis suggests that customer targeting should focus on behavioral and demographic characteristics rather than using the same campaign strategy for all customers.

---

## 💡 Business Recommendations

1. Prioritize high-income and high-spending customers for targeted campaigns.
2. Develop personalized offers for customers who frequently visit the website but have low spending.
3. Focus on customers with characteristics associated with higher campaign response.
4. Use customer segmentation to create more personalized marketing campaigns.
5. Monitor campaign response by age, income, family composition, country, and purchasing behavior.
6. Use purchase-channel behavior to select the most effective communication strategy.

---

## 📊 Power BI Dashboard

The Power BI dashboard provides an interactive view of:

* Customer metrics
* Campaign response
* Customer segments
* Spending behavior
* Purchase behavior
* Demographics
* Campaign performance

The completed dashboard is available in:

`powerbi/Marketing_Campaign_Analysis.pbix`

---

## 🚀 Project Outcome

This project demonstrates an end-to-end data analytics workflow using **Python, SQL, and Power BI**.

The analysis converts raw customer marketing data into meaningful customer segments, campaign insights, and actionable recommendations for future marketing decisions.
