#!/bin/bash

# This script initializes and updates the database schema for a Flask application,
# then starts the Flask development server.

# Remove the existing migrations folder if it exists
# This ensures a clean start for the database migration process
rm -rf migrations

# Initialize the migrations folder and create initial migration files
# This sets up the necessary structure for Flask-Migrate to manage database schema changes
flask db init

# Create an initial migration with a descriptive message
# This generates a migration script based on the current state of your models
flask db migrate -m "Initial migration with updated column lengths"

# Upgrade the database to apply the initial migration
# This executes the migration script, updating the database schema
flask db upgrade

# Start the Flask application
# The application will be accessible from any IP address (0.0.0.0) on port 5000
flask run --host=0.0.0.0 --port=5000


