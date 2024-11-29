# Coffee Shop Sales Analysis

## 📖 Overview
This repository showcases SQL queries designed to analyze coffee shop sales data effectively. The queries provide actionable insights into monthly trends, product performance, time-based patterns, and store-level metrics. These insights empower businesses to make data-driven decisions.

This project was developed by **Oladipupo Oluwasegun**, leveraging expertise in **data analysis** and **business intelligence**.

---

## 🗂️ Table of Contents
- [Overview](#-overview)
- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Usage](#-usage)
- [Queries Included](#-queries-included)
- [Limitations](#-limitations)
- [About the Author](#-about-the-author)
- [License](#-license)

---

## ✨ Features
- **Monthly Sales Trends:** Identify revenue and order patterns for each month.
- **MoM Growth Analysis:** Analyze month-over-month growth or decline in sales, order counts, and quantities.
- **Product Insights:** Spot top-performing products and categories by sales volume.
- **Time-Based Patterns:** Uncover sales trends by day of the week and hour of the day.
- **Location Analysis:** Compare store sales performance across different locations.
- **Flexible Customization:** Adjust queries to explore specific periods or metrics.

---

## ⚙️ Prerequisites
Before running these queries, ensure your database contains a `coffee_shop_sales` table with the following columns:

- `transaction_id`: Unique identifier for transactions.
- `transaction_date`: Date of the transaction.
- `transaction_time`: Time of the transaction.
- `unit_price`: Price per unit sold.
- `transaction_qty`: Quantity sold in each transaction.
- `store_location`: Store where the transaction occurred.
- `product_category`: Category of the product.
- `product_type`: Type of the product.

👉 Ensure that `transaction_date` and `transaction_time` are correctly formatted as `DATE` and `TIME` data types, respectively.

---

## 🛠️ Usage
1. **Database Setup:**
   - Import the `coffee_shop_sales` dataset into your SQL database.

2. **Preprocessing:**
   - Run the provided preprocessing queries to format dates and times correctly.

3. **Run Analytical Queries:**
   - Execute the queries to extract insights on sales, orders, products, and time-based patterns.

4. **Customize:**
   - Adjust the `WHERE` clauses to focus on specific months, stores, or metrics.

---

## 📊 Queries Included
### 1. **Preprocessing Queries:**
   - Convert `transaction_date` to `DATE`.
   - Convert `transaction_time` to `TIME`.

### 2. **Sales Analysis:**
   - Monthly total sales.
   - Month-over-month (MoM) sales growth and decline.
   - Average monthly sales.

### 3. **Order Analysis:**
   - Total orders per month.
   - MoM changes in order counts.

### 4. **Product Analysis:**
   - Top-selling product categories.
   - Top 10 products by sales volume.

### 5. **Time-Based Analysis:**
   - Sales patterns by day of the week.
   - Weekday vs. weekend sales.
   - Hourly sales trends.

### 6. **Store-Level Analysis:**
   - Total sales per store location.

---

## 🧑‍💻 About the Author
Hello! I’m **Oladipupo Oluwasegun**, a skilled **Business Intelligence Analyst** with experience in data analysis, SQL, and delivering actionable insights. I specialize in building dynamic data pipelines and dashboards for business operations.

If you'd like to collaborate or have questions about this project, feel free to reach out!

- **Email:** [oluwasegunt48@gmail.com](mailto:oluwasegunt48@gmail.com)  
- **Phone:** +234 8163927330  

---

Happy analyzing! 😊
