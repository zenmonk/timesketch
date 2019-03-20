#!/bin/bash
#
# Script to run tests on Travis-CI.
#
# This file is generated by l2tdevtools update-dependencies.py, any dependency
# related changes should be made in dependencies.ini.

# Exit on error.
set -e;

if test "${TARGET}" = "pylint";
then
	pylint --version

	for FILE in `find run_tests.py setup.py api_client config timesketch -name \*.py`;
	do
		echo "Checking: ${FILE}";

		pylint --rcfile=.pylintrc ${FILE};
	done

	for FILE in `find api_client -name \*.py`;
	do
		echo "Checking: ${FILE}";

		PYTHONPATH=api_client/python pylint --rcfile=.pylintrc ${FILE};
	done

elif test "${TRAVIS_OS_NAME}" = "linux";
then
	python ./run_tests.py --full

	yarn run build
fi