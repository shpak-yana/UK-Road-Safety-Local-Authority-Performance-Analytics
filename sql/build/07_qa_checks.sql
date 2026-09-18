-- orphan casualties
INSERT INTO stats19.qa_log (check_name, check_value)
SELECT 'orphan_casualties',
       COUNT(*)
FROM stats19.fact_casualties c
LEFT JOIN stats19.fact_vehicles v
  USING (collision_index, vehicle_reference)
WHERE v.collision_index IS NULL;

-- orphan vehicles
INSERT INTO stats19.qa_log (check_name, check_value)
SELECT 'orphan_vehicles', COUNT(*)
FROM stats19.fact_vehicles v
LEFT JOIN stats19.fact_collisions f USING (collision_index)
WHERE f.collision_index IS NULL;

-- Casualties without IMD
INSERT INTO stats19.qa_log (check_name, check_value)
SELECT 'casualties_without_imd', COUNT(*)
FROM stats19.fact_casualties c
LEFT JOIN stats19.dim_imd i ON i.lsoa_code = c.lsoa_of_casualty
WHERE c.lsoa_of_casualty IS NOT NULL AND i.lsoa_code IS NULL;

-- Collisions outside dim_date
INSERT INTO stats19.qa_log (check_name, check_value)
SELECT 'collisions_outside_dim_date', COUNT(*)
FROM stats19.fact_collisions f
LEFT JOIN stats19.dim_date d ON d.date_key = f.date
WHERE f.date IS NOT NULL AND d.date_key IS NULL;

-- LA without name
INSERT INTO stats19.qa_log (check_name, check_value)
SELECT 'la_without_name', COUNT(*)
FROM stats19.dim_local_authority
WHERE lad_name = lad_code;