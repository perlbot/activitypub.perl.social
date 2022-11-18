#!/bin/bash

set -euxo pipefail

function create_user_and_database() {
	local database=$1
	local user=$2
	local password=$3
	echo "  Creating user and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE USER $user PASSWORD '$password';
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $user;
EOSQL
}


for $DATABASE in PG_DATABASE_LIST; do
	uservar="PG_DB_USER_${DATABASE}"
	passvar="PG_DB_PASS_${DATABASE}"
	echo Creating Database $DATABASE and User ${!uservar}
	create_user_and_database $DATABASE ${!uservar} "${!passvar}"
done
