SELECT
    lad_name,
    COUNT(DISTINCT collision_index)                       AS collisions,
    COUNT(*)                                              AS casualties,
    COUNT(*) FILTER (WHERE casualty_severity IN (1,2))    AS ksi,
    ROUND(100.0 * COUNT(*) FILTER (WHERE casualty_severity IN (1,2))
          / NULLIF(COUNT(*), 0), 2)                       AS ksi_pct
FROM stats19.v_casualties_enriched
WHERE lad_name IS NOT NULL
GROUP BY lad_name
HAVING COUNT(*) >= 30
ORDER BY ksi DESC, casualties DESC
LIMIT 30;