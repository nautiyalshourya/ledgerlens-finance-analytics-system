-- Top 10 customers by outstanding amount
SELECT c.customer_name,
       SUM(i.outstanding_amount) AS total_ar
FROM invoices i
JOIN customers c
ON i.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_ar DESC
LIMIT 10;

-- Top 10 customers by invoice value
SELECT c.customer_name,
       SUM(i.total_amount) AS revenue
FROM invoices i
JOIN customers c
ON i.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY revenue DESC
LIMIT 10;

-- Customers with highest overdue days
SELECT c.customer_name,
       ROUND(AVG(i.days_overdue),2) AS avg_delay
FROM invoices i
JOIN customers c
ON i.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY avg_delay DESC
LIMIT 10;

-- Customers with most unpaid invoices
SELECT c.customer_name,
       COUNT(*) AS unpaid_count
FROM invoices i
JOIN customers c
ON i.customer_id = c.customer_id
WHERE i.payment_status='Unpaid'
GROUP BY c.customer_name
ORDER BY unpaid_count DESC
LIMIT 10;

-- Customer contribution to AR
SELECT c.customer_name,
       SUM(i.outstanding_amount) AS outstanding
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.customer_name
ORDER BY outstanding DESC;