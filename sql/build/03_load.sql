-- ============================================================
-- Loading from Parquet. We explicitly list the columns
-- so that the order in the file does not matter.
-- ============================================================

INSERT INTO stats19.fact_collisions
SELECT
    collision_index,
    collision_year,
    CAST(date AS DATE),
    year,
    month,
    hour,
    police_force,
    local_authority_ons_district,
    longitude,
    latitude,
    road_type,
    urban_or_rural_area,
    light_conditions,
    weather_conditions,
    road_surface_conditions,
    first_road_class,
    speed_limit,
    junction_detail,
    number_of_vehicles,
    number_of_casualties,
    collision_severity
FROM read_parquet('data/processed/collisions.parquet');

INSERT INTO stats19.fact_vehicles
SELECT
    collision_index,
    vehicle_reference,
    vehicle_type,
    vehicle_manoeuvre,
    junction_location,
    skidding_and_overturning,
    first_point_of_impact,
    journey_purpose_of_driver,
    sex_of_driver,
    age_of_driver,
    age_band_of_driver,
    engine_capacity_cc,
    propulsion_code,
    age_of_vehicle,
    driver_imd_decile,
    lsoa_of_driver
FROM read_parquet('data/processed/vehicles.parquet');

INSERT INTO stats19.fact_casualties
SELECT
    collision_index,
    vehicle_reference,
    casualty_reference,
    casualty_class,
    sex_of_casualty,
    age_of_casualty,
    casualty_severity,
    casualty_type,
    pedestrian_location,
    pedestrian_movement,
    car_passenger,
    bus_or_coach_passenger,
    casualty_imd_decile,
    lsoa_of_casualty
FROM read_parquet('data/processed/casualties.parquet');

INSERT INTO stats19.dim_imd
SELECT
    lsoa_code,
    lsoa_name,
    lad_code,
    lad_name,
    imd_score,
    imd_rank,
    imd_decile,
    income_decile,
    employment_decile,
    education_decile,
    health_decile,
    crime_decile,
    barriers_decile,
    environment_decile,
    population
FROM read_parquet('data/processed/imd_2025.parquet');