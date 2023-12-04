# Tennis Analytics Pipeline
- [Introduction](#introduction)
- [Data Source](#data-source)
- [Technology Stack](#technology-stack)
- [Data Pipeline](#data-pipeline)
- [Reporting](#reporting)

## Introduction
This project builds a batch extract, load, and transform (ELT) pipeline to gather tennis match-level data for the ATP main tour and Challengers tour and prepares it for visualization in a dashboard. During the tennis season (approximately January - November), this pipeline is orchestrated to run on a weekly schedule to provide answers to questions like:

- What players are performing best in the current season?
- What players on the Challengers Tour are likely candidates as the next "up and coming" players?
- What players perform best under pressure?
- What players have served up the most bagels over their career? 

## Data Source
This project relies on Jeff Sackman's [tennis match data](https://github.com/JeffSackmann/tennis_atp) repos, which are updated on roughly a weekly basis during the tennis season. The pipeline extracts ATP main tour level data from 1968 through the current season and Challengers data from 1978 through the current season. While match outcomes are available for all years, match statistics (e.g., number of aces, number of break points, etc.) are generally only avaiable from the mid-1990s onwards. 

## Technology Stack
- [Python/Pandas](https://pandas.pydata.org/): Extraction and loading of raw data from data source to the data lake and data warehouse.
- [Google Cloud Platform (GCP)](https://cloud.google.com/): Storage of raw files in a Google Cloud Storage bucket and utilizng BigQuery as our data warehouse.
- [Terraform](https://www.terraform.io/): Creating our GCP infrastructure as code.
- [Prefect](https://www.prefect.io/): Orchestration and monitoring of the ELT pipeline.
- [dbt](https://www.getdbt.com/): Staging and transformation of the data in BigQuery.
- [Looker Studio](https://lookerstudio.google.com/overview): Creating the analytics dashboard.

## Data Pipeline

## Reporting
