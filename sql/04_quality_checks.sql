-- 1. Missing values in the key columns
SELECT
    COUNT(*) FILTER (WHERE trans_num IS NULL)             AS missing_trans_num,
    COUNT(*) FILTER (WHERE cc_num IS NULL)                AS missing_cc_num,
    COUNT(*) FILTER (WHERE merchant IS NULL)              AS missing_merchant,
    COUNT(*) FILTER (WHERE amt IS NULL)                   AS missing_amt,
    COUNT(*) FILTER (WHERE trans_date_trans_time IS NULL) AS missing_date,
    COUNT(*) FILTER (WHERE is_fraud IS NULL) AS missing_is_fraud
FROM raw.transactions;

-- 2. Duplicates: is each transaction number unique?
SELECT
    COUNT(*)                  AS total_rows,
    COUNT(DISTINCT trans_num) AS unique_transactions
FROM raw.transactions;

-- 3. Strange values
SELECT
    MIN(amt)                   AS smallest_amount,
    MAX(amt)                   AS biggest_amount,
    COUNT(*) FILTER (WHERE amt <= 0) AS zero_or_negative,
    MIN(trans_date_trans_time) AS first_transaction,
    MAX(trans_date_trans_time) AS last_transaction,
    MIN(dob)                   AS oldest_birth,
    MAX(dob)                   AS youngest_birth
FROM raw.transactions;

-- 4. What the data looks like
SELECT
    COUNT(DISTINCT cc_num)   AS customers,
    COUNT(DISTINCT merchant) AS merchants,
    COUNT(DISTINCT category) AS categories
FROM raw.transactions;

SELECT DISTINCT gender FROM raw.transactions;

SELECT merchant FROM raw.transactions LIMIT 5;


SELECT COUNT(DISTINCT merchant) FILTER (WHERE merchant LIKE 'fraud\_%') AS with_prefix,
       COUNT(DISTINCT merchant)                                         AS all_merchants
FROM raw.transactions;