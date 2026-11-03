-- A folder for cleaned data
CREATE SCHEMA IF NOT EXISTS staging;

-- Start fresh each run
DROP TABLE IF EXISTS staging.transactions;

-- Build the clean table from raw
CREATE TABLE staging.transactions AS
SELECT
    trans_num                                  AS transaction_id,
    trans_date_trans_time                      AS transaction_at,
    amt                                        AS amount,
    (is_fraud = 1)                             AS is_fraud,

    -- customer
    cc_num                                     AS card_number,
    first                                      AS first_name,
    last                                       AS last_name,
    gender,
    dob                                        AS birth_date,
    job,
    street,
    city,
    state,
    zip,
    city_pop                                   AS city_population,
    lat                                        AS customer_lat,
    long                                       AS customer_lon,

    -- merchant
    REGEXP_REPLACE(merchant, '^fraud_', '')    AS merchant_name,
    category,
    merch_lat                                  AS merchant_lat,
    merch_long                                 AS merchant_lon

    -- row_id and unix_time are left out on purpose
FROM raw.transactions;

-- transaction_id is unique (we checked), so make it the primary key
ALTER TABLE staging.transactions
    ADD PRIMARY KEY (transaction_id);