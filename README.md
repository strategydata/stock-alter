# Stock Alter and Dashboard

this repo contains my final project for the [Data Engineering Zoomcamp by DataTalksClub](https://github.com/DataTalksClub/data-engineering-zoomcamp). I built a batch data pipeline and streaming pipeline that extract, transforms and loads the Finnhub and Twitter dataset into 

## Index


## problem description



this is a simple project which takes data from finnhub and twitter and transforms it in order to visualize the stock data

## Project architechture



## Dataset

[dataset](https://finnhub.io/docs/api) finnhub and [twitter](https://developer.twitter.com/en/docs/twitter-api) for this project 

## Dashboard

the dashboard is public available in this [link]()

## Project details and implementation

this project makes use of Google Cloud Platform,
## Key findings


## Technologies

- Python
- Prefect
- Terraform
- Docker
- Google

## Reproduce the project

### Prerequisites

### Google Cloud Project

## Future


## How to deploy


### Step 1 - Set up

- replace the gcp_key.json file inside the secrets folder with your own key.

- Build docker image
```docker
docker build -t amber_data_stock .
```

- Create container from image/start the container

```docker
docker run -itd --name amber_data_stock amber_data_stock
```
<!-- - start the container.
```docker
docker start -i amber_data_stock
``` -->

- install the gcloud cli and authorize gcloud with browser

- install terraform

- connect to prefect cloud with ur key.
```bash
prefect cloud login -k $(<~/Project/stock-alter/secrets/prefect_key)
```

- Set environmental variable for GCP key
```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/Project/stock-alter/secrets/gcp_key.json
```

### Step 2 - Create GCP resources with Terraform

- navigate inside the infra folder.
```bash
cd infra/live/stage
```

- run folloing commands and follow instructions

```bash
terraform init

terraform plan \
-var-file="variables.tfvars"

terraform apply \
-var-file="variables.tfvars"

```


