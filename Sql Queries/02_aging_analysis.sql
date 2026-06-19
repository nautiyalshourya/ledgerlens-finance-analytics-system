-- Outstanding amount by aging bucket
SELECT aging_bucket,
       SUM(outstanding_amount) AS total_ar
FROM invoices
GROUP BY aging_bucket
ORDER BY aging_bucket;

-- Invoice count by aging bucket
SELECT aging_bucket,
       COUNT(*) AS invoice_count
FROM invoices
GROUP BY aging_bucket
ORDER BY aging_bucket;

-- Average overdue days by bucket
SELECT aging_bucket,
       ROUND(AVG(days_overdue),2) AS avg_delay
FROM invoices
GROUP BY aging_bucket;

-- Top 20 oldest invoices
SELECT invoice_id,
       customer_id,
       outstanding_amount,
       days_overdue
FROM invoices
ORDER BY days_overdue DESC
LIMIT 20;

-- 90+ day invoices
SELECT *
FROM invoices
WHERE days_overdue > 90
ORDER BY outstanding_amount DESC;

-- % of AR in each aging bucket
SELECT aging_bucket,
       ROUND(
       100.0 * SUM(outstanding_amount)
       / (SELECT SUM(outstanding_amount) FROM invoices),2)
       AS ar_percentage
FROM invoices
GROUP BY aging_bucket;