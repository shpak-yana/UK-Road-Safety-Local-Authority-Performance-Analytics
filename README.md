# UK Road Safety — Local Authority Performance Analytics

[![Python](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/)
[![DuckDB](https://img.shields.io/badge/DuckDB-analytics-yellow.svg)](https://duckdb.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-ready-orange.svg)](https://powerbi.microsoft.com/)

End-to-end analysis of personal injury road collisions in **England** (2021–2025) using the official **STATS19** open data from the Department for Transport (DfT), enriched with the **English Indices of Deprivation 2025 (IMD 2025)** from the Ministry of Housing, Communities & Local Government (MHCLG).

The project focuses on **Local Authority performance**, identification of high-risk areas, vulnerable road users (VRUs), and the relationship between road casualties and socio-economic deprivation. Outputs include a clean analytical database (DuckDB), Parquet files optimised for Power BI, and a comprehensive dashboard with key findings.

> **Data coverage**: England only (IMD 2025 does not cover Wales, Scotland or Northern Ireland).  
> **Source period**: 2021–2025 (final validated STATS19 data).

---

## Project Objectives

- Assess national and regional trends in collisions and casualties (2021–2025)
- Benchmark Local Authorities on key safety metrics (Fatal / Serious / Slight / KSI)
- Link casualties to **LSOA-level deprivation** using IMD 2025
- Profile vulnerable road users (pedestrians, cyclists, motorcyclists)
- Produce clean, analysis-ready datasets and a dimensional (star-schema) model suitable for Power BI / DuckDB
- Support evidence-based recommendations for Local Authorities and the Department for Transport

---

## Key Findings (2021–2025)

| Metric                        | Value          |
|-------------------------------|----------------|
| Collisions                    | 493,271        |
| Casualties                    | 544,283        |
| Fatalities                    | 5,717          |
| Serious injuries              | 104,095        |
| Killed or Seriously Injured (KSI) | 109,812     |
| Overall KSI %                 | **20.18%**     |

### Highlights

- **Volume vs Severity**: The poorest IMD decile (1) accounts for 66,233 casualties vs 34,750 in the wealthiest (decile 10) — a factor of ~1.9×. However, **KSI% remains almost flat** (19–21.5%). The problem is frequency, not severity.
- **Motorcyclists**: Only ~7% of all casualties, but **KSI rate = 32.12%** (almost 1.6× the average). ~12,000 KSI over five years.
- **Age gradient**: KSI% rises sharply at the extremes — 16.9% (0–15) → 36.2% (75+).
- **Trend**: Collision volume relatively stable, but **KSI share rose from ~18.5% (2021) to 22.4% (2025)**.
- **Seasonality & urban/rural**: Clear summer peak; urban areas dominate absolute numbers, but rural areas show different severity patterns.
- **Geography**: Highest KSI% in Leeds (25.74%), Bradford (23.19%), North Yorkshire (22.39%). Highest absolute casualties in Birmingham, Leeds, Bradford.

Full interactive dashboard and static report available in the repository (`UK Road Analysis.pdf`).

---

## Data Sources

| Source              | Description                                      | Link |
|---------------------|--------------------------------------------------|------|
| **STATS19** (DfT)   | Collisions, Vehicles, Casualties (last 5 years)  | [Road Safety Open Data](https://www.gov.uk/government/statistical-data-sets/road-safety-open-data) |
| **IMD 2025** (MHCLG)| Index of Multiple Deprivation at LSOA level (England) | [English Indices of Deprivation 2025](https://www.gov.uk/government/statistics/english-indices-of-deprivation-2025) |
| Data Guide          | Official codebook for STATS19 categorical variables | `dft-road-casualty-statistics-road-safety-open-dataset-data-guide-2025.xlsx` |

**Note**: IMD 2025 covers England only. Records from Wales, Scotland and Northern Ireland are excluded from the IMD-enriched analysis.

---

## Repository Structure

|-- data/ \
|   |-- processed/            # Cleaned tables (CSV / Parquet)\
|   |-- powerbi/              # Optimised Parquet files for Power BI \
|-- sql/                      # DuckDB schema, views and analytical queries \
|-- STATS19_data_analysis.ipynb      # Loading, validation, cleaning \
|-- visual data analysis.ipynb       # Missingness EDA \
|-- db_load_data_and_analysis.ipynb  # DuckDB load + star schema \ 
|-- UK Road Analysis.pdf      # Power BI dashboard export (key findings) \
|-- dft-road-casualty-statistics-road-safety-open-dataset-data-guide-2025.xlsx # Official codebook for STATS19 categorical variables\
|-- README.md


---

## Data Pipeline Overview

1. **Ingest** — Load STATS19 Collision / Vehicle / Casualty files (last-5-years CSVs)
2. **Validate & Clean**
   - Remove duplicates
   - Replace sentinel values (`-1`, `99`, etc.) with `NaN`
   - Validate categorical codes against the official codebook
3. **Filter** — Retain England LSOA records only (for IMD join)
4. **Enrich** — Join casualties (and drivers) to IMD 2025 on `lsoa_code`
5. **Model** — Build star-schema style tables + analytical views in DuckDB
6. **Export** — Write Parquet files optimised for Power BI

### Key Cleaning Findings

| Dataset   | Missingness | Notes |
|-----------|-------------|-------|
| Vehicle   | ~13.8%      | Highest |
| Collision | ~12.4%      | Two fully empty columns in cleaned version |
| Casualty  | ~5.7%       | Lowest |

Missingness is largely **structural** (legacy `*_historic` fields retired, new fields introduced in later years). The year-based missingness heatmap shows a clear pattern: a column is either ~0% or ~100% missing within a given year, with a sharp transition at the point the schema changed.

---

## Data Model (DuckDB)

**Fact tables**
- `collisions`
- `vehicles`
- `casualties`

**Dimension tables**
- `imd_2025` (LSOA → Local Authority District + all domain deciles + population)

Additional derived views support common analytical patterns (KSI flags, age bands, vehicle type grouping, urban/rural, etc.).

---

## Getting Started

### Prerequisites
- Python 3.10+
- DuckDB
- Power BI Desktop 

### Quick start
```bash
# Clone the repository
git clone https://github.com/shpak-yana/UK-Road-Safety-Local-Authority-Performance-Analytics.git
cd UK-Road-Safety-Local-Authority-Performance-Analytics

# Install dependencies 
pip install duckdb pandas numpy matplotlib seaborn missingno pyarrow jupyter

# Run the notebooks in order
jupyter STATS19_data_analysis.ipynb
jupyter visual data analysis.ipynb
jupyter db_load_data_and_analysis.ipynb
```
Raw STATS19 files should be placed in data/raw/. Cleaned outputs and the DuckDB database can be regenerated from the notebooks.

---

## Power BI Dashboard

The included Power BI report (UK Road Analysis.pdf / [UK Road Analysis.pbix](https://github.com/shpak-yana/UK-Road-Safety-Local-Authority-Performance-Analytics/releases/tag/v1.0 ) contains:

- National overview (collisions, casualties, KSI, trends 2021–2025)
- Severity distribution & seasonality
- IMD-decile analysis (volume vs severity)
- Geographic map (urban/rural, Local Authority ranking)
- Demographics (age band, sex, vehicle type)
- Key findings summary page

---

## Tech Stack

- **Ingestion & Cleaning:** Python (pandas), official STATS19 codebook
- **Storage & Analytics:** DuckDB
- **Visualisation:** Power BI Desktop
- **Export:** Apache Parquet (columnar, Power BI optimised)

---

## Licence & Citation

Data is published by the UK Government under the Open Government Licence v3.0.

The original sources:

- Department for Transport – Road Safety Open Data (STATS19)
- Ministry of Housing, Communities & Local Government – English Indices of Deprivation 2025

