# J.Alam Clothing Business — Oracle SQL Database

A fully normalized relational database for **J.Alam**, a home-based 
Pakistani clothing reseller operating through Facebook Live sessions. 
Designed and implemented as part of the MGT387 Lab Final project at 
COMSATS University Islamabad.

---

## 👤 Author

| Detail | Info |
|--------|------|
| Name | Usaid Latif |
| Registration No | SP25-BBD-151 |
| Program | BS Business Data Analytics |
| Institution | COMSATS University Islamabad |
| Course | MGT387 — Databases for Business Analytics |
| Instructor | Syeda Asmara Nisar |
| Submission Date | May 18, 2026 |

---

## 🏪 Business Context

J.Alam sources branded Pakistani clothing from four suppliers — 
Sapphire, Khaadi, Generation, and Ethnic by Outfitters — during 
discounted clearance cycles. Inventory is stored at home and sold to 
customers via Facebook Live sessions at approximately 20% below 
standard retail prices. Orders are fulfilled through TCS courier 
(Cash-on-Delivery) or Advance/Cash payment. The database replaces 
manual paper-slip record-keeping with a fully digitized relational 
architecture.

---

## 🗃️ Database Structure

### Summary

| Metric | Count |
|--------|-------|
| Total Tables | 12 |
| Total Constraints | 44 |
| Suppliers | 4 |
| Products | 22 |
| Customers | 20 |
| Orders | 30 |
| Deliveries | 21 |
| Payments | 30 |
| Defects | 5 |
| Refunds | 5 |

### Tables

| # | Table | Entity Type | Description |
|---|-------|-------------|-------------|
| 1 | Supplier | Strong Entity | 4 clothing brand suppliers |
| 2 | Customer | Strong Entity | 20 customers across 5 cities |
| 3 | Product | Strong Entity | 22 products from 4 brands |
| 4 | ProductStitched | Derived — 3NF Fix | Stitched product sizes |
| 5 | ProductUnstitched | Derived — 3NF Fix | Unstitched piece counts |
| 6 | PaymentMethodDetail | Derived — 3NF Fix | Payment method to account mapping |
| 7 | JOrder | Strong Entity | 30 customer orders |
| 8 | OrderProduct | Associative Entity | Order line items with quantities |
| 9 | Delivery | Weak Entity | 21 TCS courier deliveries |
| 10 | Payment | Weak Entity | 30 payment records |
| 11 | Defect | Weak Entity | 5 product defect complaints |
| 12 | Refund | Weak Entity | 5 refund records |

---

## 🔧 Normalization — 3NF

Three tables required normalization. Six were already in 3NF.

### Tables Already in 3NF
Supplier, Customer, Order, OrderProduct, Delivery, Defect

### Tables Fixed

**Product → 3NF Violation**
StitchedSize and UnstitchedPieces were transitively dependent on 
ClothingType, not directly on ProductID.
Fix: Created ProductStitched and ProductUnstitched tables.

**Payment → 3NF Violation (Two fixes)**
1. AccountUsed depended on PaymentMethod, not PaymentID.
Fix: Created PaymentMethodDetail lookup table. AccountUsed removed 
from Payment.
2. CustomerID was transitively dependent via PaymentID → OrderID → 
CustomerID. Fix: CustomerID removed from Payment. Retrieved via JOIN 
with JOrder.

**Refund → 3NF Violation**
RefundAccount was transitively dependent via PaymentID → PaymentMethod 
→ AccountUsed. Fix: RefundAccount removed. Retrieved via JOIN with 
PaymentMethodDetail.

### New Tables Created: 3
ProductStitched, ProductUnstitched, PaymentMethodDetail

### Total Tables in Final Database: 12

---

## 📊 Data Warehouse Schemas

### Star Schema
Centralized FACT_SALES table surrounded by flat, denormalized dimension 
tables. Optimized for fast analytical queries and sales dashboards.

### Snowflake Schema
Normalized dimension hierarchies with sub-dimension tables such as 
ProductStitched, ProductUnstitched, and PaymentMethodDetail branching 
off main dimension tables. Reduces storage redundancy at the cost of 
more complex joins.

---

## ▶️ How to Run

1. Open **Oracle SQL Developer**
2. Connect to your database
3. Open `J-Alam-Database-SQL.sql`
4. Press **F5** to execute the full script
5. All 12 tables with complete data will be created automatically

> Tables must run in order due to Foreign Key dependencies.
> The correct sequence is documented at the top of the SQL file.

### Table Run Order
1. Supplier
2. Customer
3. Product
4. ProductStitched
5. ProductUnstitched
6. PaymentMethodDetail
7. JOrder
8. OrderProduct
9. Delivery
10. Payment
11. ALTER TABLE Payment (DeliveryID FK)
12. Defect
13. Refund

---

## 📁 Repository Files

| File | Description |
|------|-------------|
| `J-Alam-Database-SQL.sql` | Complete Oracle SQL script — all 12 tables, INSERT statements, verification queries, and JOIN queries |
| `J-Alam-Database-Report.pdf` | Full project report — ERD, normalization (1NF–3NF), relational schema, Star and Snowflake schemas, SQL code screenshots |

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Oracle SQL Developer | Database creation and execution |
| Oracle Database 21c | Database engine |
| Microsoft Word | Report writing |
| Adobe PDF | Report submission format |
