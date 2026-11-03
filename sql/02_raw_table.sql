DROP TABLE IF EXISTS raw.transactions;

CREATE TABLE raw.transactions (
    row_id                 INTEGER,           -- the unnamed first column (0, 1, 2...)
    trans_date_trans_time  TIMESTAMP,         -- day + time
    cc_num                 TEXT,              -- a label, not a number to calculate
    merchant               TEXT,
    category               TEXT,
    amt                    NUMERIC(10,2),     -- money: exact, 2 decimals
    first                  TEXT,
    last                   TEXT,
    gender                 TEXT,
    street                 TEXT,
    city                   TEXT,
    state                  TEXT,
    zip                    TEXT,
    lat                    DOUBLE PRECISION,  -- GPS: approximate is fine
    long                   DOUBLE PRECISION,
    city_pop               INTEGER,
    job                    TEXT,
    dob                    DATE,              -- birth date: day only
    trans_num              TEXT,              -- transaction ID (letters + digits)
    unix_time              BIGINT,            -- seconds since 1970: too big for INTEGER
    merch_lat              DOUBLE PRECISION,
    merch_long             DOUBLE PRECISION,
    is_fraud               SMALLINT           -- 0 or 1
);