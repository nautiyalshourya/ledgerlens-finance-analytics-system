--CREATE TABLE CUSTOMERS, INVOICES, PAYMENTS--

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    industry VARCHAR(50),
    region VARCHAR(30),
    city VARCHAR(50),
    credit_limit NUMERIC(15,2),
    sales_manager VARCHAR(50),
    customer_segment VARCHAR(30),
    risk_base_score INTEGER,
    customer_credit_rating VARCHAR(2),
    customer_status VARCHAR(20)
);

CREATE TABLE invoices (
    invoice_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    invoice_date DATE,
    payment_terms_days INTEGER,
    due_date DATE,
    invoice_amount NUMERIC(15,2),
    tax_amount NUMERIC(15,2),
    total_amount NUMERIC(15,2),
    product_category VARCHAR(50),
    sales_channel VARCHAR(30),
    payment_status VARCHAR(20),
    outstanding_amount NUMERIC(15,2),
    days_overdue INTEGER,
    aging_bucket VARCHAR(20),
    collection_status VARCHAR(30),
    customer_risk_score INTEGER,
    collection_agent VARCHAR(50),
    dispute_flag VARCHAR(10),
    promise_to_pay_date DATE,
    invoice_month VARCHAR(20),
    invoice_year INTEGER,
    quarter VARCHAR(5),
    invoice_priority VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    invoice_id VARCHAR(20),
    payment_date DATE,
    amount_paid NUMERIC(15,2),
    payment_method VARCHAR(30),
    delay_days INTEGER,
    write_off_flag VARCHAR(10),
    FOREIGN KEY (invoice_id)
        REFERENCES invoices(invoice_id)
);

--RECHECK IF THE TABLES ARE CREATED OR NOT--

SELECT * FROM customers;

SELECT * FROM invoices;

SELECT * FROM payments;

--CHECK IF THE DATA IS ACTUALLY CORRECT--

SELECT *
FROM customers
LIMIT 10;

SELECT *
FROM invoices
LIMIT 5;

SELECT *
FROM payments
LIMIT 5;

