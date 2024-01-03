#! /bin/bash

echo "Downloading python 3.10.12"


curl https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz >> Python-3.tgz

echo "Downloading python 3.10.12" \
    && tar -xvzf Python-3.tgz \
    && cd Python-3 \
    && ./configure \
    --prefix=/opt/python/3.10.12 \
    --enable-shared \
    --enable-optimizations \
    --enable-ipv6 \
    LDFLAGS=-Wl,-rpath=/opt/python/3.10.12/lib,--disable-new-dtags \
    && make \
    && sudo make install


rm Python-3.tgz
echo "Python succesfully installed"

prefect cloud login -k ~/project/stock-alter/secrets/prefect_key
export GOOGLE_APPLICATION_CREDENTIALS=~/Project/stock-alter/secrets/gcp_key.json >> ~/.bashrc
export ALPHA_VANTAGE_API=~/Project/stock-alter/secrets/alphavantage >> ~/.bashrc
export ALPHA_VANTAGE_API=~/Project/stock-alter/secrets/prefect_key >> ~/.bashrc
terraform init
terraform plan -var="project_name=your_gcp_project_id" -var="region=your_region" -var="gcs_bucket_name=your_gcs_bucket_name" -var="bq_dataset_name=your_bq_dataset_name" -var="spark_cluster_name=your-spark-cluster-name"
terraform apply -var="project_name=your_gcp_project_id" -var="region=your_region" -var="gcs_bucket_name=your_gcs_bucket_name" -var="bq_dataset_name=your_bq_dataset_name" -var="spark_cluster_name=your-spark-cluster-name"

python pipeline_deployment_build.py

echo "Onboarding script ran successfully"