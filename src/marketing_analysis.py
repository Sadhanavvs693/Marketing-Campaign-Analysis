# %%
import pandas as pd
import numpy as np

# %%
df = pd.read_csv("../data/marketing_campaign_data.csv")

print(df.shape)

# %%
df.head()

# %%
df.info()

# %%
df.isnull().sum()

# %%
df.isnull().sum().sum()

# %%
df.duplicated().sum()

# %%
df["ID"].duplicated().sum()

# %%
df.describe().T

# %%
print("Year of Birth:")
print(df["Year_Birth"].min(), df["Year_Birth"].max())

print("\nIncome:")
print(df["Income"].min(), df["Income"].max())

print("\nRecency:")
print(df["Recency"].min(), df["Recency"].max())

print("\nWebsite Visits:")
print(df["NumWebVisitsMonth"].min(), df["NumWebVisitsMonth"].max())

# %%
df["Income"].describe()

# %%
df["Income"].quantile([0.90, 0.95, 0.99])

# %%
df[df["Income"] > 150000][["ID", "Income"]].sort_values(
    "Income",
    ascending=False
).head(20)

# %%
income_outliers = df[df["Income"] > 113819.375]

print("Number of income outliers:", len(income_outliers))
print("Percentage of income outliers:",
      round(len(income_outliers) / len(df) * 100, 2), "%")

# %%
income_outliers["Income"].describe()

# %%
df[df["Income"] > 150000][["Income"]].describe()

# %%
df["Year_Birth"].describe()

# %%
df["Year_Birth"].sort_values().head(20)

# %%
print("Records with Year_Birth < 1940:",
      (df["Year_Birth"] < 1940).sum())

# %%
missing_values = df.isnull().sum()

print(missing_values[missing_values > 0])

# %%
print("Duplicate rows:", df.duplicated().sum())

# %%
print(df["Education"].value_counts())
print("\nMarital Status:")
print(df["Marital_Status"].value_counts())
print("\nCountry:")
print(df["Country"].value_counts())

# %%
df[df["Marital_Status"].isin(["Alone", "Absurd", "YOLO"])][
    ["Marital_Status", "Education", "Income", "Kidhome", "Teenhome"]
].head(20)

# %%
df[df["Marital_Status"].isin(["Alone", "Absurd", "YOLO"])]["Marital_Status"].value_counts()

# %%
df["Marital_Status"] = df["Marital_Status"].replace(
    {
        "Alone": "Other",
        "Absurd": "Other",
        "YOLO": "Other"
    }
)

print(df["Marital_Status"].value_counts())

# %%
df[["Kidhome", "Teenhome", "Recency",
    "NumDealsPurchases", "NumWebPurchases",
    "NumCatalogPurchases", "NumStorePurchases",
    "NumWebVisitsMonth"]].describe()

# %%
print(df["Response"].value_counts())
print("\nResponse percentage:")
print(df["Response"].value_counts(normalize=True) * 100)

# %%
df["Age"] = 2014 - df["Year_Birth"]

print(df["Age"].describe())

# %%
df["TotalSpending"] = (
    df["MntWines"]
    + df["MntFruits"]
    + df["MntMeatProducts"]
    + df["MntFishProducts"]
    + df["MntSweetProducts"]
    + df["MntGoldProds"]
)

print(df["TotalSpending"].describe())

# %%
df["TotalPurchases"] = (
    df["NumWebPurchases"]
    + df["NumCatalogPurchases"]
    + df["NumStorePurchases"]
    + df["NumDealsPurchases"]
)

print(df["TotalPurchases"].describe())

# %%
df["TotalChildren"] = df["Kidhome"] + df["Teenhome"]

print(df["TotalChildren"].describe())
print("\nValue counts:")
print(df["TotalChildren"].value_counts().sort_index())

# %%
df["TotalCampaignAccepted"] = (
    df["AcceptedCmp1"]
    + df["AcceptedCmp2"]
    + df["AcceptedCmp3"]
    + df["AcceptedCmp4"]
    + df["AcceptedCmp5"]
)

print(df["TotalCampaignAccepted"].describe())
print("\nValue counts:")
print(df["TotalCampaignAccepted"].value_counts().sort_index())

# %%
df["WebPurchaseRate"] = (
    df["NumWebPurchases"] /
    (df["NumWebVisitsMonth"] + 1)
)

print(df["WebPurchaseRate"].describe())

# %%
income_response = df.groupby("Response")["Income"].mean()

print(income_response)

# %%
spending_response = df.groupby("Response")["TotalSpending"].mean()

print(spending_response)

# %%
campaign_response = df.groupby("Response")["TotalCampaignAccepted"].mean()

print(campaign_response)

# %%
age_response = df.groupby("Response")["Age"].mean()

print(age_response)

# %%
education_response = (
    df.groupby("Education")["Response"]
    .mean()
    .sort_values(ascending=False) * 100
)

print(education_response)

# %%
country_response = (
    df.groupby("Country")["Response"]
    .mean()
    .sort_values(ascending=False) * 100
)

print(country_response)

# %%
spending_education = (
    df.groupby("Education")["TotalSpending"]
    .mean()
    .sort_values(ascending=False)
)

print(spending_education)

