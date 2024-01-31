
import logging
from pandas import DataFrame
from datetime import datetime, timedelta

from pandas import DataFrame

from secret import (
    NEWS_API_TOKEN
)

def create_dataframe() -> DataFrame:
    # Getting yesterday's date.
	yesteryday = datetime.now() - timedelta(days=1)
    
	df = DataFrame(
    {
            
        }
    ).sort_values(by="",ascending=False)
    # yesteryday.strftime("%Y-%m-%d")
    # response = requests.request("GET",url,timeout=20)
    # res= response.json()
    return df