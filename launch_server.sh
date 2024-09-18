#!/bin/bash

# You may want to activate a new virtual environment before running this script, as it will install Python dependencies.

pip install -U mkdocs

reqs=$(mkdocs get-deps)

echo "Installing: " $reqs
pip install -U $reqs

echo "Starting server..."
mkdocs serve
