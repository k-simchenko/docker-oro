#!/bin/bash
db_user=""
db_pass=""
db_name=""
backup_dir="./backup"

print_green() {
    echo -e "\e[32m$1\e[0m"
}
print_red() {
   echo -e "\e[31m$1\e[0m"
}

if [ ! -d "$backup_dir" ]; then
    mkdir "$backup_dir"
fi

current_datetime=$(date +"%Y%m%d_%H%M%S")

backup_string="${current_datetime}_${db_name}.sql"
dbname="--dbname=postgresql://${db_user}:${db_pass}@pgsql/${db_name}"

pg_dump "$dbname" > $backup_dir/$backup_string

print_green "DONE $backup_dir/$backup_string"
