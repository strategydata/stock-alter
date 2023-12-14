# Create variable names

variable "project_name" {
    description = "GCP project id"
    type = string
}

variable "region" {
    description = "region for GCP resources. Choose as per your location"
    type = string
}

variable "gcs_bucket_name" {
    description = "GCS bucket name"
    type = string
}

variable "storage_class" {
    description = "storage class type for your bucket"
    type = string
}

variable "bq_dataset_name" {
    description = "BQ dataset name"
    type = string
}

variable "spark_cluster_name" {
  description = "dataProc cluster name"
  type = string
}