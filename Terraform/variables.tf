locals {
  data_lake_bucket = "tennis_data_lake"
}

variable "project" {
  description = "Your GCP Project ID"
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default = "us-east1"
  type = string
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to."
  type = string
  default = "tennis_data"
}
variable "BQ_STAGING_DATASET" {
  description = "BigQuery Dataset that will serve as staging."
  type = string
  default = "staging"
}

variable "BQ_PRODUCTION_DATASET" {
  description = "BigQuery Dataset that will serve as production for final tables."
  type = string
  default = "production"
}