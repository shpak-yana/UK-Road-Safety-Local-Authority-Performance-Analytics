-- LA reference data from IMD: the `collisions.local_authority_ons_district` column is empty,
-- so the only reliable source for LAD is `imd_2025`.
DELETE FROM stats19.dim_local_authority;

INSERT INTO stats19.dim_local_authority (lad_code, lad_name)
SELECT DISTINCT lad_code, lad_name
FROM stats19.dim_imd
WHERE lad_code IS NOT NULL;