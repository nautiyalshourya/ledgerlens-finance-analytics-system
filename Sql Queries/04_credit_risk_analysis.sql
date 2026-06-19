-- Outstanding AR by credit rating
SELECT c.customer_credit_rating,
       SUM(i.outstanding_amount) AS total_ar
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.customer_credit_rating
ORDER BY total_ar DESC;

-- Average delay by credit rating
SELECT c.customer_credit_rating,
       ROUND(AVG(i.days_overdue),2) AS avg_delay
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.customer_credit_rating;

-- AR by risk score band
SELECT c.risk_base_score,
       SUM(i.outstanding_amount) AS outstanding
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.risk_base_score
ORDER BY risk_base_score DESC;

-- Top high-risk customers
SELECT c.customer_name,
       c.customer_credit_rating,
       c.risk_base_score,
       SUM(i.outstanding_amount) AS total_ar
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY c.customer_name,
         c.customer_credit_rating,
         c.risk_base_score
ORDER BY total_ar DESC
LIMIT 20;