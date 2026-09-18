SELECT
    imd_decile,
    COUNT(*) FILTER (WHERE casualty_severity = 1) AS killed,
    COUNT(*) FILTER (WHERE casualty_severity = 2) AS serious,
    COUNT(*) FILTER (WHERE casualty_severity = 3) AS slight,
    COUNT(*)                                       AS total,
    ROUND(100.0 * COUNT(*) FILTER (WHERE casualty_severity IN (1,2)) / COUNT(*), 2)
                                                   AS ksi_pct
FROM stats19.v_casualties_enriched
WHERE imd_decile IS NOT NULL
GROUP BY imd_decile
ORDER BY imd_decile;