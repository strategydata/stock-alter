FROM prefecthq/prefect:2-python3.10



# Set working Directory
WORKDIR /app
ENTRYPOINT ["bash"]

COPY . .



RUN pip install poetry==1.7.1
RUN poetry install --without dev --no-root && rm -rf $POETRY_CACHE_DIR
# RUN apt update \
#     & apt-get install sudo
# RUN apt-get upfate && apt-get install -y lsb-release && apt-get clean all
# RUN apt-get install apt-utils
