
-- Total invoices
SELECT COUNT(*) AS total_invoices
FROM invoices;

-- Total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- Total payments
SELECT COUNT(*) AS total_payments
FROM payments;

-- Duplicate invoice IDs
SELECT invoice_id, COUNT(*)
FROM invoices
GROUP BY invoice_id
HAVING COUNT(*) > 1;

-- Duplicate customer IDs
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Missing customer IDs in invoices
SELECT COUNT(*)
FROM invoices
WHERE customer_id IS NULL;

-- Negative invoice amounts
SELECT *
FROM invoices
WHERE total_amount < 0;

-- Negative outstanding amounts
SELECT *
FROM invoices
WHERE outstanding_amount < 0;

-- Payment status distribution
SELECT payment_status,
       COUNT(*) AS invoice_count
FROM invoices
GROUP BY payment_status
ORDER BY invoice_count DESC;

-- Aging bucket distribution
SELECT aging_bucket,
       COUNT(*) AS invoice_count
FROM invoices
GROUP BY aging_bucket
ORDER BY aging_bucket;

-- Collection status distribution
SELECT collection_status,
       COUNT(*)
FROM invoices
GROUP BY collection_status;

-- Disputed invoices
SELECT dispute_flag,
       COUNT(*)
FROM invoices
GROUP BY dispute_flag;