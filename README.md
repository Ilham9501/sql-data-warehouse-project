# SQL Data Warehouse Project

Welcome to the **SQL Data Warehouse Project** repository!

This project demonstrates the development of a modern data warehouse and analytics solution using Microsoft SQL Server. It covers data ingestion, data cleaning, transformation, data modelling and analytical reporting.

The project is based on Baraa's data warehouse course and documents my practical learning and implementation of SQL and data engineering concepts.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Project Requirements](#project-requirements)
- [Data Architecture](#data-architecture)
- [Data Engineering](#data-engineering)
  - [Bronze Layer](#1-bronze-layer--raw-data-ingestion)
  - [Silver Layer](#2-silver-layer--data-cleaning-and-transformation)
  - [Gold Layer](#3-gold-layer--business-ready-data)
- [Data Analytics](#data-analytics)
- [Project Structure](#project-structure)
- [Tools and Documentation](#tools-and-documentation)
- [About Me](#about-me)
- [License](#license)

---

## Project Overview

The objective of this project is to build a modern data warehouse that consolidates data from CRM and ERP source systems into a structure suitable for analytical queries and business reporting.

The project follows the **Medallion Architecture**, which organises data into three layers:

- **Bronze:** Stores raw source data.
- **Silver:** Cleans, standardises and transforms the data.
- **Gold:** Organises data into business-ready models for analytics.

The project also includes SQL-based analysis of customer behaviour, product performance and sales trends.

## Project Requirements

### Data Engineering

**Objective:** Develop a modern data warehouse using SQL Server to consolidate sales data from CRM and ERP source systems.

**Specifications:**

- **Data Sources:** Import data from two source systems, CRM and ERP, provided as CSV files.
- **Data Quality:** Identify and resolve data quality issues before analysis.
- **Integration:** Combine data from both systems into a consistent data model.
- **Scope:** Focus on the latest dataset; historical data tracking is not required.
- **Documentation:** Document the architecture, data transformations and data model.

### Data Analytics

**Objective:** Develop SQL-based analysis to generate insights into:

- Customer behaviour
- Product performance
- Sales trends

These analyses aim to support business reporting and informed decision-making.

---

## Data Architecture

The project follows the Medallion Architecture.

### Bronze Layer — Raw Data

Stores data from the CRM and ERP source systems with minimal transformation.

### Silver Layer — Cleaned Data

Applies data-cleaning rules, standardisation and transformations to improve data quality and consistency.

### Gold Layer — Business-Ready Data

Organises validated data into analytical models, including fact and dimension tables, to support reporting and business analysis.

### Architecture Diagram

The data flow is:

**CRM and ERP Sources → Bronze → Silver → Gold**

The architecture diagram will be created using draw.io (diagrams.net).

- Editable diagram: `docs/data_architecture.drawio`
- Diagram image: `docs/data_architecture.png`

*These links will become available once the diagram has been created and committed to the repository.*

---

## Data Engineering

### 1. Bronze Layer — Raw Data Ingestion

The Bronze Layer is the first stage of the data warehouse pipeline. Its purpose is to load and store raw data from the CRM and ERP source systems before cleaning and transformation take place.

#### Tables

The Bronze Layer contains six source tables.

| Source System | Table |
|---|---|
| CRM | `bronze.crm_cust_info` |
| CRM | `bronze.crm_prd_info` |
| CRM | `bronze.crm_sales_details` |
| ERP | `bronze.erp_cust_az12` |
| ERP | `bronze.erp_loc_a101` |
| ERP | `bronze.erp_px_cat_g1v2` |

#### Key Activities

- Created Bronze Layer tables using SQL Server DDL scripts.
- Loaded CSV files from the CRM and ERP datasets using `BULK INSERT`.
- Used `TRUNCATE TABLE` before reloading data to refresh the tables.
- Developed the `bronze.load_bronze` stored procedure to automate loading across the six tables.
- Added execution-time messages to monitor individual loading steps and total batch duration.
- Implemented `TRY...CATCH` error handling in the loading process.

#### SQL Concepts Applied

- `CREATE TABLE` and SQL data type definitions.
- `BULK INSERT` for loading CSV data.
- `TRUNCATE TABLE` for refreshing staging tables.
- Stored procedures for automating data ingestion.
- `TRY...CATCH` for error handling.
- `PRINT` statements for execution progress and timing information.

#### Bronze Layer Scripts

- `scripts/bronze/ddl_bronze.sql` — defines the Bronze Layer tables.
- `scripts/bronze/load_bronze.sql` — implements the Bronze Layer loading procedure.

---

### 2. Silver Layer — Data Cleaning and Transformation

The Silver Layer transforms raw Bronze data into cleaner, standardised and more reliable data for downstream analysis.

#### Key Activities

- Created six Silver Layer tables for CRM and ERP data.
- Developed the `silver.load_silver` stored procedure.
- Removed leading and trailing whitespace from customer names.
- Standardised customer marital status, gender and country values.
- Cleaned customer and product identifiers.
- Handled missing and invalid values.
- Converted date values into appropriate data types.
- Applied business rules to validate sales amounts and prices.
- Used SQL window functions to support record ranking and product date transformations.
- Added execution-time logging and error handling to the loading procedure.

#### Tables

| Source System | Table |
|---|---|
| CRM | `silver.crm_cust_info` |
| CRM | `silver.crm_prd_info` |
| CRM | `silver.crm_sales_details` |
| ERP | `silver.erp_cust_az12` |
| ERP | `silver.erp_loc_a101` |
| ERP | `silver.erp_px_cat_g1v2` |

#### Key Transformations

**Customer data**
- Trimmed whitespace from customer names.
- Standardised marital status and gender values.
- Used `ROW_NUMBER()` to rank customer records by creation date and identify the latest record for each customer ID.

**Product data**
- Extracted and standardised product keys and category IDs.
- Replaced missing product costs with zero.
- Standardised product line values.
- Converted product start dates into the `DATE` data type.
- Used `LEAD()` to derive product end dates from subsequent start dates.

**Sales data**
- Converted integer date values into proper dates.
- Handled missing or invalid date values.
- Applied business rules to sales amounts and prices.
- Used `NULLIF()` to prevent division by zero.

**ERP data**
- Removed unwanted prefixes and hyphens from identifiers.
- Standardised country and gender values.
- Replaced future birth dates with `NULL`.
- Loaded product category, subcategory and maintenance information.

#### SQL Concepts Applied

- `CASE WHEN` for conditional transformations.
- `COALESCE()` for handling missing values.
- `NULLIF()` for avoiding division by zero.
- `ROW_NUMBER()` for ranking records and identifying potential duplicates.
- `LEAD()` for deriving product end dates.
- `CAST()` and `CONVERT()` for data type conversion.
- String functions for cleaning and standardising values.
- Stored procedures for automating data loading.
- `TRY...CATCH` for error handling.

#### Silver Layer Scripts

- `scripts/silver/ddl_silver.sql` — defines the Silver Layer tables.
- `scripts/silver/proc_load_silver.sql` — implements the Silver Layer loading procedure.

#### Data Quality

Data quality checks should validate key uniqueness, null values, date validity, standardised values and the consistency of sales amounts, quantities and prices.

---

### 3. Gold Layer — Business-Ready Data

The Gold Layer is the final data warehouse layer. Its purpose is to organise cleaned data into models that are easy to use for business intelligence and analytics.

The planned data model includes:

- `gold.dim_customers` — customer attributes for analysis.
- `gold.dim_products` — product attributes and categories.
- `gold.fact_sales` — sales transactions and measurable business metrics.

This layer will bring together the cleaned CRM and ERP data into a model designed for analytical queries.

*Update this section with the final table structures, relationships, business rules and validation results as the Gold Layer is completed.*

---

## Data Analytics

The analytics stage uses SQL queries to explore the data warehouse and generate business insights.

### Customer Behaviour

Explore customer demographics, customer distribution and purchasing behaviour.

### Product Performance

Analyse product performance, revenue contribution and top- and bottom-performing products.

### Sales Trends

Examine sales over time, cumulative revenue and changes in sales performance.

*Add links to completed analytical SQL scripts and key findings as the work progresses.*

---

## Project Structure

```text
sql-data-warehouse-project/
├── datasets/
│   ├── source_crm/
│   └── source_erp/
├── scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── load_bronze.sql
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   └── gold/
├── tests/
├── docs/
│   ├── data_architecture.drawio
│   └── data_architecture.png
└── README.md
```

*This is the intended structure. Update the filenames and folders to match the actual files in the repository.*

---

## Tools and Documentation

### Technologies

- **Microsoft SQL Server:** Database development, data storage and transformation.
- **T-SQL:** Data loading, cleaning, validation and analytical queries.
- **SQL Server stored procedures:** Automated data loading and transformation.
- **Git and GitHub:** Version control, script management and project documentation.

### Notion — Learning and Project Documentation

Notion will be used to document SQL concepts, transformation decisions, troubleshooting, lessons learned and progress through the project.

**Notion project notes:** [Add your Notion page link]

### draw.io — Data Warehouse Architecture

draw.io (diagrams.net) will be used to create an architecture diagram showing the CRM and ERP source systems and the flow of data through the Bronze, Silver and Gold Layers.

**Architecture diagram:** [Add your diagram link once available]

---

## About Me

I am working through Baraa's data warehouse project course to develop my practical skills in SQL, data engineering, data modelling and analytics. This repository documents my implementation, technical learning and progress as I build the data warehouse.

---

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify and share the project in accordance with the licence terms.
