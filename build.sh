#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
pip install -r requirements.prod.txt

# Collect static files
python django_app/manage.py collectstatic --no-input

# Run migrations
python django_app/manage.py migrate
