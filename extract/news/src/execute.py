import logging
import sys
from api import NewsAPI

from secret_api import(
    NEWS_API_TOKEN
)

from amberdata.orchestration_utils import (
    push_to_xcom_file,
    query_executor,
    snowflake_engine_factory,
    snowflake_stage_load_copy_remove,
)

if __name__=="__main__":
    logging.basicConfig(stream=sys.stdout, level=20)
    # record_counts store the data
    record_counts = {}
    newsapi = NewsAPI(api_token=NEWS_API_TOKEN)
    logging.info("Getting Premier League News")
    record_counts["premier_league"]=newsapi.get_premier_league()
    push_to_xcom_file(record_counts)