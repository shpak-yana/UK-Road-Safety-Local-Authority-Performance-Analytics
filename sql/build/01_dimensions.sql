-- ============================================================
-- dim_imd
-- ============================================================
CREATE OR REPLACE TABLE stats19.dim_imd (
    lsoa_code            VARCHAR PRIMARY KEY,
    lsoa_name            VARCHAR,
    lad_code             VARCHAR,
    lad_name             VARCHAR,
    imd_score            DOUBLE,
    imd_rank             INTEGER,
    imd_decile           INTEGER,
    income_decile        INTEGER,
    employment_decile    INTEGER,
    education_decile     INTEGER,
    health_decile        INTEGER,
    crime_decile         INTEGER,
    barriers_decile      INTEGER,
    environment_decile   INTEGER,
    population           INTEGER
);

-- ============================================================
-- dim_local_authority
-- ============================================================
CREATE OR REPLACE TABLE stats19.dim_local_authority (
    lad_code          VARCHAR PRIMARY KEY,
    lad_name          VARCHAR,
    region            VARCHAR,
    highway_authority VARCHAR
);

-- ============================================================
-- dim_date
-- ============================================================
CREATE OR REPLACE TABLE stats19.dim_date (
    date_key     DATE PRIMARY KEY,
    year         SMALLINT,
    quarter      TINYINT,
    month        TINYINT,
    month_name   VARCHAR,
    day          TINYINT,
    day_of_week  TINYINT,
    day_name     VARCHAR,
    is_weekend   BOOLEAN
);

-- ============================================================
-- STATS19 reference tables (for Power BI — to ensure the report displays
-- human-readable labels instead of codes)
-- ============================================================
CREATE OR REPLACE TABLE stats19.dim_severity (
    code SMALLINT PRIMARY KEY,
    label VARCHAR
);
INSERT INTO stats19.dim_severity VALUES
    (1, 'Fatal'),
    (2, 'Serious'),
    (3, 'Slight');

CREATE OR REPLACE TABLE stats19.dim_casualty_class (
    code SMALLINT PRIMARY KEY,
    label VARCHAR
);
INSERT INTO stats19.dim_casualty_class VALUES
    (1, 'Driver or rider'),
    (2, 'Passenger'),
    (3, 'Pedestrian');

CREATE OR REPLACE TABLE stats19.dim_urban_rural (
    code SMALLINT PRIMARY KEY,
    label VARCHAR
);
INSERT INTO stats19.dim_urban_rural VALUES
    (1, 'Urban'),
    (2, 'Rural');

CREATE OR REPLACE TABLE stats19.dim_sex (
    code SMALLINT PRIMARY KEY,
    label VARCHAR
);
INSERT INTO stats19.dim_sex VALUES
    (1, 'Male'),
    (2, 'Female'),
    (9, 'Unknown'),
    (-1, 'Missing');