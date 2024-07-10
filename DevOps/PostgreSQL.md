# PostgreSQL


## PostgresSQL services in Docker
* **docker-compsoe.yaml**
```yaml
version: '3'

services:
  db:
    image: postgres
    environment:
      POSTGRES_USER: username
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydatabase
    ports:
      - "5432:5432"

  web:
    build: 
      context: .
      dockerfile: Dockerfiles/FlaskApp.Dockerfile
    ports:
      - "5000:5000"
    depends_on:
      - db
    environment:
      FLASK_APP: run.py
      FLASK_ENV: development
      DATABASE_URL: postgresql://username:password@db:5432/mydatabase
``` 
The Docker Compose file you provided does not include any explicit commands or scripts to create tables within mydatabase. Typically, tables are created using SQL commands (CREATE TABLE) or using **ORM (Object-Relational Mapping) frameworks like SQLAlchemy in Python**. If your Flask application uses an ORM like SQLAlchemy, you would define models which can then be used to create tables in the database automatically based on the model definitions.
** **Accessing service**
```bash
# Step 1: Find the Container ID or Name
docker ps

# Step 2: Access PostgreSQL Shell
docker exec -it postgres_container bash

# Step 3: Access PostgreSQL Database
psql -U postgres

# Step 4: Run PostgreSQL Commands
\l   -- List all databases
\dt  -- List all tables in the current database
SELECT * FROM tablename;  -- Example query

# Step 5: Exit the PostgreSQL Shell and Container
\q
exit
```

## Commands
### Database Operations

* **CREATE DATABASE dbname;** - Create a new database.
* **DROP DATABASE dbname;** - Delete an existing database.
* **\l** - List all databases.
* **\c dbname;** - Connect to a specific database.
* **\dt;** - List all tables in the current database.

### Table Operations

* **CREATE TABLE tablename (column1 datatype, column2 datatype);** - Create a new table.
* **DROP TABLE tablename;** - Delete an existing table.
* **ALTER TABLE tablename ADD columnname datatype;** - Add a new column to an existing table.
* **ALTER TABLE tablename DROP COLUMN columnname;** - Remove a column from an existing table.
* **\d tablename;** - Show the structure of a table.
* **\di;** - List indexes.

### Data Manipulation

* **INSERT INTO tablename (column1, column2) VALUES (value1, value2);** - Insert a new row into a table.
* **UPDATE tablename SET column1 = value1 WHERE condition;** - Update existing records in a table.
* **DELETE FROM tablename WHERE condition;** - Delete rows from a table.
* **SELECT * FROM tablename;** - Retrieve all records from a table.
* **SELECT column1, column2 FROM tablename WHERE condition;** - Retrieve specific columns from a table based on conditions.
* **COPY tablename TO 'filename';** - Export table data to a file.
* **COPY tablename FROM 'filename';** - Import data from a file into a table.

### Transaction Control

* **BEGIN;** - Start a new transaction block.
* **COMMIT;** - Save changes to the database.
* **ROLLBACK;** - Roll back a transaction.

### User and Permissions Management

* **CREATE ROLE username WITH PASSWORD 'password';** - Create a new user role with a password.
* **DROP ROLE username;** - Remove an existing user role.
* **GRANT permission ON object TO role;** - Grant permissions to a user role.
* **REVOKE permission ON object FROM role;** - Revoke permissions from a user role.
* **\du;** - List all roles (users).

### Indexes

* **CREATE INDEX indexname ON tablename (columnname);** - Create an index on a table column.
* **DROP INDEX indexname;** - Remove an index.

### Schema Management

* **CREATE SCHEMA schemaname;** - Create a new schema.
* **DROP SCHEMA schemaname;** - Remove a schema.
* **ALTER SCHEMA schemaname RENAME TO new_schemaname;** - Rename a schema.

### Views

* **CREATE VIEW viewname AS SELECT column1, column2 FROM tablename WHERE condition;** - Create a new view.
* **DROP VIEW viewname;** - Remove a view.
* **\dv;** - List all views.

### Functions and Procedures

* **CREATE FUNCTION functionname (parameters) RETURNS return_type AS bodybody LANGUAGE plpgsql;** - Create a new function.
* **DROP FUNCTION functionname;** - Remove a function.
* **\df;** - List all functions.

### Monitoring and Diagnostics

* **\l** - List all databases.
* **\conninfo;** - Display connection information.
* **\dt** - List all tables in the current database.
* **\d+ tablename;** - Show detailed information about a table.

### Miscellaneous

* **\timing** - Enable or disable timing of query execution.
* **! command** - Execute a shell command from within psql.
* **\q** - Quit psql.
