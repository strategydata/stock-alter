FROM prefecthq/prefect:2-python3.10

RUN pip install poetry==1.7.1


# Set working Directory
WORKDIR /app
COPY . .


# RUN poetry install --without dev --no-root && rm -rf $POETRY_CACHE_DIR
RUN poetry install --without dev

ENTRYPOINT ["bash"]

# RUN apt update \
#     & apt-get install sudo
# RUN apt-get upfate && apt-get install -y lsb-release && apt-get clean all
# RUN apt-get install apt-utils
