## Project Milestone 1

Homework documentation in separate file
JSON files are not included here (too large to be committed), but are in canvas

Terminal Steps:

Part 2 (ermodeldb)
- Create DB "sudo -u postgres createdb ermodeldb"
- Grant privledges to user: "sudo -u postgres psql -d ermodeldb -c "GRANT ALL PRIVILEGES ON SCHEMA public TO username;"
- Create tables from sql file "psql -d ermodeldb -f ~/filepath/.sql" 
- View tables: psql -d ermodeldb -c "\dt"
- View individual schema: "psql -d ermodeldb -c "\d SchemaName"
- db reset built in to sql code 
- Delete db: sudo -u postgres dropdb milestone1db

Part 3
- psql -d milestone1db
- Copy from csv: \copy Business (name,state,city) FROM '~/cpts451/ProjectMilestone1/milestone1DB.csv' DELIMITER ',' CSV QUOTE '"' 
- View table: "\dt"
- View entries in db: "SELECT * FROM Business LIMIT X;"
- Exit psql: \q

-Run python commands: (after installing PyQt6)
- source .venv/bin/activate
- run designer gui: QT_QPA_PLATFORM=xcb designer &
- run app to display csv queries: python milestone1.py