from pathlib import Path
import pandas as pd
from prefect import flow, task
from prefect_gcp.cloud_storage import GcsBucket
from prefect.tasks import task_input_hash
from datetime import timedelta

@task(retries=3)
def fetch(dataset_url: str) -> pd.DataFrame:
    """Read csv from web"""
    df = pd.read_csv(dataset_url)
    return df

@task()
def clean(df: pd.DataFrame) -> pd.DataFrame:
    """Placeholder for any cleaning needing to be done."""
    df['tourney_date'] = pd.to_datetime(df['tourney_date'], format = '%Y%m%d')
    return df

@task()
def write_local(df: pd.DataFrame, dataset_file:str) -> Path:
    """Write dataframe as parquet file """
    path = Path(f"data/matches/{dataset_file}.parquet").as_posix()
    df.to_parquet(path, compression = 'gzip')
    return path

@task()
def write_gcs(path: Path) -> None:
    """Upload parquet file to GCS"""
    gcs_block = GcsBucket.load("tennis-bucket")
    gcs_block.upload_from_path(
        from_path =f"{path}",
        to_path = path
    )
    return   

@flow()
def etl_web_to_gcs(tour, subgroup, year) -> None:
    """The main ETL function"""
    dataset_file = f"{tour}_matches{subgroup}_{year}" #Challengers and futures should be have an underscore appended at the start of {subgroup}
    dataset_url = f"https://raw.githubusercontent.com/JeffSackmann/tennis_atp/master/{dataset_file}.csv"

    df = fetch(dataset_url)
    df_clean = clean(df)
    path = write_local(df_clean, dataset_file)
    write_gcs(path)

@flow()
def etl_matches_flow(
    tour: str = "atp",subgroup: str = "", years: list[int] = [2023], 
):
    for year in years:
        etl_web_to_gcs(tour, subgroup, year)
