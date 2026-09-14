# UK-Road-Safety-Local-Authority-Performance-Analytics
Analysis of road traffic accidents (STATS19) and socio-economic factors to identify high-risk areas and develop recommendations for local authorities and the Department for Transport.

## Step 1. Loading and initial data exploration

The data is loaded from the official [Road Safety Open Data page](https://www.gov.uk/government/statistical-data-sets/road-safety-open-data).

| Data type | File name |
|-----------|-----------|
| Collisions |	dft-road-casualty-statistics-collision-last-5-years.csv |
| Vehicles	| dft-road-casualty-statistics-vehicle-last-5-years.csv |
| Casualties	| dft-road-casualty-statistics-casualty-last-5-years.csv |

Three STATS19 tables follow this logic:

| Table |	Row describes	| Number of columns |
|-------|---------------|------------|
| Collisions | One traffic accident (location, time, conditions) | 44 |
| Vehicles | One vehicle involved in the traffic accident | 32 |
| Casualties | One person injured in a traffic accident | 23 |

