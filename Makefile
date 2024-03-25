GIT_BRANCH = $$(git symbolic-ref --short HEAD)



help:
	@echo "\n \
	------------------------------------------------------------ \n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
	++ Airflow Related ++ \n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
    - airflow: attaches a shell to the airflow deployment in docker-compose.yml. Access the webserver at localhost:8080\n \
    - init-airflow: initializes a new Airflow db and creates a generic admin user, required on a fresh db. \n \
	\n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
	++ Utilities ++ \n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
    - cleanup: WARNING: DELETES DB VOLUME, frees up space and gets rid of old containers/images. \n \
    - update-containers: Pulls fresh versions of all of the containers used in the repo. \n \
    - data-image: Attaches to a shell in the data-image and mounts the repo for testing. \n \
	\n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
	++ dbt Related ++ \n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
    - run-dbt: attaches a shell to the dbt virtual environment and changes to the dbt directory. \n \
    - run-dbt-docs: spins up a webserver with the dbt docs. Access the docs server at localhost:8081 \n \
    - clean-dbt: deletes all virtual environment artifacts \n \
    - pip-dbt-shell: opens the poetry environment in the dbt folder. Primarily for use with sql fluff. \n \
	\n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
	++ Python Related ++ \n \
	++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n \
    - black: Runs a linter (Black) over the whole repo. \n \
    - yq-lint: Runs a linter against a YAML file. Pass in the file with the variable YAML. Example: make yq-lint YAML=extract/postgres_pipeline/manifests/gitlab_com_db_manifest.yaml \n \
    - mypy: Runs a type-checker in the extract dir. \n \
    - pylint: Runs the pylint checker over the whole repo. Does not check for code formatting, only errors/warnings. \n \
    - complexity: Runs a cyclomatic complexity checker that will throw a non-zero exit code if the criteria aren't met. \n \
    - flake8: Run flake8 library to check Python code \n \
    - vulture: Run vulture library to check unused code \n \
    - pytest: run all pytest cases \n \
    - python_code_quality: integrate one command to run ALL python check (from the previous commands) \n \
    - clean-python: clean up python code and delete cache directories/files \n \
	------------------------------------------------------------"

#######################################################################################################
# Airflow
#######################################################################################################
	



#######################################################################################################
# Python
#######################################################################################################

prepare-python:
	which poetry || python3 -m pip install poetry
	poetry install

mypy:
	@echo "Running mypy..."
	@poetry run mypy extract/ --ignore-missing-imports

pytest:
	@echo "Running pytest ...."
	@poetry run python3 -m pytest -vv -x


vulture:
	@echo "Running vulture"
	@poetry run vulture . --min-confidence 100







