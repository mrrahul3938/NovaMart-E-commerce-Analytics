# NovaMart E-commerce Analytics

## 📊 Project Overview

**NovaMart E-commerce Analytics** is an end-to-end e-commerce data analytics project focused on **sales, profitability, customer behavior, product performance, and returns**.

The project follows a complete data analytics workflow:

**Excel Profiling → SQL Cleaning & Analysis → Power BI Modeling & DAX → Dashboard → Excel Validation → Power BI Service**

---

## 🎯 Business Problem

NovaMart has customer, product, order, and return data but needs a clear view of business performance.

The project helps answer questions such as:

* Who are the top customers?
* Which products generate the most revenue and profit?
* How does revenue change monthly?
* Where are customers concentrated?
* Which products have high return activity?
* How are products distributed by price?
* Where are data-quality issues present?

---

## 🗂️ Dataset

The final analytical model contains **5 tables**:

| Table             | Type      | Purpose                       |
| ----------------- | --------- | ----------------------------- |
| `customers_clean` | Dimension | Customer information          |
| `products_clean`  | Dimension | Product & pricing information |
| `orders_clean`    | Fact      | Sales transactions            |
| `returns_clean`   | Fact      | Return transactions           |
| `dim_date`        | Dimension | Date analysis                 |

---

## 🏗️ Data Model

A star-schema-oriented model was created in Power BI:

```text
                    dim_date
                   /        \
                  ▼          ▼
          orders_clean    returns_clean
             ▲    ▲          ▲    ▲
             │    │          │    │
             │    │          │    │
       customers_clean   products_clean
```

Relationships, cardinality, cross-filter direction, date-table configuration, and model organization were validated in Power BI.

---

## 🧹 Data Cleaning & Analysis

### Excel — Data Profiling

The project started with Excel-based profiling to identify:

* Missing values
* Duplicates
* Data distributions
* Invalid values
* Data-quality issues

### SQL Server — Cleaning

SQL Server was then used to clean and prepare the data.

Key cleaning activities included:

* Duplicate removal
* Missing-value analysis
* Pricing validation
* Data consistency checks

**Results:**

* 150 exact duplicate customer records removed
* 50,000 unique customers retained
* 30 invalid product pricing records identified and handled

### SQL — Business Analysis

Business analysis included:

* Top 10 customers
* Top products by revenue and profit
* Monthly revenue
* Customer distribution by city and region
* Customer signup-year analysis
* Product ranking and pricing analysis
* Products above average price
* Most expensive and cheapest products
* Product return analysis
* Missing customer city and product price analysis
* Product price categorization

---

## 📊 Power BI Dashboard

A **4-page interactive Power BI dashboard** was created.

### 1. Executive Overview

High-level KPIs and overall business performance.

### 2. Product & Profitability

Product revenue, profit, rankings, pricing, and performance.

### 3. Customer Intelligence

Customer performance, distribution, geography, and trends.

### 4. Returns & Operations

Product returns and operational analysis.

---

## 🧮 DAX

DAX was used to create dynamic KPIs and analytical measures for:

* Revenue
* Profit
* Customers
* Orders
* Product analysis
* Rankings
* Time-based analysis
* Return analysis

Key functions/concepts included `SUM`, `SUMX`, `CALCULATE`, `FILTER`, and `AVERAGEX`.

---

## ✅ Validation & Deployment

After dashboard development:

* Created **Customer Pivot** in Excel
* Created **Return Pivot** in Excel
* Performed data validation and cross-checking
* Published the final dashboard to **Power BI Service**

This ensured the final dashboard was both analytically reliable and deployment-ready.

---

## 💡 Key Insights

The project provides visibility into:

* High-value customers
* Top revenue and profit-generating products
* Monthly revenue trends
* Customer concentration by geography
* Product pricing patterns
* Product return activity
* Important data-quality issues

These insights can support decisions related to **customer retention, product profitability, pricing, geographic targeting, and return reduction**.

---

## 🛠️ Tools & Technologies

**Excel | SQL Server | SQL | Power BI | DAX | Power Query | Power BI Service | GitHub**

---

## 📂 Repository Structure

```text
NovaMart-Ecommerce-Analytics/
│
├── README.md
├── data/
│
├── sql/
│   ├── data_cleaning.sql
│   └── business_analysis.sql
│
├── powerbi/
│   └── NovaMart_Analytics.pbix
│
├── screenshots/
│
└── documentation/
```

---

## 👤 Author

**Rahul Prajapati**
BCA Graduate | Aspiring Data Analyst

**Skills:** SQL • Power BI • DAX • Advanced Excel • Data Analysis
