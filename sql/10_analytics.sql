-- fraud rate by hour of the day 
 
    SELECT EXTRACT(hour from transaction_at) as hour_of_day
            , COUNT(*) FILTER (WHERE is_fraud) * 100.0 / COUNT(*) as fraud_rate
    from dw.fact_transactions
    GROUP BY hour_of_day
    ORDER BY hour_of_day

--fraud rate on weekends vs weekdays 

    SELECT CASE when d.is_weekend then 'weekends' else 'weekdays' end  day_type,
           COUNT(*) as Total_transaction,
           COUNT(*) FILTER (WHERE is_fraud) fraud_nb,
           ROUND(COUNT(*) FILTER (WHERE is_fraud) * 100.0 / COUNT(*),2) as fraud_rate
    from dw.fact_transactions t
    JOIN dw.dim_date d on d.date_key=t.date_key
    GROUP BY d.is_weekend               


-- Total fraud by month 
-- Note: June 2020 is incomplete (data ends on the 21st)

    SELECT  d.year year_ ,
            d.month month_number,
            COUNT(*) fraud_number,
            SUM(t.amount) Amount
    from dw.fact_transactions t
    JOIN dw.dim_date d on d.date_key=t.date_key
    WHERE t.is_fraud
    GROUP BY  d.year, d.month
    ORDER BY  d.year, d.month ;

