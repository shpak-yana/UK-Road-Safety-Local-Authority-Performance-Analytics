# UK Road Safety Local Authority Performance Analytics

The project analyzes road traffic accident data for the UK over the past five years (2021–2025), utilizing the open **STATS19** dataset from the Department for Transport (DfT).

**Project Objectives:**
- Assess trends in road accidents at both national and regional levels.
- Compare the performance of Local Authorities and Police Forces across key safety metrics.
- Identify accident "hotspots" mapped to LSOA (Lower Layer Super Output Area) boundaries.
- Examine the profiles of vulnerable road users (VRUs): pedestrians, cyclists, and motorcyclists.

## Data

The data is loaded from the official [Road Safety Open Data page](https://www.gov.uk/government/statistical-data-sets/road-safety-open-data).

| Data type | File name |
|-----------|-----------|
| Collisions |	dft-road-casualty-statistics-collision-last-5-years.csv |
| Vehicles	| dft-road-casualty-statistics-vehicle-last-5-years.csv |
| Casualties	| dft-road-casualty-statistics-casualty-last-5-years.csv |

A codebook is used to validate categorical codes:

dft-road-casualty-statistics-road-safety-open-dataset-data-guide-2025.xlsx, sheet 2024_code_list

After cleaning, the processed files are saved to:

- data/processed/casualty_clean.csv
- data/processed/collision_clean.csv
- data/processed/vehicle_clean.csv

### 1. Input Data Analysis & Cleaning

Two notebooks cover preprocessing and exploratory data quality checks:

- **`STATS19_data_analysis.ipynb`** — loads raw STATS19 CSV files (casualty, collision, vehicle), checks for duplicates (none found), validates categorical codes against the codebook, replaces sentinel/invalid numeric values (`-1`, `99`, etc.) with `NaN`, and saves cleaned tables to `data/processed/`.
- **`visual data analysis.ipynb`** — performs missingness EDA using bar charts, `missingno` matrices, and year-based heatmaps to inspect how missing values are distributed across columns and years.

**Key findings:**
- Highest missingness: `vehicle` (13.83%) → `collision` (12.36%) → `casualty` (5.65%).
- `collision` has 2 fully empty columns: `local_authority_highway` and `local_authority_ons_district`.
- Fields often missing together: historical vs current variants (e.g., `junction_detail` + `junction_detail_historic`), and age / age band fields.


Missingness in STATS19 is overwhelmingly structural and driven by two mechanisms:

- Legacy fields (*_historic) are populated only in early years of the window and then retired.
- New fields (enhanced_*, casualty_distance_banding, casualty_injury_based) appear only in recent years.

The "% missing by year" heatmap makes this pattern explicit: a column is either ~0 % or ~100 % missing within a given year, with a sharp transition at the point the schema changed.

<img width="1149" height="328" alt="heatmap" src="https://github.com/user-attachments/assets/1fc98987-a31c-4889-a54c-f52a72d55af4" />





