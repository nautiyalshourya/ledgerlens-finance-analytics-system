-- Monthly invoice value
SELECT invoice_year,
       invoice_month,
       SUM(total_amount) AS invoice_value
FROM invoices
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month;

-- Monthly outstanding AR
SELECT invoice_year,
       invoice_month,
       SUM(outstanding_amount) AS outstanding_ar
FROM invoices
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month;

-- Monthly invoice count
SELECT invoice_year,
       invoice_month,
       COUNT(*) AS invoice_count
FROM invoices
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month;

-- Monthly average overdue days
SELECT invoice_year,
       invoice_month,
       ROUND(AVG(days_overdue),2) AS avg_delay
FROM invoices
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month;

-- Collection according to month
SELECT
    invoice_year,
    invoice_month,
    SUM(total_amount) AS invoiced_amount,
    SUM(total_amount - outstanding_amount) AS collected_amount,
    SUM(outstanding_amount) AS pending_amount,
    ROUND(
        SUM(total_amount - outstanding_amount) * 100.0 /
        NULLIF(SUM(total_amount),0),
        2
    ) AS collection_rate_pct
FROM invoices
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month;

-- Collection rate
SELECT
    invoice_year,
    invoice_month,
    SUM(total_amount) AS invoiced_amount,
    SUM(total_amount - outstanding_amount) AS collected_amount,
    ROUND(
        100.0 *
        SUM(total_amount - outstanding_amount)
        / NULLIF(SUM(total_amount),0),
        2
    ) AS collection_rate_pct
FROM invoices
GROUP BY invoice_year, invoice_month
ORDER BY invoice_year, invoice_month;

-- Collection trend by year
SELECT
    invoice_year,
    SUM(total_amount) AS total_invoiced,
    SUM(total_amount - outstanding_amount) AS total_collected,
    ROUND(
        100.0 *
        SUM(total_amount - outstanding_amount)
        / NULLIF(SUM(total_amount), 0),
        2
    ) AS collection_rate_pct
FROM invoices
GROUP BY invoice_year
ORDER BY invoice_year;

-- Collection effectiveness scorecard
SELECT
    invoice_year,
    COUNT(*) AS total_invoices,
    SUM(total_amount) AS total_invoiced,
    SUM(total_amount - outstanding_amount) AS total_collected,
    SUM(outstanding_amount) AS total_outstanding_ar,
    ROUND(
        100.0 *
        SUM(total_amount - outstanding_amount)
        / NULLIF(SUM(total_amount),0),
        2
    ) AS collection_rate_pct,
    ROUND(AVG(days_overdue),2) AS avg_delay_days,
    SUM(
        CASE
            WHEN days_overdue > 90
            THEN outstanding_amount
            ELSE 0
        END
    ) AS ar_90_plus,
    SUM(
        CASE
            WHEN payment_status = 'Unpaid'
            THEN 1
            ELSE 0
        END
    ) AS unpaid_invoices,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN payment_status = 'Unpaid'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS unpaid_invoice_pct
FROM invoices
GROUP BY invoice_year
ORDER BY invoice_year;