#!/usr/local/bin/zsh

# run this script in dir with weekdays gen
for year in {2009..2020}
do
  for month in {1..12}
  do
    mkdir $year"_"$month && cd $year"_"$month && zsh ../../Scripts/getWeekdaysConsumption.zsh $month $year && cd ..

  done
done
