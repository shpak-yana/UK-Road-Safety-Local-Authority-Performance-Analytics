INSERT INTO stats19.dim_date
SELECT
    d::DATE                                AS date_key,
    EXTRACT(year    FROM d)::SMALLINT      AS year,
    EXTRACT(quarter FROM d)::TINYINT       AS quarter,
    EXTRACT(month   FROM d)::TINYINT       AS month,
    strftime(d, '%B')                      AS month_name,
    EXTRACT(day     FROM d)::TINYINT       AS day,
    (EXTRACT(isodow FROM d) - 1)::TINYINT  AS day_of_week,
    strftime(d, '%A')                      AS day_name,
    EXTRACT(isodow FROM d) IN (6,7)        AS is_weekend
FROM generate_series(DATE '2000-01-01', DATE '2030-12-31', INTERVAL 1 DAY) AS t(d);