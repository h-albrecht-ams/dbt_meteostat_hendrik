# Northwind and Meteostat mini Project

## Northwind dbt Mini Project
- image of final table head:
![alt text](image.png)

### Business Problem
Northwind Traders' sales and operational data lives in a normalized
OLTP database — fine for transactions, but slow and awkward for
analytics. This project transforms the raw tables into a clean,
analytics-ready layer so the business can answer questions about
revenue, customers, and products without writing complex joins
against the source system every time.

### Models
**Staging layer** (1:1 with sources, light cleaning + renaming)
- rename columns to snake_case
- cast dates and numbers to correct datatypes
- drop irrelevant columns

**Prep layer**
- joining staging_orders, staging_order_details, and staging_products
- create new columns
  - revenue = unit_price * quantity * (1 - discount)
  - order_year, order_month

**Marts layer** (business logic, denormalized for analysis)
- Aggregate by
  - order_year
  - order_month
  - category_name
  - show
    - total revenue
    - total orders
    - avg revenue per order

### Insights for Northwind
With this mart, the business can quickly answer:
- Which products and categories drive the most revenue?
- Which customers and countries are top contributors?
- How do discounts affect net revenue per order?
- Which months / quarters show seasonal patterns in sales?

### Tests and Documentation
- several tests for non null values all passed

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
