# Customer Churn Prioritization: Revenue Risk & Retention Focus

## 📌 Project Overview
Customer churn is often treated as a volume problem, but in reality, **not all churn impacts the business equally**.  
This project focuses on identifying **where churn creates the highest revenue risk** and prioritising retention efforts using a **Recency × Value framework**.

Using a large transactional dataset, I built an **end-to-end churn prioritisation system** that helps businesses focus retention resources on customers who matter most financially and are most likely to be recovered.

---

## 🎯 Business Problem
The business observed a high level of customer churn but lacked clarity on:
- Which churned customers actually pose a **significant revenue risk**
- Whether retention efforts should target **all churned customers** or a **prioritised subset**

**Key question:**
> *Where should the business focus first to reduce revenue loss from churn?*

---

## 📊 Dataset
- ~17,000+ transaction records  
- ~5,000 unique customers  
- Time period: **Jan 2023 – Mar 2024**
- Granularity: **Transaction-level data**

*(Raw data is not shared publicly.)*

---

## 🛠️ Tools & Technologies
- **SQL** – Data cleaning, aggregation, churn logic, segmentation  
- **Excel** – Exploratory analysis and statistical validation  
- **Power BI** – Decision-focused dashboard and storytelling  

---

## 📐 Methodology

### 1️⃣ Churn Definition
A customer is considered **churned** if they have not made a purchase within **60 days** prior to the dataset end date.

This threshold was chosen based on:
- Average customer return cycle (~55 days)
- Balancing false positives vs delayed churn detection

---

### 2️⃣ Statistical Analysis
Revenue distribution analysis revealed:
- High **standard deviation**
- Strong **right skewness**

This indicated that:
> A small subset of customers drives a disproportionate share of revenue.

As a result, **average-based analysis was insufficient**, and percentile-based segmentation was required.

---

### 3️⃣ Value Segmentation (Impact)
Customers were segmented using revenue percentiles:
- **Platinum**: Top 5% customers
- **Gold**: 5–10%
- **Silver**: 10–20%
- **Bronze**: Remaining customers

This identifies **financial impact**.

---

### 4️⃣ Recency Segmentation (Recoverability)
Churned customers were further grouped by **days since last purchase**:
- **Recent churn (A)**: 60–120 days
- **Mid churn (B)**: 121–240 days
- **Old churn (C)**: >240 days

This captures **likelihood of recovery**.

---

### 5️⃣ Priority Matrix (Core Contribution)
By combining **Value × Recency**, a **Priority Matrix** was created to rank churned customers by:
- Revenue impact
- Probability of recovery

This resulted in clear **Action Priorities** (Priority 1 → Low Priority), enabling cost-efficient retention decisions.

---

## 🔍 Key Insights
- ~64% of customers churned, indicating a **high churn volume**
- Churn impact is **not evenly distributed**
- Top **20% of churned customers account for ~60% of churned revenue**
- A very small group of **recently churned, high-value customers** represents the **highest recoverable revenue risk**
- Low-priority churn includes many customers but offers **low ROI for retention spend**

---

## 📈 Dashboard
The Power BI dashboard is designed to support **decision-making**, not exploration.

It answers:
- Where is revenue at risk?
- Which customers should be contacted first?
- Why are these customers prioritised?
- Which churn segments can be safely deprioritised?

**Key visuals include:**
- KPI summary (Customers, Revenue, Revenue at Risk)
- Customer vs Revenue contrast by priority
- Recency × Value heatmap (hero visual)

---

## 🎯 Business Recommendations
- Focus retention efforts on **Priority 1 and Priority 2** customers
- Avoid blanket discounts for all churned customers
- Use automated, low-cost campaigns for low-priority churn
- Measure success using **Revenue at Risk reduction**, not churn rate alone

---

## 🚀 What I’d Do Next
If additional data or time were available:
- Root-cause analysis for high-priority churn (pricing, delivery, category)
- Cohort-based retention analysis
- A/B testing of retention strategies by priority tier
- ROI modelling of retention spend

---

## 📂 Repository Contents
