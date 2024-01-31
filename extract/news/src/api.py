import json
import requests
import sys
from typing import Dict, Any

class NewsAPI:
    """
    Initialized with subdomain and an API key. 
    Currently just allows for fetching from the directory and from tabular data.
    """
    def __init__(self,api_token=None,timeout=120) -> None:
        self.base_url = f"https://newsapi.org/v2/everything?language=en&sortBy=popularity&apiKey={api_token}/"
        if api_token is not None:
            self.api_token=api_token
        else:
            raise Exception("News API token not configured")
        self.timeout=timeout
    
    def get_premier_league(self) -> Dict[Any,Any]:
        """
        API method for returning a globally shared company directory.
        https://newsapi.org/v2/everything?q=premier league
        @return: A list of employee dictionaries which is a list of Premier League news in the directory.
        """
        url = self.base_url+"q=premier league"
        r = requests.get(url,timeout=self.timeout)
        r.raise_for_status()
        data=r.json()
        self.quality_check(data)
        return data["articles"]
        
    
    def quality_check(self,json_response:Dict[Any,Any]) -> None:
        """
        Sanity check on JSON response object for data integrity
        """
        record_count=len(json_response["articles"])
        if record_count <2 :
            sys.exit(1)