# %%
numeric_cols = [
    "Income",
    "Age",
    "TotalSpending",
    "TotalPurchases",
    "TotalChildren",
    "TotalCampaignAccepted",
    "WebPurchaseRate",
    "Response"
]

correlation = df[numeric_cols].corr()["Response"].sort_values(ascending=False)

print(correlation)

# %%
from scipy.stats import ttest_ind

income_0 = df[df["Response"] == 0]["Income"]
income_1 = df[df["Response"] == 1]["Income"]

t_stat, p_value = ttest_ind(income_0, income_1, equal_var=False)

print("Income T-statistic:", t_stat)
print("Income P-value:", p_value)

# %%
spending_0 = df[df["Response"] == 0]["TotalSpending"]
spending_1 = df[df["Response"] == 1]["TotalSpending"]

t_stat, p_value = ttest_ind(
    spending_0,
    spending_1,
    equal_var=False
)

print("Spending T-statistic:", t_stat)
print("Spending P-value:", p_value)

# %%
import matplotlib.pyplot as plt

response_counts = df["Response"].value_counts()

plt.figure(figsize=(6, 4))
response_counts.plot(kind="bar")

plt.title("Campaign Response Distribution")
plt.xlabel("Response")
plt.ylabel("Number of Customers")
plt.xticks(rotation=0)

plt.show()

# %%
import matplotlib.pyplot as plt

plt.figure(figsize=(7, 5))

df.boxplot(
    column="Income",
    by="Response"
)

plt.title("Income Distribution by Campaign Response")
plt.suptitle("")
plt.xlabel("Response")
plt.ylabel("Income")

plt.show()

# %%
import matplotlib.pyplot as plt

plt.figure(figsize=(7, 5))

df.boxplot(
    column="TotalSpending",
    by="Response"
)

plt.title("Total Spending Distribution by Campaign Response")
plt.suptitle("")
plt.xlabel("Response")
plt.ylabel("Total Spending")

plt.show()

# %%
country_response = (
    df.groupby("Country")["Response"]
    .mean()
    .sort_values(ascending=False) * 100
)

plt.figure(figsize=(9, 5))

country_response.plot(kind="bar")

plt.title("Campaign Response Rate by Country")
plt.xlabel("Country")
plt.ylabel("Response Rate (%)")
plt.xticks(rotation=45)

plt.show()

# %%
import matplotlib.pyplot as plt

education_response = (
    df.groupby("Education")["Response"]
    .mean()
    .sort_values(ascending=False) * 100
)

plt.figure(figsize=(8, 5))

education_response.plot(kind="bar")

plt.title("Campaign Response Rate by Education")
plt.xlabel("Education")
plt.ylabel("Response Rate (%)")
plt.xticks(rotation=0)

plt.show()

# %%
%pip install scikit-learn

# %%
from sklearn.model_selection import train_test_split

# Features and target
X = df[['Income', 'TotalSpending', 'TotalPurchases']]
y = df['Response']

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.20,
    random_state=42,
    stratify=y
)

print("Training rows:", X_train.shape[0])
print("Testing rows:", X_test.shape[0])

# %%
from sklearn.linear_model import LogisticRegression

# Create the model
model = LogisticRegression(max_iter=1000)

# Train the model
model.fit(X_train, y_train)

print("Logistic Regression model trained successfully!")

# %%
# Make predictions on the test data
y_pred = model.predict(X_test)

print("Predictions completed!")
print("First 10 predictions:", y_pred[:10])

# %%
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score, confusion_matrix

# Calculate evaluation metrics
accuracy = accuracy_score(y_test, y_pred)
precision = precision_score(y_test, y_pred)
recall = recall_score(y_test, y_pred)
f1 = f1_score(y_test, y_pred)

print("Accuracy :", accuracy)
print("Precision:", precision)
print("Recall   :", recall)
print("F1 Score :", f1)

print("\nConfusion Matrix:")
print(confusion_matrix(y_test, y_pred))

# %%
import pandas as pd

# %%
df = pd.read_csv("customer_campaign_cleaned.csv")

# %%
print(df.shape)
print(df.columns.tolist())

# %%
df['Income_Group'] = pd.cut(
    df['Income'],
    bins=[0, 30000, 60000, 100000, float('inf')],
    labels=['Low Income', 'Middle Income', 'High Income', 'Very High Income']
)

print(df['Income_Group'].value_counts())

# %%
income_response = (
    df.groupby('Income_Group', observed=False)['Response']
      .agg(['count', 'sum'])
      .reset_index()
)

income_response['Response_Rate'] = (
    income_response['sum'] / income_response['count'] * 100
)

print(income_response)

# %%
df['Spending_Group'] = pd.cut(
    df['TotalSpending'],
    bins=[-1, 250, 750, 1500, float('inf')],
    labels=['Low Spending', 'Medium Spending', 'High Spending', 'Very High Spending']
)

print(df['Spending_Group'].value_counts())

# %%
spending_response = (
    df.groupby('Spending_Group', observed=False)['Response']
      .agg(['count', 'sum'])
      .reset_index()
)

spending_response['Response_Rate'] = (
    spending_response['sum'] / spending_response['count'] * 100
)

print(spending_response)


