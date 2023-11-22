from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect_gcp import GcpCredentials

@task(retries=3)
def fetch(dataset_url: str) -> pd.DataFrame:
    """Read csv from web"""
    df = pd.read_csv(dataset_url)
    return df

@task()
def clean(df: pd.DataFrame) -> pd.DataFrame:
    """Converting tourney_date to datetime"""
    df['tourney_date'] = pd.to_datetime(df['tourney_date'], format = '%Y%m%d')
    return df

@task()
def write_bq(df: pd.DataFrame,dest_tab: str) -> None:
    """Write DataFrame to BiqQuery"""

    gcp_credentials_block = GcpCredentials.load("tennis-creds")

    df.to_gbq(
        destination_table= dest_tab,
        project_id= 'tennis-analysis-405301',
        credentials = gcp_credentials_block.get_credentials_from_service_account(),
        chunksize=500_000,
        if_exists="append",
    )

@flow()
def etl_gcs_to_bq(tour:str, subgroup:str, year:int, dest_tab:str):
    """Main ETL flow to load data into Big Query"""
    dataset_file = f"{tour}_matches{subgroup}_{year}" #Challengers and futures should be have an underscore appended at the start of {subgroup}
    dataset_url = f"https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/{dataset_file}.csv"

    df = fetch(dataset_url)
    df = clean(df)
    write_bq(df,dest_tab)
    
@flow()
def etl_bq_matches_flow(
    tour: str = "atp",subgroup: str = "", years: list[int] = [2023], dest_tab: str = 'tennis_data.atp_tour' 
):
    for year in years:
        etl_gcs_to_bq(tour, subgroup, year, dest_tab)