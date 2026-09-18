-- ============================================================
-- Enriched facts — for Power BI reports
-- ============================================================

CREATE OR REPLACE VIEW stats19.v_collisions AS
SELECT
    f.collision_index,
    f.date,
    f.year,
    f.month,
    f.hour,
    f.police_force,
    f.local_authority_ons_district,
    la.lad_name,
    f.longitude,
    f.latitude,
    f.road_type,
    f.urban_or_rural_area,
    ur.label                                AS urban_rural,
    f.light_conditions,
    f.weather_conditions,
    f.road_surface_conditions,
    f.first_road_class,
    f.speed_limit,
    f.junction_detail,
    f.number_of_vehicles,
    f.number_of_casualties,
    f.collision_severity,
    sev.label                               AS collision_severity_label
FROM stats19.fact_collisions f
LEFT JOIN stats19.dim_local_authority la ON la.lad_code = f.local_authority_ons_district
LEFT JOIN stats19.dim_urban_rural ur      ON ur.code     = f.urban_or_rural_area
LEFT JOIN stats19.dim_severity sev        ON sev.code    = f.collision_severity;

-- ============================================================
-- Casualties + driver + collision + IMD — "wide" showcase
-- ============================================================

CREATE OR REPLACE VIEW stats19.v_casualties_enriched AS
SELECT
    c.collision_index,
    c.vehicle_reference,
    c.casualty_reference,

    -- Date
    f.date,
    d.year,
    d.quarter,
    d.month,
    d.month_name,
    d.day_of_week,
    d.day_name,
    d.is_weekend,
    f.hour,

    -- Place
    f.police_force,
    COALESCE(la.lad_name, i.lad_name)  AS lad_name,
    COALESCE(la.lad_code, i.lad_code)  AS lad_code,
    f.longitude,
    f.latitude,
    f.urban_or_rural_area,
    ur.label                           AS urban_rural,
    f.road_type,
    f.speed_limit,

    -- Severity
    f.collision_severity,
    sev_c.label                        AS collision_severity_label,
    c.casualty_severity,
    sev.label                          AS casualty_severity_label,

    -- Casualty
    c.casualty_class,
    cc.label                           AS casualty_class_label,
    c.sex_of_casualty,
    sx.label                           AS casualty_sex_label,
    c.age_of_casualty,
    c.casualty_type,

    -- Driver
    v.sex_of_driver,
    v.age_of_driver,
    v.age_band_of_driver,
    v.vehicle_type,

    -- IMD (based on the victim's LSOA of residence)
    i.imd_decile,
    i.imd_score,
    i.income_decile,
    i.employment_decile,
    i.education_decile,
    i.health_decile,
    i.crime_decile,
    c.lsoa_of_casualty
FROM stats19.fact_casualties c
JOIN stats19.fact_vehicles   v  USING (collision_index, vehicle_reference)
JOIN stats19.fact_collisions f  USING (collision_index)
LEFT JOIN stats19.dim_date             d     ON d.date_key  = f.date
LEFT JOIN stats19.dim_local_authority  la    ON la.lad_code = f.local_authority_ons_district
LEFT JOIN stats19.dim_urban_rural      ur    ON ur.code     = f.urban_or_rural_area
LEFT JOIN stats19.dim_severity         sev   ON sev.code    = c.casualty_severity
LEFT JOIN stats19.dim_severity         sev_c ON sev_c.code  = f.collision_severity
LEFT JOIN stats19.dim_casualty_class   cc    ON cc.code     = c.casualty_class
LEFT JOIN stats19.dim_sex              sx    ON sx.code     = c.sex_of_casualty
LEFT JOIN stats19.dim_imd              i     ON i.lsoa_code = c.lsoa_of_casualty;