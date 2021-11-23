.DEFAULT_GOAL := help

setup:
	@poetry env use 3.9; poetry install

.PHONY: help prerelease release

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

test:
	@poetry run pytest -vv tests/

cov:
	@poetry run pytest  tests/ -vv --cov=incolumepy_prospect_translate_python_gnu_gettext --cov-report='html'

clean:
	@echo -n "Cleanning environment .."
	@find ./ -name '*.pyc' -exec rm -f {} \;
	@find ./ -name '*~' -exec rm -f {} \;
	@find ./ -name 'Thumbs.db' -exec rm -f {} \;
	@find ./ -name '*.log' -exec rm -f {} \;
	@find ./ -name ".cache" -exec rm -fr {} \;
	@find ./ -name "*.egg-info" -exec rm -rf {} \;
	@find ./ -name "*.coverage" -exec rm -rf {} \;
	@rm -rf ".pytest_cache"
	@rm -rf docs/_build
	@echo " Ok."

clean-all: clean
	@echo -n "Deep cleanning .."
	@rm -rf dist
	@rm -rf build
	@rm -rf htmlcov
	@rm -rf .tox
	@#fuser -k 8000/tcp &> /dev/null
	@echo " Ok."

format: clean
	@poetry run black $(find -name "*incolume*") tests/

prerelease:
	@v=$$(poetry version prerelease); poetry run pytest -v tests/ && git ci -m "$$v" pyproject.toml $$(find -name version.txt)  #sem tag

release:
	@msg=$$(poetry version patch); poetry run pytest -v tests/ && git ci -m "$$msg" pyproject.toml $$(find -name "version.txt") && git tag -f $$(poetry version -s) -m "$$msg"  #com tag
	@git checkout main
	@git merge --no-ff --autostash -m "$$msg" dev && git tag -f $$(poetry version -s) -m "$$msg"
