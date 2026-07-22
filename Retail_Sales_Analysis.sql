/*
=====================================================
Retail Sales Analysis Using MySQL

Dataset: Online Retail II
Database: MySQL
Author: Your Name (optional)

=====================================================
*/


/*
=====================================================
Business Question 1

How did monthly gross revenue, return value, and net revenue change over time?
=====================================================
*/

WITH cleaned_data AS (
    SELECT
        *,
        CASE
            WHEN invoice_date LIKE '%/%'
                THEN STR_TO_DATE(invoice_date, '%m/%d/%Y %H:%i')
            ELSE STR_TO_DATE(invoice_date, '%d-%m-%Y %H:%i')
        END AS invoice_datetime
    FROM clean_transactions
)

SELECT
    YEAR(invoice_datetime) AS year,
    MONTHNAME(invoice_datetime) AS month,
    ROUND(SUM(CASE WHEN quantity > 0 THEN quantity * price ELSE 0 END), 2) AS gross_revenue,
    ROUND(ABS(SUM(CASE WHEN quantity < 0 THEN quantity * price ELSE 0 END)), 2) AS return_value,
    ROUND(SUM(quantity * price), 2) AS net_revenue

FROM cleaned_data

WHERE price > 0
  AND stock_code <> 'B'
  AND description <> ''
  AND invoice_datetime IS NOT NULL

GROUP BY
    YEAR(invoice_datetime),
    MONTH(invoice_datetime),
    MONTHNAME(invoice_datetime)

ORDER BY
    year,
    MONTH(invoice_datetime);


/*
=====================================================
Business Question 2

Which products generated the highest net revenue?
=====================================================
*/

SELECT
    stock_code,
    description,
    ROUND(SUM(CASE WHEN quantity > 0 THEN quantity * price ELSE 0 END), 2) AS gross_revenue,
    ROUND(ABS(SUM(CASE WHEN quantity < 0 THEN quantity * price ELSE 0 END)), 2) AS return_value,
    ROUND(SUM(quantity * price), 2) AS net_revenue

FROM clean_transactions

WHERE price > 0
  AND description <> ''
  AND stock_code <> 'B'
  AND description <> 'POSTAGE'
  AND description <> 'DOTCOM POSTAGE'
  AND description <> 'Manual'

GROUP BY
    stock_code,
    description

HAVING
    net_revenue > 0

ORDER BY
    net_revenue DESC

LIMIT 10;



/*
=====================================================
Business Question 3

Which products sold the highest number of units?
=====================================================
*/

SELECT
    stock_code,
    description,
    SUM(quantity) AS total_units_sold

FROM clean_transactions

WHERE quantity > 0
  AND price > 0
  AND description <> ''
  AND stock_code <> 'B'
  AND description <> 'POSTAGE'
  AND description <> 'DOTCOM POSTAGE'
  AND description <> 'Manual'

GROUP BY
    stock_code,
    description

ORDER BY
    total_units_sold DESC

LIMIT 10;


/*
=====================================================
Business Question 4

Who are the top 10 customers by net spending?
=====================================================
*/

SELECT
    customer_id,
    ROUND(SUM(CASE WHEN quantity > 0 THEN quantity * price ELSE 0 END), 2) AS gross_spend,
    ROUND(ABS(SUM(CASE WHEN quantity < 0 THEN quantity * price ELSE 0 END)), 2) AS return_value,
    ROUND(SUM(quantity * price), 2) AS net_spend

FROM clean_transactions

WHERE price > 0
  AND customer_id <> ''
  AND stock_code <> 'B'

GROUP BY
    customer_id

HAVING
    net_spend > 0

ORDER BY
    net_spend DESC

LIMIT 10;


/*
=====================================================
Business Question 5

Which countries generated the highest net revenue?
=====================================================
*/

SELECT
    country,
    ROUND(SUM(CASE WHEN quantity > 0 THEN quantity * price ELSE 0 END), 2) AS gross_revenue,
    ROUND(ABS(SUM(CASE WHEN quantity < 0 THEN quantity * price ELSE 0 END)), 2) AS return_value,
    ROUND(SUM(quantity * price), 2) AS net_revenue

FROM clean_transactions

WHERE price > 0
  AND stock_code <> 'B'

GROUP BY
    country

HAVING
    net_revenue > 0

ORDER BY
    net_revenue DESC;


/*
=====================================================
Business Question 6

Which customers placed the highest number of orders?
=====================================================
*/

SELECT
    customer_id,
    COUNT(DISTINCT invoice) AS total_orders

FROM clean_transactions

WHERE quantity > 0
  AND price > 0
  AND customer_id <> ''
  AND stock_code <> 'B'

GROUP BY
    customer_id

ORDER BY
    total_orders DESC

LIMIT 10;



/*
=====================================================
Business Question 7

Which customers have the highest average order value?
(Minimum 10 orders)
=====================================================
*/

SELECT
    customer_id,
    ROUND(SUM(CASE WHEN quantity > 0 THEN quantity * price ELSE 0 END), 2) AS gross_spend,
    ROUND(ABS(SUM(CASE WHEN quantity < 0 THEN quantity * price ELSE 0 END)), 2) AS return_value,
    ROUND(SUM(quantity * price), 2) AS net_spend,
    COUNT(DISTINCT invoice) AS total_orders,
    ROUND(SUM(quantity * price) / COUNT(DISTINCT invoice), 2) AS average_order_value

FROM clean_transactions

WHERE price > 0
  AND customer_id <> ''
  AND stock_code <> 'B'

GROUP BY
    customer_id

HAVING COUNT(DISTINCT invoice) >= 10
   AND net_spend > 0

ORDER BY
    average_order_value DESC

LIMIT 10;



/*
=====================================================
Business Question 8

Which calendar months generate the highest average gross revenue,
return value, and net revenue?
=====================================================
*/

WITH cleaned_data AS (
    SELECT
        *,
        CASE
            WHEN invoice_date LIKE '%/%'
                THEN STR_TO_DATE(invoice_date, '%m/%d/%Y %H:%i')
            ELSE STR_TO_DATE(invoice_date, '%d-%m-%Y %H:%i')
        END AS invoice_datetime
    FROM clean_transactions
),

monthly_revenue AS (
    SELECT
        YEAR(invoice_datetime) AS year,
        MONTH(invoice_datetime) AS month,
        MONTHNAME(invoice_datetime) AS month_name,

        SUM(CASE WHEN quantity > 0 THEN quantity * price ELSE 0 END) AS gross_revenue,
        ABS(SUM(CASE WHEN quantity < 0 THEN quantity * price ELSE 0 END)) AS return_value,
        SUM(quantity * price) AS net_revenue

    FROM cleaned_data

    WHERE price > 0
      AND stock_code <> 'B'
      AND description <> ''
      AND invoice_datetime IS NOT NULL

    GROUP BY
        YEAR(invoice_datetime),
        MONTH(invoice_datetime),
        MONTHNAME(invoice_datetime)
)

SELECT
    month_name AS month,
    ROUND(AVG(gross_revenue), 2) AS average_gross_revenue,
    ROUND(AVG(return_value), 2) AS average_return_value,
    ROUND(AVG(net_revenue), 2) AS average_net_revenue

FROM monthly_revenue

GROUP BY
    month,
    month_name

ORDER BY
    average_net_revenue DESC;






