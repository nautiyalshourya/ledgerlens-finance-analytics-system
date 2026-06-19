-- AR by region
SELECT c.region,
       SUM(i.outstanding_amount) AS total_ar
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.region
ORDER BY total_ar DESC;

-- AR by industry
SELECT c.industry,
       SUM(i.outstanding_amount) AS total_ar
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.industry
ORDER BY total_ar DESC;

-- Average delay by region
SELECT c.region,
       ROUND(AVG(i.days_overdue),2) AS avg_delay
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.region;

-- Average delay by industry
SELECT c.industry,
       ROUND(AVG(i.days_overdue),2) AS avg_delay
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.industry
ORDER BY avg_delay DESC;

-- Region with most 90+ age bucket
SELECT
    c.region,
    COUNT(*) AS overdue_invoices,
    SUM(i.outstanding_amount) AS total_90_plus_ar,
    ROUND(AVG(i.days_overdue),2) AS avg_delay_days
FROM invoices i
JOIN customers c
    ON i.customer_id = c.customer_id
WHERE i.days_overdue > 90
GROUP BY c.region
ORDER BY total_90_plus_ar DESC;

-- Risk associated to industries
SELECT
    c.industry,
    COUNT(*) AS total_invoices,
    ROUND(AVG(i.days_overdue), 2) AS avg_delay_days,
    SUM(i.total_amount) AS total_revenue,
    SUM(i.outstanding_amount) AS total_outstanding_ar,
    ROUND(
        SUM(i.outstanding_amount) * 100.0 /
        NULLIF(SUM(i.total_amount), 0),
        2
    ) AS ar_to_revenue_pct,
    SUM(
        CASE
            WHEN i.days_overdue > 90
            THEN i.outstanding_amount
            ELSE 0
        END
    ) AS ar_90_plus,
    SUM(
        CASE
            WHEN i.payment_status = 'Unpaid'
            THEN 1
            ELSE 0
        END
    ) AS unpaid_invoices,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN i.payment_status = 'Unpaid'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS unpaid_invoice_pct
FROM invoices i
JOIN customers c
    ON i.customer_id = c.customer_id
GROUP BY c.industry
ORDER BY total_outstanding_ar DESC;