-- Outstanding AR by collection agent
SELECT collection_agent,
       SUM(outstanding_amount) AS portfolio_value
FROM invoices
GROUP BY collection_agent
ORDER BY portfolio_value DESC;

-- Invoice count by collection agent
SELECT collection_agent,
       COUNT(*) AS invoices_handled
FROM invoices
GROUP BY collection_agent
ORDER BY invoices_handled DESC;

-- Average delay by collection agent
SELECT collection_agent,
       ROUND(AVG(days_overdue),2) AS avg_delay
FROM invoices
GROUP BY collection_agent
ORDER BY avg_delay DESC;

-- Collection status breakdown
SELECT collection_status,
       COUNT(*)
FROM invoices
GROUP BY collection_status;

-- Priority collection list
SELECT invoice_id,
       customer_id,
       outstanding_amount,
       days_overdue,
       invoice_priority
FROM invoices
WHERE payment_status='Unpaid'
ORDER BY days_overdue DESC,
         outstanding_amount DESC
LIMIT 20;

-- Collection agent track record
SELECT
    collection_agent,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(invoice_id) AS total_invoices,
    SUM(outstanding_amount) AS total_outstanding_ar,
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
    ) AS unpaid_invoices
FROM invoices
GROUP BY collection_agent
ORDER BY ar_90_plus DESC;

-- Collection agent with total customers
SELECT
    i.collection_agent,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(
        DISTINCT CASE
            WHEN c.customer_credit_rating IN ('C','D')
            THEN c.customer_id
        END
    ) AS risky_customers,
    ROUND(
        100.0 *
        COUNT(
            DISTINCT CASE
                WHEN c.customer_credit_rating IN ('C','D')
                THEN c.customer_id
            END
        )
        /
        COUNT(DISTINCT c.customer_id),
        2
    ) AS risky_customer_pct
FROM invoices i
JOIN customers c
    ON i.customer_id = c.customer_id
GROUP BY i.collection_agent
ORDER BY risky_customers DESC;