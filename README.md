# Case Study: Data Transformation for an Ecommerce Analytics Platform


An ecommerce company connects small businesses to various channels effortlessly through
a single contract. Merchants can sell their products via this ecommerce platform and use the
company's logistics partners for direct shipping to customers. After a customer purchases a
product, the seller is notified to fulfill the order. Upon product delivery or the estimated
delivery date, the customer receives a satisfaction survey by email to rate their purchase
experience and provide comments. The company aims to build an analytical platform to
enhance their customer service using data.

# Data Overview
The dataset contains information on 100k orders from 2016 to 2018, allowing orders to be
viewed from multiple dimensions: order status, price, payment, freight performance,
customer location, product attributes, and customer reviews. You can the ERD file attached
with this assessment to understand the relationship between the datasets. Note that:
● An order might have multiple items.
● Each item may be fulfilled by a different seller.

# Task
## 1. DBT Project Setup
● Set up a new dbt project and connect it to GitHub.
● Configure the project to connect to a sample data warehouse (use a free Google
Console account or any data warehouse of your choice).

## 2. Model Development
● A BI analyst has been tasked with creating a customer dashboard to detail buying
patterns, preferences, and customer behavior. As an Analytical Engineer, develop
data models to support the BI analyst.
3. Write a SQL query to generate the following fields FOR EACH CUSTOMER
1. Customer ID
2. City
3. Average order value
4. Total spend per customer
5. Total number of orders
6. Day of the week with the highest purchase
7. Order value for the third order. For customers with no third order, it should be
replaced with "0".
