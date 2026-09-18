SELECT
    CASE
        WHEN age_of_casualty <  0 THEN 'Unknown'
        WHEN age_of_casualty < 16 THEN '0–15'
        WHEN age_of_casualty < 25 THEN '16–24'
        WHEN age_of_casualty < 40 THEN '25–39'
        WHEN age_of_casualty < 60 THEN '40–59'
        WHEN age_of_casualty < 75 THEN '60–74'
        ELSE '75+'
    END AS age_band,
    COUNT(*)                                           AS casualties,
    COUNT(*) FILTER (WHERE casualty_severity IN (1,2)) AS ksi
FROM stats19.v_casualties_enriched
GROUP BY age_band
ORDER BY MIN(age_of_casualty);