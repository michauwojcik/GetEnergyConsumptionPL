#!/usr/local/bin/zsh

# this script must be run in every month-dir
for file in *
do
  # get date from filename
  only_date=$(echo $file | cut -d "_" -f1)

  # save file with changed column name && get only 3rd column with consumption
  LC_ALL=C sed "s/Krajowe zapotrzebowanie na moc/$only_date/g" $file > $only_date"_changed.csv" && csvcut -e ISO-8859-1 -d ';' -c 3 $only_date"_changed.csv" > $only_date"_cons.csv"
  rm $only_date"_changed.csv"

done

file_name=$(basename `pwd`)
paste -d ',' *_cons.csv > $file_name"_merged.csv"
