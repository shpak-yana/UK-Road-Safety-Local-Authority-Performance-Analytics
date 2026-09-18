SELECT
    urban_rural,
    hour,
    COUNT(*) AS casualties
FROM stats19.v_casualties_enriched
GROUP BY urban_rural, hour
ORDER BY urban_rural, hour;