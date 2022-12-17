#! /bin/bash

# using sourcing
. ././helpers/functions.sh

no_of_columns=$(wc -l Database/$dbName/.metadata/$table.meta | cut -d " " -f1)


columns=()
rows=()

for (( i = 2; i<=$no_of_columns+1; i++ ))
do
    column_name=$(awk "NR==$i" Database/$dbName/.metadata/$table.meta | cut -d ';' -f1)
    columns+=("--column=$column_name")
done

for irow in `cat Database/$dbName/$table `
do
    
  for (( i = 1; i<=$no_of_columns; i++ ))
  do
        row=$(echo $irow | cut -d ';' -f$i)
        rows+=($row)
  done

done

zenity --list --title="list" --width="500" --height="300" "${columns[@]}" "${rows[@]}"