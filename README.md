# UK Road Safety — Local Authority Performance Analytics

[![Python](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/)
[![DuckDB](https://img.shields.io/badge/DuckDB-analytics-yellow.svg)](https://duckdb.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-ready-orange.svg)](https://powerbi.microsoft.com/)

End-to-end analysis of personal injury road collisions in Great Britain (2021–2025) using the official **STATS19** open data from the Department for Transport, enriched with the **English Indices of Deprivation 2025 (IMD 2025)**.

The project focuses on **Local Authority performance**, identification of high-risk areas, vulnerable road users, and the relationship between road casualties and socio-economic deprivation.

---

## Project Objectives

- Assess national and regional trends in collisions and casualties (2021–2025)
- Benchmark Local Authorities on key safety metrics (fatal / serious / slight)
- Link casualties to **LSOA-level deprivation** using IMD 2025
- Profile vulnerable road users (pedestrians, cyclists, motorcyclists)
- Produce clean, analysis-ready datasets and a dimensional model suitable for Power BI / DuckDB
- Support evidence-based recommendations for Local Authorities and DfT

---

## Data Sources

| Source | Description | Link |
|--------|-------------|------|
| **STATS19** (DfT) | Collisions, Vehicles, Casualties (last 5 years) | [Road Safety Open Data](https://www.gov.uk/government/statistical-data-sets/road-safety-open-data) |
| **IMD 2025** (MHCLG) | Index of Multiple Deprivation at LSOA level (England) | [English Indices of Deprivation 2025](https://www.gov.uk/government/statistics/english-indices-of-deprivation-2025) |
| Data Guide | Official codebook for STATS19 categorical variables | `dft-road-casualty-statistics-road-safety-open-dataset-data-guide-2025.xlsx` |

**Note:** IMD 2025 covers England only. Welsh records use WIMD (not included in this version).

---

## Repository Structure

├── data/
│   ├── raw/                  # Original STATS19 CSVs (not tracked)
│   └── processed/            # Cleaned parquet files
├── notebooks/
│   ├── STATS19_data_analysis.ipynb      # Loading, validation, cleaning
│   └── visual_data_analysis.ipynb       # Missingness EDA
├── sql/                      # DuckDB schema & views (optional)
├── powerbi_export/           # Parquet files ready for Power BI
├── road_safety.duckdb        # Analytical database
└── README.md


---

## Data Pipeline Overview

1. **Ingest** — Load STATS19 Collision / Vehicle / Casualty files
2. **Validate & Clean**
   - Remove duplicates
   - Replace sentinel values (`-1`, `99`, etc.) with `NaN`
   - Validate categorical codes against official codebook
3. **Filter** — Keep England LSOA records for IMD join
4. **Enrich** — Join casualties & drivers to IMD 2025 on `lsoa_code`
5. **Model** — Star-schema style tables + analytical views in DuckDB
6. **Export** — Parquet files optimised for Power BI

### Key Cleaning Findings

| Dataset   | Missingness | Notes |
|-----------|-------------|-------|
| Vehicle   | ~13.8%      | Highest |
| Collision | ~12.4%      | Two fully empty columns in cleaned version |
| Casualty  | ~5.7%       | Lowest |

Missingness is largely **structural** (legacy `*_historic` fields retired, new fields introduced in later years).

The "% missing by year" heatmap makes this pattern explicit: a column is either ~0 % or ~100 % missing within a given year, with a sharp transition at the point the schema changed.

<img width="1149" height="328" alt="heatmap" src="https://github.com/user-attachments/assets/1fc98987-a31c-4889-a54c-f52a72d55af4" />

---

## Data Model (DuckDB)

**Fact tables**
- `collisions`
- `vehicles`
- `casualties`

**Dimension**
- `imd_2025` (LSOA → LAD + all domain deciles + population)






