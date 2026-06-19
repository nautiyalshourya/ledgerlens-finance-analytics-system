# LedgerLens – Accounts Receivable & Credit Risk Analytics System

## Overview

LedgerLens is a Finance Analytics project designed to simulate how corporate finance teams monitor Accounts Receivable (AR), manage credit risk, analyze customer payment behavior, and support working capital decision-making.

Using SQL and Power BI, the project transforms raw invoice, customer, and payment data into actionable financial insights through structured analysis and executive reporting.

The project follows a real-world finance analytics workflow:

Data Validation → KPI Reporting → Aging Analysis → Customer Analysis → Credit Risk Assessment → Collection Operations → Strategic Decision Support

---

## Business Problem

Organizations often struggle with:

* Rising outstanding receivables
* Delayed customer payments
* Poor cash flow visibility
* Increasing credit risk exposure
* Inefficient collection prioritization

LedgerLens was built to help finance teams answer critical questions about cash collection, customer risk, and working capital performance.

---

## Project Objectives

### Accounts Receivable Management

* Monitor outstanding balances
* Track unpaid invoices
* Measure collection performance
* Improve cash flow visibility

### Credit Risk Management

* Identify risky customers
* Analyze overdue exposure
* Evaluate effectiveness of credit policies

### Working Capital Analytics

* Assess liquidity risk
* Monitor aging trends
* Support collection prioritization

### Executive Reporting

* Deliver management-level KPIs
* Highlight key risk areas
* Enable data-driven decision making

---

## Technology Stack

### Data Analysis

* PostgreSQL

### Visualization

* Power BI

### Data Sources

* Invoice Data
* Customer Data
* Payment Data

---

## Project Structure

### 00. Database Validation

Purpose:
Ensure data quality before performing financial analysis.

Business Questions Answered:

* How many invoices exist in the system?
* How many customers exist?
* How many payment records exist?
* Are there duplicate invoices?
* Are there duplicate customers?
* Are customer IDs missing?
* Are invoice values valid?
* Are outstanding balances valid?
* Is payment status data consistent?
* Are aging buckets populated correctly?
* Can the data be trusted for analysis?

Key Outcome:
Validated data reliability before reporting to management.

---

### 01. Executive KPI Analysis

Purpose:
Provide CFO-level visibility into receivables performance.

Business Questions Answered:

* How much money is currently outstanding?
* How much revenue has been invoiced?
* How much has already been collected?
* How many invoices remain unpaid?
* What percentage of invoices are unpaid?
* What is the average invoice size?
* How many invoices are overdue?
* How much money is tied up in 90+ day invoices?
* What is the average payment delay?
* Is the AR position healthy?

Management Question:
Would a CFO be concerned about the current receivables position?

---

### 02. Aging Analysis

Purpose:
Evaluate collection risk through invoice aging.

Business Questions Answered:

* Which aging bucket contains the most invoices?
* Which aging bucket contains the most money?
* What percentage of AR is older than 60 days?
* What percentage is older than 90 days?
* Which invoices require immediate collection action?
* Are collection issues recent or long-standing?
* Is the aging profile healthy?

Management Question:
Which aging bucket deserves immediate attention?

---

### 03. Customer Analysis

Purpose:
Understand customer contribution and payment behavior.

Business Questions Answered:

* Which customers owe the most money?
* Who are the top 10 customers by outstanding AR?
* What percentage of AR comes from the top 10 customers?
* Which customers generate the highest revenue?
* Which customers pay the slowest?
* Which customers repeatedly delay payments?
* Which customers have the highest unpaid invoice counts?
* Are AR balances concentrated among a few customers?

Management Question:
Which customers represent the greatest risk to cash flow?

---

### 04. Credit Risk Analysis

Purpose:
Assess customer credit quality and risk exposure.

Business Questions Answered:

* Which credit rating contributes the most AR?
* Do low-rated customers pay slower?
* Which rating has the highest overdue days?
* How much AR belongs to risky customers?
* Are risk scores aligned with payment behavior?
* Are we extending excessive credit to risky customers?
* Should credit policies be reviewed?

