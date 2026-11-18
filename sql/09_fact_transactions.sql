DROP TABLE IF EXISTS dw.fact_transactions;

CREATE TABLE dw.fact_transactions (
    transaction_id  TEXT PRIMARY KEY,
    customer_key    INTEGER NOT NULL REFERENCES dw.dim_customer (customer_key),
    merchant_key    INTEGER NOT NULL REFERENCES dw.dim_merchant (merchant_key),
    date_key        INTEGER NOT NULL REFERENCES dw.dim_date (date_key),
    transaction_at  TIMESTAMP NOT NULL,
    amount          NUMERIC(10,2) NOT NULL,
    is_fraud        BOOLEAN NOT NULL,
    merchant_lat    DOUBLE PRECISION,
    merchant_lon    DOUBLE PRECISION
);

INSERT INTO dw.fact_transactions (
    transaction_id, customer_key, merchant_key, date_key,
    transaction_at, amount, is_fraud, merchant_lat, merchant_lon
)
SELECT
    s.transaction_id,
    c.customer_key,
    m.merchant_key,
    d.date_key,
    s.transaction_at,
    s.amount,
    s.is_fraud,
    s.merchant_lat,
    s.merchant_lon
FROM staging.transactions s
JOIN dw.dim_customer c ON c.card_number = s.card_number
JOIN dw.dim_merchant m ON m.merchant_name = s.merchant_name
                      AND m.category      = s.category
JOIN dw.dim_date d     ON d.full_date = s.transaction_at::DATE;


SELECT
    COUNT(*)                          AS nb_rows,
    COUNT(*) FILTER (WHERE is_fraud)  AS nb_frauds,
    SUM(amount)                       AS total_amount
FROM dw.fact_transactions;


SELECT 'staging' AS source, COUNT(*) AS nb_rows, SUM(amount) AS total_amount
FROM staging.transactions
UNION ALL
SELECT 'fact', COUNT(*), SUM(amount)
FROM dw.fact_transactions;