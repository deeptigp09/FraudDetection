# Fraud Detection Analysis

## Overview
This project focuses on fraud detection using a dataset obtained from **Kaggle**. The analysis includes exploratory data analysis (EDA), fraud pattern detection, anomaly detection, and feature engineering using SQL and Python. The dataset contains multiple tables with customer transactions, fraud indicators, merchant information, and anomaly scores.

## Dataset
The dataset used in this analysis is sourced from Kaggle and consists of the following files:
- `account_activity.csv`
- `customer_data.csv`
- `fraud_indicators.csv`
- `suspicious_activity.csv`
- `merchant_data.csv`
- `transaction_category.csv`
- `amount_data.csv`
- `anomaly_scores.csv`
- `transaction_metadata.csv`
- `transaction_records.csv`


## Exploratory Data Analysis (EDA)
The analysis includes:
- Checking data structure, missing values, and summary statistics.
- Analyzing transaction patterns and common fraud trends.
- Identifying high-risk customers and merchants.
- Detecting peak transaction times and suspicious activities.

## SQL Queries
SQL queries are used for:
- Data exploration (counting transactions, checking missing values, etc.).
- Fraud detection (flagging high-risk customers and merchants).
- Anomaly detection (transactions with unusually high anomaly scores).
- Feature engineering (creating transaction hour columns and calculating time gaps).

## Tools Used
- **Python**: Pandas, NumPy, Matplotlib, Seaborn for visualization.
- **SQL**: Queries to explore and analyze structured data.
- **Google Colab**: For executing Python-based data analysis.

## How to Use
1. Load the dataset from Google Drive into Google Colab.
2. Run the Python scripts for data exploration and visualization.
3. Execute SQL queries for deeper insights into transaction patterns and fraud detection.
4. Use insights gained to develop fraud detection models or refine anomaly detection strategies.

## Acknowledgment
The dataset used for this project is publicly available on **Kaggle**. It is used strictly for educational and analytical purposes.

## Future Enhancements
- Implement machine learning models to classify fraudulent transactions.
- Integrate real-time anomaly detection using streaming data.
- Build an interactive dashboard for fraud monitoring.
