DROP TABLE IF EXISTS dw.dim_date;

CREATE TABLE dw.dim_date (
    date_key     INTEGER PRIMARY KEY,
    full_date    DATE NOT NULL UNIQUE,
    year         SMALLINT NOT NULL,
    quarter      SMALLINT NOT NULL,
    month        SMALLINT NOT NULL,
    month_name   TEXT NOT NULL,
    day          SMALLINT NOT NULL,
    day_of_week  SMALLINT NOT NULL,
    day_name     TEXT NOT NULL,
    is_weekend   BOOLEAN NOT NULL
);

INSERT INTO dw.dim_date (
    date_key, full_date, year, quarter, month, month_name,
    day, day_of_week, day_name, is_weekend
)
SELECT
    TO_CHAR(d, 'YYYYMMDD')::INTEGER,
    d::DATE,
    EXTRACT(YEAR    FROM d),
    EXTRACT(QUARTER FROM d),
    EXTRACT(MONTH   FROM d),
    TO_CHAR(d, 'FMMonth'),
    EXTRACT(DAY     FROM d),
    EXTRACT(ISODOW  FROM d),
    TO_CHAR(d, 'FMDay'),
    EXTRACT(ISODOW  FROM d) IN (6, 7)
FROM generate_series(
    (SELECT MIN(transaction_at)::DATE FROM staging.transactions)::TIMESTAMP,
    (SELECT MAX(transaction_at)::DATE FROM staging.transactions)::TIMESTAMP,
    INTERVAL '1 day'
) AS d;


SELECT COUNT(*) FROM dw.dim_date;
SELECT * FROM dw.dim_date ORDER BY full_date LIMIT 5;
SELECT * FROM dw.dim_date ORDER BY full_date DESC LIMIT 3;