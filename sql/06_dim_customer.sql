-- A new folder for the final star schema
CREATE SCHEMA IF NOT EXISTS dw;

DROP TABLE IF EXISTS dw.dim_customer;

-- 1. The shape of the table
CREATE TABLE dw.dim_customer (
    customer_key     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    card_number      TEXT NOT NULL UNIQUE,
    first_name       TEXT,
    last_name        TEXT,
    gender           TEXT,
    birth_date       DATE,
    job              TEXT,
    street           TEXT,
    city             TEXT,
    state            TEXT,
    zip              TEXT,
    city_population  INTEGER,
    customer_lat     DOUBLE PRECISION,
    customer_lon     DOUBLE PRECISION
);

-- 2. Fill it: one row per customer
INSERT INTO dw.dim_customer (
    card_number, first_name, last_name, gender, birth_date, job,
    street, city, state, zip, city_population, customer_lat, customer_lon
)
SELECT DISTINCT
    card_number, first_name, last_name, gender, birth_date, job,
    street, city, state, zip, city_population, customer_lat, customer_lon
FROM staging.transactions
ORDER BY card_number;


SELECT COUNT(*) FROM dw.dim_customer;
SELECT * FROM dw.dim_customer LIMIT 5;