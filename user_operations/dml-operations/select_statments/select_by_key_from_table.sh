#! /bin/bash

# using sourcing
. ././helpers/functions.sh


column="$(awk "NR>1" Database/$dbName/.metadata/$table.meta | awk -F ';' '{print $1}' | zenity --list --height="250" --width="300" --title="Table $table Columns" --text="Select Your Choosen Column"  --column="Columns" 2>>.errorlog)"

column_index=$(grep -n "$column" Database/$dbName/.metadata/$table.meta | cut -d ':' -f1)

column_val="$(awk "NR" Database/$dbName/$table | cut -d ";" -f$(($column_index-1)) | zenity --list --cancel-label="Back" --height="250" --width="300" --title="Table $table Column [$column]" --text="Select $column From $table"  --column="$column" 2>>.errorlog)"

if [ $? -eq 1 ]
then
    tableMenu $dbName $table
fi 


