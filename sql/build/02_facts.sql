-- ============================================================
-- fact_collisions
-- ============================================================
CREATE OR REPLACE TABLE stats19.fact_collisions (
    collision_index              VARCHAR PRIMARY KEY,
    collision_year               SMALLINT,
    date                         DATE,
    year                         SMALLINT,
    month                        TINYINT,
    hour                         TINYINT,
    police_force                 VARCHAR,
    local_authority_ons_district VARCHAR,
    longitude                    DOUBLE,
    latitude                     DOUBLE,
    road_type                    TINYINT,
    urban_or_rural_area          TINYINT,
    light_conditions             TINYINT,
    weather_conditions           TINYINT,
    road_surface_conditions      TINYINT,
    first_road_class             TINYINT,
    speed_limit                  SMALLINT,
    junction_detail              TINYINT,
    number_of_vehicles           SMALLINT,
    number_of_casualties         SMALLINT,
    collision_severity           TINYINT
);

-- ============================================================
-- fact_vehicles
-- ============================================================
CREATE OR REPLACE TABLE stats19.fact_vehicles (
    collision_index              VARCHAR NOT NULL,
    vehicle_reference            SMALLINT NOT NULL,
    vehicle_type                 TINYINT,
    vehicle_manoeuvre            TINYINT,
    junction_location            TINYINT,
    skidding_and_overturning     TINYINT,
    first_point_of_impact        TINYINT,
    journey_purpose_of_driver    TINYINT,
    sex_of_driver                TINYINT,
    age_of_driver                SMALLINT,
    age_band_of_driver           TINYINT,
    engine_capacity_cc           INTEGER,
    propulsion_code              TINYINT,
    age_of_vehicle               SMALLINT,
    driver_imd_decile            TINYINT,
    lsoa_of_driver               VARCHAR,
    PRIMARY KEY (collision_index, vehicle_reference)
);

-- ============================================================
-- fact_casualties
-- ============================================================
CREATE OR REPLACE TABLE stats19.fact_casualties (
    collision_index              VARCHAR NOT NULL,
    vehicle_reference            SMALLINT NOT NULL,
    casualty_reference           SMALLINT NOT NULL,
    casualty_class               TINYINT,
    sex_of_casualty              TINYINT,
    age_of_casualty              SMALLINT,
    casualty_severity            TINYINT,
    casualty_type                TINYINT,
    pedestrian_location          TINYINT,
    pedestrian_movement          TINYINT,
    car_passenger                TINYINT,
    bus_or_coach_passenger       TINYINT,
    casualty_imd_decile          TINYINT,
    lsoa_of_casualty             VARCHAR,
    PRIMARY KEY (collision_index, vehicle_reference, casualty_reference)
);