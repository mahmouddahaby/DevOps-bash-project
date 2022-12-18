#! /bin/bash

# using sourcing
. ././helpers/functions.sh


column="$(awk "NR>1" Database/$dbName/.metadata/$table.meta | awk -F ';' '{print $1}' | zenity --list --height="250" --width="300" --title="Table $table Columns" --text="Select Your Choosen Column"  --column="Columns" 2>>.errorlog)"


while true
do
    column_value=$(zenity --entry \
    --title="Enter The $column Value" \
    --text="SELECT * FROM $table WHERE $column = " \
    --width="200" \
    --entry-text "")

    if [[ -z "$column_value" ]]
    then
       zenity --error --width="300" --text="Column [$column] field cannot be empty"
    else
        break
    fi
done

column_index=$(grep -n "$column" Database/$dbName/.metadata/$table.meta | cut -d ':' -f1)

no_of_columns=$(wc -l Database/$dbName/.metadata/$table.meta | cut -d " " -f1)


columns=()
rows=()

for (( i = 2; i<=$no_of_columns+1; i++ ))
do
    column_name=$(awk "NR==$i" Database/$dbName/.metadata/$table.meta | cut -d ';' -f1)
    columns+=("--column=$column_name")
done

for irow in `awk -F ';' -v value=$column_value -v colindex=$(($column_index-1)) '{if($colindex==value){print $0}}' Database/$dbName/$table`
do
    
  for (( i = 1; i<=$no_of_columns; i++ ))
  do
        row=$(echo $irow | cut -d ';' -f$i)
        rows+=($row)
  done

done

zenity --list  --cancel-label="Back"  --title="Table $table Records"  --width="500" --height="300" "${columns[@]}" "${rows[@]}"
if [ $? -eq 1 ]
then
    tableMenu $dbName $table
fi 


