# dbt Analytics Engineering Mini Projects

This repository contains hands-on analytics engineering exercises completed as part of the **neuefische Data Analytics & AI Bootcamp**.

The work was created while learning **dbt (data build tool)** and focuses on using SQL and dbt to transform source data into structured, analytics-ready data models.

The repository includes two main mini projects:

1. **Northwind Sales Analytics**
2. **FAA Flight & Meteostat Weather Analytics**

---

## Learning Objectives

The exercises provided practical experience with:

- SQL-based data transformation
- dbt project structure and model organization
- Staging, preparation, and mart layers
- Modular SQL models using `ref()`
- Data aggregation and business metrics
- Joining multiple data sources
- Data quality testing
- Building analytics-ready datasets

---

## Project 1: Northwind Sales Analytics

### Business Context

Northwind Traders' sales and operational data is stored in a normalized transactional database.

While this structure works well for operational processes, analytical questions often require multiple joins and additional calculations.

The goal of this exercise was to use dbt to transform the source data into a cleaner, analytics-ready structure for sales analysis.

### Data Modeling Approach

The transformation follows a layered approach:

**Staging Layer**

- Light cleaning and renaming of source data
- Conversion to consistent `snake_case` naming
- Data type corrections
- Removal of unnecessary columns

**Preparation Layer**

- Joining orders, order details, and product information
- Creating additional analytical fields
- Calculating revenue:

`revenue = unit_price × quantity × (1 − discount)`

- Creating time dimensions such as order year and month

**Mart Layer**

The final sales mart aggregates business metrics including:

- Total revenue
- Total orders
- Average revenue per order

These metrics can be analyzed by dimensions such as:

- Year
- Month
- Product category

### Example Analytical Questions

The resulting models can support questions such as:

- Which products and categories generate the most revenue?
- Which customers and countries contribute most to sales?
- How do discounts affect net revenue?
- Are there seasonal patterns in sales?

### Testing

dbt tests were used to check data quality, including tests for non-null values.

---

## Project 2: FAA Flight & Meteostat Weather Analytics

The second exercise combines operational flight data with weather information to create analytical marts at different levels of aggregation.

### FAA Airport Statistics

Airport-level flight statistics include metrics such as:

- Planned flights
- Completed flights
- Cancelled flights
- Diverted flights
- Number of flight connections
- Number of airlines
- Number of aircraft

### Route Statistics

Flight data is also aggregated at route level.

The resulting model includes metrics such as:

- Number of flights
- Average flight duration
- Arrival delays
- Cancellations
- Diversions

Airport metadata is joined to the route information to provide additional context.

### Weekly Weather Statistics

Daily Meteostat weather observations are aggregated into weekly airport-level weather metrics, including:

- Temperature
- Precipitation
- Snow
- Wind
- Air pressure
- Sunshine duration

### Combining Flight and Weather Data

A further dbt model combines flight operations with weather observations at the airport and daily level.

This creates an analytics-ready dataset containing operational flight metrics together with weather variables such as:

- Temperature
- Precipitation
- Snow
- Wind

The resulting structure can be used to explore relationships between weather conditions and flight operations.

---

## Repository Structure

```text
analyses/       dbt analyses
macros/         reusable dbt macros
models/         SQL transformation models
  example/      dbt example models
  marts/        FAA and Meteostat analytical marts
  northwind/    Northwind staging, preparation, and mart models
seeds/          dbt seed files
snapshots/      dbt snapshots
tests/          dbt tests
dbt_project.yml dbt project configuration

