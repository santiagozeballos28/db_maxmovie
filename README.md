 STEPS
 -----
 1.- Create the data base
 2.- Be located in the bin directory of Postgres (C:\Program Files\PostgreSQL\9.2\bin)
 3.- Execute the following command: > psql -U postgres -W -h localhost database_name < "path/to/file.sql"
     (psql -U postgres -W -h localhost maxmovie3 < "d:\Database\maxmovieDBV3.sql") 
	

COMMANDS
--------
 # To import
 # psql -U postgres -W -h localhost maxmovie3 < "d:\Database\maxmovieDBV3.sql"
 # To export
 # pg_dump.exe -U postgres maxmovie3 > "d:\Database\maxmovieDBV4.sql"
 
