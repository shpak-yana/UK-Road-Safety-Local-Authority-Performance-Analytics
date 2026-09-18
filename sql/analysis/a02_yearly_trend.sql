SELECT
    year,
    COUNT(DISTINCT collision_index)                    AS collisions,
    COUNT(*)                                           AS casualties,
    COUNT(*) FILTER (WHERE casualty_severity = 1)      AS killed,
    COUNT(*) FILTER (WHERE casualty_severity = 2)      AS serious,
    COUNT(*) FILTER (WHERE casualty_severity = 3)      AS slight
FROM stats19.v_casualties_enriched
GROUP BY year
ORDER BY year;