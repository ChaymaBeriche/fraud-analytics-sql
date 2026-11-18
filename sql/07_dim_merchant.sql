DROP TABLE IF EXISTS dw.dim_merchant;

CREATE TABLE dw.dim_merchant (
    merchant_key   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name  TEXT NOT NULL,
    category       TEXT NOT NULL,
    UNIQUE (merchant_name, category)
);

INSERT INTO dw.dim_merchant (merchant_name, category)
SELECT DISTINCT merchant_name, category
FROM staging.transactions
ORDER BY merchant_name, category;


SELECT COUNT(*) FROM dw.dim_merchant;

SELECT merchant_name, COUNT(*) AS nb_categories
FROM dw.dim_merchant
GROUP BY merchant_name
HAVING COUNT(*) > 1;
