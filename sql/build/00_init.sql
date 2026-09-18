-- Clean initialization
CREATE SCHEMA IF NOT EXISTS stats19;

-- QA reference table
CREATE OR REPLACE TABLE stats19.qa_log (
    check_name   VARCHAR,
    check_value  BIGINT,
    checked_at   TIMESTAMP DEFAULT current_timestamp
);