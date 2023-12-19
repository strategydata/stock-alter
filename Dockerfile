FROM python:3.10.12

RUN curl -sSL https://install.python-poetry.org | python3 - --version 1.7.1
ENV PATH="/root/.local/bin:$PATH"

# Set working Directory
WORKDIR /app
COPY . .
# ENTRYPOINT ["bash"]

RUN poetry install --no-root


# Install and update os tools
# RUN apt update
# RUN apt-get install sudo
# RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
# RUN apt-get install apt-utils


# RUN apt update \
#     & apt-get install sudo
# RUN apt-get upfate && apt-get install -y lsb-release && apt-get clean all
# RUN apt-get install apt-utils
# RUN wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
# RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
# RUN apt update && sudo apt install terraform
# RUN apt-get update && sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
# RUN prefect cloud login -k 
