# SQL Data Warehouse Project

Welcome to the **Data Warehouse Analytics Project** repository!

This project demonstrates the development of a modern data warehouse and analytics solution, from data ingestion and transformation to generating actionable business insights. It is designed as a portfolio project to demonstrate SQL development, data engineering, data modelling and data analytics skills while following industry best practices.

The project uses Microsoft SQL Server to consolidate data from CRM and ERP source systems, implement ETL processes, and prepare data for analytical reporting.

---

## Project Requirements

### 1. Building the Data Warehouse (Data Engineering)

**Objective**

Develop a modern data warehouse using SQL Server to consolidate sales data from CRM and ERP source systems, enabling analytical reporting and informed decision-making.

**Specifications**

- **Data Sources:** Import data from two source systems, CRM and ERP, provided as CSV files.
- **Data Quality:** Clean and resolve data quality issues before analysis.
- **Integration:** Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope:** Focus on the latest dataset only; historical data tracking is not required.
- **Documentation:** Document the data model to support business stakeholders and analytics teams.

### 2. BI: Analytics and Reporting (Data Analytics)

**Objective**

Develop SQL-based analytics to deliver insights into:

- Customer behaviour
- Product performance
- Sales trends

These insights support business reporting, performance monitoring and informed decision-making.

---

## Data Architecture

The project follows the **Medallion Architecture**, organising data processing into three layers.

**Bronze Layer — Raw Data**

Stores data from the CRM and ERP source systems with minimal transformation.

**Silver Layer — Cleaned and Standardised Data**

Cleans, standardises and transforms raw data to improve data quality and consistency.

**Gold Layer — Business-Ready Data**

Organises transformed data into analytical models, including dimension and fact tables, to support reporting and business analysis.

### Architecture Diagram

The architecture diagram will illustrate the flow of data from the source systems through the Bronze, Silver and Gold Layers.

**Diagram:** [View the data warehouse architecture](docs/data_architecture.png)

*The diagram will be added once created in draw.io.*

---

## Data Engineering

### Bronze Layer — Data Ingestion

The Bronze Layer stores raw data from the CRM and ERP source systems.

The loading process uses SQL Server and T-SQL to ingest source data into staging tables.

**Key activities:**
- Created Bronze Layer tables.
- Loaded CSV data using `BULK INSERT`.
- Implemented stored procedures to automate data loading.
- Preserved source data for subsequent transformation.

### Silver Layer — Data Cleaning and Transformation

The Silver Layer transforms raw Bronze data into clean, consistent and reliable data.

**Key activities:**
- Created six Silver Layer tables for CRM and ERP data.
- Developed the `silver.load_silver` stored procedure.
- Trimmed whitespace and standardised categorical values.
- Cleaned customer and product identifiers.
- Converted date values into appropriate data types.
- Applied business rules to validate sales amounts and prices.
- Used SQL window functions to support data transformation.

**Tables processed**

| Source System | Table |
|---|---|
| CRM | `silver.crm_cust_info` |
| CRM | `silver.crm_prd_info` |
| CRM | `silver.crm_sales_details` |
| ERP | `silver.erp_cust_az12` |
| ERP | `silver.erp_loc_a101` |
| ERP | `silver.erp_px_cat_g1v2` |

**SQL concepts applied**
- `CASE WHEN` for conditional transformations.
- `COALESCE()` and `NULLIF()` for handling missing values and preventing division by zero.
- `ROW_NUMBER()` for ranking records and identifying potential duplicates.
- `LEAD()` for deriving product end dates.
- `CAST()` and `CONVERT()` for data type conversion.
- String functions for cleaning and standardising identifiers.
- Stored procedures and `TRY...CATCH` for automated loading and error handling.

**Silver Layer scripts**
- `scripts/silver/ddl_silver.sql` — creates the Silver Layer tables.
- `scripts/silver/proc_load_silver.sql` — creates the Silver Layer loading procedure.

### Gold Layer — Data Modelling

The Gold Layer will organise validated data into business-ready models for analytical queries and reporting.

**Planned components:**
- Customer dimension (`gold.dim_customers`)
- Product dimension (`gold.dim_products`)
- Sales fact table (`gold.fact_sales`)

*Update this section as the Gold Layer is implemented and validated.*

---

## Data Analytics

The analytics stage will use SQL queries to explore the warehouse data and generate insights into:

### Customer Behaviour
Analyse customer demographics, customer distribution and purchasing behaviour.

### Product Performance
Evaluate product sales, revenue contribution and top- and bottom-performing products.

### Sales Trends
Examine sales over time, cumulative revenue and changes in business performance.

*Add links to the completed SQL scripts or analytical reports as each section is developed.*

---

## Project Structure

```text
sql-data-warehouse-project/
├── datasets/
├── scripts/
│   ├── bronze/
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   └── gold/
├── tests/
├── docs/
│   └── data_architecture.png
└── README.md
```

This structure illustrates the intended organisation of the project. Update it to reflect the files and folders actually present in the repository.

---

## Tools and Documentation

**Technologies**
- Microsoft SQL Server
- T-SQL
- SQL Server stored procedures
- Git and GitHub

**Documentation and visualisation**
- **Notion:** Project notes, SQL concepts, transformation decisions, troubleshooting and learning progress.
- **draw.io (diagrams.net):** Data warehouse architecture and data-flow diagrams.

**Project resources**
- Notion documentation: [Add your Notion page link]
- Editable draw.io diagram: [docs/data_architecture.drawio](docs/data_architecture.drawio)
- Architecture image: [docs/data_architecture.png](docs/data_architecture.png)

---

## About Me

I am working through Baraa's data warehouse project course to develop my practical skills in SQL, data engineering, data modelling and analytics. This repository documents my implementation, learning process and progress as I build the project.

---

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify and share this project in accordance with the licence terms.

