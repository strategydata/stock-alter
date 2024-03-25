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

echo "Donwloading Google Cli and authorize gcloud"

curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-458.0.1-linux-x86_64.tar.gz >> google-cloud-cli.tar.gz

tar -xf google-cloud-cli.tar.gz \
    && ./google-cloud-sdk/install.sh \
    &&./google-cloud-sdk/bin/gcloud init \
    && gcloud auth login --cred-file=~/app/stock-alter/secrets/gcp_key.json



echo "Downloading Terraform"

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform


# echo "Downloading Prefect"
# pip install -U "prefect==2.10.4" && prefect version



prefect cloud login -k ~/app/stock-alter/secrets/prefect_key
export GOOGLE_APPLICATION_CREDENTIALS=~/app/stock-alter/secrets/gcp_key.json >> ~/.bashrc
export ALPHA_VANTAGE_API=~/app/stock-alter/secrets/alphavantage >> ~/.bashrc

# terraform init
# terraform plan -var="project_name=your_gcp_project_id" -var="region=your_region" -var="gcs_bucket_name=your_gcs_bucket_name" -var="bq_dataset_name=your_bq_dataset_name" -var="spark_cluster_name=your-spark-cluster-name"
# terraform apply -var="project_name=your_gcp_project_id" -var="region=your_region" -var="gcs_bucket_name=your_gcs_bucket_name" -var="bq_dataset_name=your_bq_dataset_name" -var="spark_cluster_name=your-spark-cluster-name"

python pipeline_deployment_build.py

echo "Onboarding script ran successfully"