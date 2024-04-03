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
print_yellow() {
    echo -e "\e[33m$1\e[0m"
}
select_file() {
    echo "Select file:"
    files=($(ls "$backup_dir"))
    for i in "${!files[@]}"; do
        print_yellow "$((i+1)). ${files[$i]}"
    done

    read -p "Enter number file: " choice
    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#files[@]} ]]; then
        selected_file="${files[$((choice-1))]}"
        print_green "Your file: $selected_file"
    else
        print_red "Error: File not found."
        exit 1
    fi
}

process_file() {
  dbname_template1="--dbname=postgresql://${db_user}:${db_pass}@pgsql/template1"
  psql "$dbname_template1" -c "DROP DATABASE $db_name WITH (FORCE);"
  psql "$dbname_template1" -c "CREATE DATABASE $db_name WITH OWNER $db_user;"
  dbname="--dbname=postgresql://${db_user}:${db_pass}@pgsql/${db_name}"
#  echo "psql "$dbname" "$db_name" < "${backup_dir}/${1}""
  psql "$dbname" "$db_name" < "${backup_dir}/${1}"
  rm -rf ./var/cache
  bin/console cache:clear
  print_green "DONE"
}

files=$(ls "$backup_dir")
if [ -z "$files" ]; then
    print_red "Error: Folder is empty"
    exit 1
fi

select_file

process_file "$selected_file"
