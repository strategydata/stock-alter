FROM python:3.10.12

RUN apt update \
    && apt install pipx==1.0.0 \
    && pipx ensurepath \
    && pipx install poetry==1.7.1


# Set working Directory
WORKDIR /app
COPY . .
ENTRYPOINT ["bash"]

RUN poetry install --without dev --no-root && rm -rf $POETRY_CACHE_DIR
RUN poetry install --without dev

RUN apt update \
    & apt-get install sudo
RUN apt-get upfate && apt-get install -y lsb-release && apt-get clean all
RUN apt-get install apt-utils