Management Question:
Is credit risk being managed effectively?

---

### 05. Sales & Product Analysis

Purpose:
Identify products and sales channels driving AR risk.

Business Questions Answered:

* Which product category generates the most revenue?
* Which category creates the most AR?
* Which category has the highest delays?
* Which sales channel generates the most revenue?
* Which sales channel has the highest overdue AR?
* Are some products more prone to collection issues?

Management Question:
Which business areas are creating receivable challenges?

---

### 06. Region & Industry Analysis

Purpose:
Understand geographic and industry risk concentration.

Business Questions Answered:

* Which region generates the most AR?
* Which region has the highest delays?
* Which industry owes the most money?
* Which industry pays the slowest?
* Which region has the highest 90+ day exposure?
* Are collection issues concentrated geographically?

Management Question:
Where are AR problems most severe?

---

### 07. Collection Operations Analysis

Purpose:
Evaluate collection team effectiveness.

Business Questions Answered:

* Which agent manages the largest portfolio?
* Which agent handles the largest overdue exposure?
* Is workload distributed fairly?
* Which invoices require immediate follow-up?
* Which agents need support or rebalancing?

Management Question:
How should management optimize collection resources?

---

### 08. Trend Analysis

Purpose:
Track performance over time.

Business Questions Answered:

* Is invoice volume increasing or decreasing?
* Is outstanding AR growing or shrinking?
* Are collections improving?
* Is overdue AR increasing?
* Is payment behavior improving?
* Which months performed best?
* Which months performed worst?

Management Question:
Is the company moving in the right direction?

---

### 09. Advanced Business Analysis

Purpose:
Support strategic finance decision-making.

Key Analyses:

#### Pareto Analysis

* Do 20% of customers contribute 80% of AR?
* How concentrated is AR exposure?

#### Collection Priority Analysis

* Which 10 customers should collections contact first?

#### Revenue vs Risk Analysis

* Which customers are valuable but risky?
* Which customers require stricter credit controls?

#### Dispute Analysis

* How much AR is tied up in disputes?
* Are disputes delaying collections?

#### Payment Analysis

* Which payment methods produce faster collections?
* Which payment methods create delays?

Management Question:
What strategic actions should leadership prioritize?

---

## Power BI Dashboard

The final reporting layer consists of three interactive dashboards:

### Executive Summary Dashboard

Provides CFO-level visibility into:

* Outstanding Accounts Receivable
* Unpaid Invoices
* Overdue Exposure
* Average Payment Delay
* Working Capital Risk Indicators

### Risk Analysis Dashboard

Provides:

* Customer Risk Segmentation
* Credit Risk Monitoring
* Aging Distribution Analysis
* High-Risk Exposure Tracking

### Customer Analysis Dashboard

Provides:

* Top Customer Analysis
* Customer Payment Behavior
* Revenue vs Risk Evaluation
* Collection Prioritization

---

## Key Finance Concepts Applied

* Accounts Receivable Management
* Credit Risk Analysis
* Working Capital Analytics
* Invoice Aging Analysis
* Collection Effectiveness Monitoring
* Customer Risk Segmentation
* Cash Flow Visibility
* Executive Financial Reporting

---

## Key Learnings

Through this project, I developed practical experience in:

* Financial data analysis
* SQL-based business analytics
* KPI development and reporting
* Credit risk assessment
* Working capital monitoring
* Power BI dashboard design
* Business-focused data storytelling
* Executive decision-support reporting

---

## Real-World Relevance

This project simulates analytical work commonly performed by:

* Finance Analysts
* Accounts Receivable Analysts
* Credit Risk Analysts
* Collections Analysts
* Business Intelligence Analysts
* Corporate Finance Teams

---

## Conclusion

LedgerLens demonstrates how finance organizations can transform transactional invoice data into actionable insights that improve cash flow visibility, strengthen credit risk management, and support strategic financial decision-making.
