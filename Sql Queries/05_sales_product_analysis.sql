-- Revenue by product category
SELECT product_category,
       SUM(total_amount) AS revenue
FROM invoices
GROUP BY product_category
ORDER BY revenue DESC;

-- Outstanding AR by product category
SELECT product_category,
       SUM(outstanding_amount) AS outstanding_ar
FROM invoices
GROUP BY product_category
ORDER BY outstanding_ar DESC;

-- Revenue by sales channel
SELECT sales_channel,
       SUM(total_amount) AS revenue
FROM invoices
GROUP BY sales_channel
ORDER BY revenue DESC;

-- Outstanding AR by sales channel
SELECT sales_channel,
       SUM(outstanding_amount) AS outstanding_ar
FROM invoices
GROUP BY sales_channel
ORDER BY outstanding_ar DESC;

-- Average delay by sales channel
SELECT sales_channel,
       ROUND(AVG(days_overdue),2) AS avg_delay
FROM invoices
GROUP BY sales_channel
ORDER BY avg_delay DESC;

-- Average delay according to region
SELECT
    c.region,
    ROUND(AVG(i.days_overdue), 2) AS avg_delay_days
FROM invoices i
JOIN customers c
    ON i.customer_id = c.customer_id
GROUP BY c.region
ORDER BY avg_delay_days DESC;

-- Average delay by product category
SELECT Product_Category,
       ROUND(AVG(days_overdue),2) AS avg_delay
FROM invoices
GROUP BY Product_Category
ORDER BY avg_delay DESC;

-- Complete payment behavior scorecard
SELECT
    sales_channel,
    COUNT(*) AS total_invoices,
    ROUND(AVG(days_overdue), 2) AS avg_delay_days,
    SUM(outstanding_amount) AS total_outstanding_ar,
    SUM(CASE WHEN payment_status = 'Unpaid' THEN 1 ELSE 0 END) AS unpaid_invoices
FROM invoices
GROUP BY sales_channel
ORDER BY avg_delay_days DESC;

-- Unpaid invoices percentage by channel
SELECT
    sales_channel,
    COUNT(*) AS total_invoices,
    SUM(CASE WHEN payment_status = 'Unpaid' THEN 1 ELSE 0 END) AS unpaid_invoices,
    ROUND(
        100.0 * SUM(CASE WHEN payment_status = 'Unpaid' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS unpaid_percentage
FROM invoices
GROUP BY sales_channel
ORDER BY unpaid_percentage DESC;

-- Product category acoording to sales channel
SELECT
    sales_channel,
    product_category,
    COUNT(*) AS invoice_count
FROM invoices
GROUP BY sales_channel, product_category
ORDER BY sales_channel, invoice_count DESC;

-- AR-to-Revenue Ratio by Product Category
SELECT
    product_category,
    SUM(outstanding_amount) AS total_ar,
    SUM(total_amount) AS total_revenue,
    ROUND(
        SUM(outstanding_amount) * 100.0 /
        SUM(total_amount),
        2
    ) AS ar_to_revenue_pct
FROM invoices
GROUP BY product_category
ORDER BY ar_to_revenue_pct DESC;