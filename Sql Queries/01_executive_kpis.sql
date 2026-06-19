-- Total Outstanding AR
SELECT SUM(outstanding_amount) AS total_outstanding_ar
FROM invoices;

-- Total Invoice Value
SELECT SUM(total_amount) AS total_invoice_value
FROM invoices;

-- Total Collected Amount
SELECT SUM(amount_paid) AS total_collected
FROM payments;

-- Total unpaid invoices
SELECT COUNT(*) AS unpaid_invoices
FROM invoices
WHERE payment_status = 'Unpaid';

-- Total paid invoices
SELECT COUNT(*) AS paid_invoices
FROM invoices
WHERE payment_status = 'Paid';

-- Average invoice amount
SELECT ROUND(AVG(total_amount),2) AS avg_invoice_amount
FROM invoices;

-- Average outstanding amount
SELECT ROUND(AVG(outstanding_amount),2) AS avg_outstanding_amount
FROM invoices;

-- Total overdue invoices
SELECT COUNT(*) AS overdue_invoice_count
FROM invoices
WHERE days_overdue > 0;

-- 90+ day outstanding amount
SELECT SUM(outstanding_amount) AS overdue_90_plus_amount
FROM invoices
WHERE days_overdue > 90;

-- Percentage unpaid
SELECT
ROUND(
100.0 * SUM(CASE WHEN payment_status='Unpaid' THEN 1 ELSE 0 END)
/ COUNT(*),2) AS unpaid_percentage
FROM invoices;

-- Average days overdue
SELECT ROUND(AVG(days_overdue),2) AS avg_days_overdue
FROM invoices
WHERE days_overdue > 0;

-- Largest outstanding invoice
SELECT invoice_id,
       outstanding_amount
FROM invoices
ORDER BY outstanding_amount DESC
LIMIT 1;