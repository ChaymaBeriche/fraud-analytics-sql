
TRUNCATE TABLE raw.transactions;


COPY raw.transactions
FROM '/data/fraudTrain.csv'
WITH (FORMAT csv, HEADER true);