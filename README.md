# Retail Sales Analysis Using MySQL

An end-to-end SQL analytics project exploring over 1 million retail transactions to identify sales trends, customer purchasing behavior, product performance, and actionable business insights.

## Project Overview

This project analyzes the Online Retail II dataset, a publicly available transactional dataset from a UK-based online retailer covering the period from January 2009 and December 2011. Using MySQL, the project follows a structured analytics workflow that includes data import, data auditing, data cleaning, exploratory data analysis (EDA), and SQL-based business analysis. The goal is to answer real-world business questions related to revenue trends, customer behavior, product performance, and geographic sales distribution while demonstrating practical SQL skills used in data analytics.

## Dataset Overview

The analysis is based on the **Online Retail II** dataset, which contains transactional records from a UK-based online retailer.

### Dataset Summary

| Metric | Value |
|---------|------:|
| Time Period | 12 January 2009 – 10 December 2011 |
| Total Transactions | 1,067,365 |
| Unique Customers | 5,942 |
| Countries Represented | 43 |
| Primary Market | United Kingdom |

The dataset includes invoice-level information such as product details, quantities purchased, transaction dates, customer IDs, unit prices, and country information.

## Tools & Technologies

| Category | Tool |
|----------|------|
| Database | MySQL |
| SQL Client | MySQL Workbench |
| Language | SQL |
| Version Control | Git & GitHub |
| Dataset | Online Retail II |

## Data Cleaning Process

Before performing the analysis, the dataset was audited and cleaned to improve data quality and ensure reliable results.

The following data preparation steps were completed:

- Imported and combined multiple yearly datasets into a single MySQL table.
- Converted raw invoice date values into a standardized datetime format using STR_TO_DATE().
- Identified and handled missing values in customer IDs and product descriptions.
- Excluded invalid records such as stock code B, empty descriptions, and non-product transactions (e.g., POSTAGE, DOTCOM POSTAGE, and Manual) where appropriate.
- Separated sales and returns by treating positive quantities as purchases and negative quantities as returned items.
- Used conditional aggregation (CASE WHEN) to calculate gross revenue, return value, and net revenue.
- Validated the cleaned dataset before performing business analysis.

## Business Questions

The analysis was conducted to answer the following business questions:

1. How did monthly gross revenue, return value, and net revenue change over time?
2. Which products generated the highest net revenue?
3. Which products sold the highest number of units?
4. Who are the top 10 customers by net spending?
5. Which countries generated the highest net revenue?
6. Which customers placed the highest number of orders?
7. Which customers have the highest average order value (minimum 10 orders)?
8. Which calendar months generated the highest average gross revenue, return value, and net revenue?

## Key Findings

The SQL analysis revealed several important business insights:

- Sales consistently increased during the second half of each year, with November recording the highest average net revenue across the three-year period.
- The United Kingdom was the retailer's primary market, generating the vast majority of total revenue compared to all other countries.
- A small number of products contributed a significant proportion of overall revenue, highlighting the importance of best-selling items.
- Customer spending was highly concentrated, with a relatively small group of customers accounting for the highest net sales.
- Customer purchasing behaviour varied considerably, with some customers placing a large number of orders while others generated exceptionally high average order values.
- Product returns had a measurable impact on revenue, making it important to evaluate both gross and net sales rather than revenue alone.

## How to Run the Project

1. Download the Online Retail II dataset.
2. Import the dataset into MySQL using MySQL Workbench.
3. Create the required database and import the cleaned transaction table.
4. Open the Retail_Sales_Analysis.sql file.
5. Execute each SQL query to reproduce the analysis and business insights presented in this project.

## Future Improvements

Potential enhancements for this project include:

- Develop an interactive Power BI dashboard to visualize key business insights.
- Perform customer segmentation using techniques such as RFM analysis.
- Create SQL views and stored procedures to simplify reporting.
- Automate the data import and cleaning process for future datasets.
- Expand the analysis with additional business KPIs and visualizations.
