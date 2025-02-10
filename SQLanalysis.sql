-- 1. Check Data Overview
-- Get the first few rows of each table
SELECT * FROM account_activity LIMIT 5;
SELECT * FROM customer_data LIMIT 5;
SELECT * FROM fraud_indicators LIMIT 5;
SELECT * FROM suspicious_activity LIMIT 5;
SELECT * FROM merchant_data LIMIT 5;
SELECT * FROM transaction_category LIMIT 5;
SELECT * FROM amount_data LIMIT 5;
SELECT * FROM anomaly_scores LIMIT 5;
SELECT * FROM transaction_metadata LIMIT 5;
SELECT * FROM transaction_records LIMIT 5;

-- Get column details and data types
DESCRIBE account_activity;
DESCRIBE customer_data;
DESCRIBE fraud_indicators;
DESCRIBE suspicious_activity;
DESCRIBE merchant_data;
DESCRIBE transaction_category;
DESCRIBE amount_data;
DESCRIBE anomaly_scores;
DESCRIBE transaction_metadata;
DESCRIBE transaction_records;

-- 2. Data Exploration and Statistics
-- Check the total number of transactions
SELECT COUNT(*) AS total_transactions FROM transaction_metadata;

-- Check for missing values
SELECT 
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customers,
    SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END) AS missing_transactions
FROM transaction_metadata;

-- Summary Statistics for Numeric Columns (Min, Max, Avg, etc.)
SELECT 
    MIN(amount) AS min_amount,
    MAX(amount) AS max_amount,
    AVG(amount) AS avg_amount,
    STD(amount) AS std_dev
FROM amount_data;

-- 3. Fraud Analysis
-- Count of fraudulent vs. non-fraudulent transactions
SELECT FraudIndicator, COUNT(*) AS count
FROM fraud_indicators
GROUP BY FraudIndicator;

-- Find top 10 customers with the most fraudulent transactions
SELECT c.CustomerID, c.Name, COUNT(f.TransactionID) AS fraud_count
FROM customer_data c
JOIN fraud_indicators f ON c.CustomerID = f.CustomerID
WHERE f.FraudIndicator = 1
GROUP BY c.CustomerID, c.Name
ORDER BY fraud_count DESC
LIMIT 10;

-- Top 10 merchants flagged for fraud
SELECT m.MerchantID, m.MerchantName, COUNT(f.TransactionID) AS fraud_count
FROM merchant_data m
JOIN fraud_indicators f ON m.MerchantID = f.MerchantID
WHERE f.FraudIndicator = 1
GROUP BY m.MerchantID, m.MerchantName
ORDER BY fraud_count DESC
LIMIT 10;

-- Suspicious activity count per customer
SELECT CustomerID, COUNT(*) AS suspicious_count
FROM suspicious_activity
GROUP BY CustomerID
ORDER BY suspicious_count DESC
LIMIT 10;

-- 4. Transaction Patterns
-- Find the most common transaction categories
SELECT Category, COUNT(*) AS transaction_count
FROM transaction_category
GROUP BY Category
ORDER BY transaction_count DESC
LIMIT 10;

-- Identify peak transaction hours
SELECT HOUR(Timestamp) AS hour, COUNT(*) AS transaction_count
FROM transaction_metadata
GROUP BY HOUR(Timestamp)
ORDER BY transaction_count DESC;

-- Average transaction amount per category
SELECT t.Category, AVG(a.amount) AS avg_amount
FROM transaction_category t
JOIN amount_data a ON t.TransactionID = a.TransactionID
GROUP BY t.Category
ORDER BY avg_amount DESC;

-- 5. Anomaly Detection
-- Find transactions with high anomaly scores
SELECT a.TransactionID, a.amount, an.anomaly_score
FROM amount_data a
JOIN anomaly_scores an ON a.TransactionID = an.TransactionID
WHERE an.anomaly_score > (SELECT AVG(anomaly_score) + 2 * STD(anomaly_score) FROM anomaly_scores)
ORDER BY an.anomaly_score DESC;

-- Customers with the highest number of anomalies
SELECT c.CustomerID, c.Name, COUNT(an.TransactionID) AS anomaly_count
FROM customer_data c
JOIN anomaly_scores an ON c.CustomerID = an.CustomerID
WHERE an.anomaly_score > (SELECT AVG(anomaly_score) + 2 * STD(anomaly_score) FROM anomaly_scores)
GROUP BY c.CustomerID, c.Name
ORDER BY anomaly_count DESC
LIMIT 10;

-- 6. Feature Engineering
-- Add a new column for transaction hour
ALTER TABLE transaction_metadata ADD COLUMN TransactionHour INT;
UPDATE transaction_metadata SET TransactionHour = HOUR(Timestamp);

-- Calculate time gap between transactions and last login
ALTER TABLE transaction_metadata ADD COLUMN LoginGapDays INT;
UPDATE transaction_metadata 
SET LoginGapDays = DATEDIFF(Timestamp, LastLogin);
