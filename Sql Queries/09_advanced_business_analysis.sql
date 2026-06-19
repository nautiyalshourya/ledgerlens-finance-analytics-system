-- Top 20 customers to contact today
SELECT
c.customer_name,
c.customer_credit_rating,
SUM(i.outstanding_amount) AS total_outstanding,
AVG(i.days_overdue) AS avg_delay,
COUNT(i.invoice_id) AS unpaid_invoices
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
WHERE i.payment_status='Unpaid'
GROUP BY c.customer_name,c.customer_credit_rating
ORDER BY total_outstanding DESC,
         avg_delay DESC
LIMIT 20;

-- High Revenue + High Risk customers + High overdue days
SELECT
    c.customer_name,
    c.customer_credit_rating,
    SUM(i.total_amount) AS revenue,
    SUM(i.outstanding_amount) AS outstanding,
    ROUND(AVG(i.days_overdue),2) AS avg_overdue_days,
    MAX(i.days_overdue) AS highest_overdue_days
FROM invoices i
JOIN customers c
ON i.customer_id = c.customer_id
GROUP BY
    c.customer_name,
    c.customer_credit_rating
HAVING SUM(i.outstanding_amount) > 0
ORDER BY
    revenue DESC,
    outstanding DESC,
    highest_overdue_days DESC;
	
-- Disputed invoices summary
SELECT
dispute_flag,
COUNT(*) AS invoices,
SUM(outstanding_amount) AS outstanding
FROM invoices
GROUP BY dispute_flag;

	--- Dispute analysis percentage
	SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN dispute_flag='Yes'
                THEN outstanding_amount
                ELSE 0
            END)
       		 /
       		 SUM(outstanding_amount),
       			 2)
			 AS dispute_ar_pct
		FROM invoices;

-- Payment method analysis
SELECT
payment_method,
COUNT(*) AS payments,
SUM(amount_paid) AS amount_collected
FROM payments
GROUP BY payment_method
ORDER BY amount_collected DESC;

-- Top customers contribution to AR
SELECT
    customer_id,
    SUM(outstanding_amount) AS customer_ar,
    ROUND(
        100.0 *
        SUM(outstanding_amount)
        /
        (SELECT SUM(outstanding_amount) FROM invoices),
        2
    ) AS ar_percentage
FROM invoices
GROUP BY customer_id
ORDER BY customer_ar DESC
LIMIT 20;

-- Pareto Analysis (20/80) of top 20 customers
WITH top20 AS (
    SELECT
        customer_id,
        SUM(outstanding_amount) AS total_unpaid_ar
    FROM invoices
    WHERE payment_status = 'Unpaid'
    GROUP BY customer_id
    ORDER BY total_unpaid_ar DESC
    LIMIT 20
)
SELECT
    COUNT(*) AS top_customers,
    SUM(total_unpaid_ar) AS top20_unpaid_ar,
    ROUND(
        100.0 *
        SUM(total_unpaid_ar)
        /
        (
            SELECT SUM(outstanding_amount)
            FROM invoices
            WHERE payment_status = 'Unpaid'
        ),
        2
    ) AS contribution_pct
FROM top20;

-- Large AR + High delays + Many unpaid invoices
SELECT
    c.customer_name,
    c.customer_credit_rating,
    SUM(i.outstanding_amount) AS outstanding_ar,
    ROUND(AVG(i.days_overdue),2) AS avg_delay_days,
    COUNT(*) FILTER (
        WHERE i.payment_status='Unpaid'
    ) AS unpaid_invoices
FROM invoices i
JOIN customers c
ON i.customer_id=c.customer_id
GROUP BY
    c.customer_name,
    c.customer_credit_rating
HAVING
    SUM(i.outstanding_amount) > 0
ORDER BY
    avg_delay_days DESC,
    outstanding_ar DESC;

-- Delay by payment method
SELECT
    payment_method,
    COUNT(*) AS payments,
    SUM(amount_paid) AS amount_collected,
    ROUND(
        100.0 * SUM(amount_paid)
        / SUM(SUM(amount_paid)) OVER (),
        2
    ) AS collection_contribution_pct,
    ROUND(AVG(delay_days),2) AS avg_delay_days,
    MAX(delay_days) AS max_delay_days
FROM payments
WHERE payment_method IS NOT NULL
GROUP BY payment_method
ORDER BY amount_collected DESC;