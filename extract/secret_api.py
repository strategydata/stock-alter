from prefect.blocks.system import Secret

# Alpha vantage API
ALPHAVANTAGE_API_TOKEN=Secret.load("alphavantage").get()

# news api
NEWS_API_TOKEN = Secret.load("newsapi").get()

