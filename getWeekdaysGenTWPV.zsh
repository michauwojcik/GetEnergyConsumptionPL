#!/usr/local/bin/zsh

month=$1
year=$2

# extract only workdays from input month/year
week_days_array=($(ncal -h $month $year | grep -vE "^S|^ |^$" | head -n 5 | sed "s/[[:alpha:]]//g"))

if [ ${#month} -eq 1 ]; then
    month="0"$month; fi

# save workdays in unsorted txt file
for i in {1..${#week_days_array}}; do
	# if $day is a single digit number then add "0" at the beginning
	if [ ${#week_days_array[$i]} -eq 1 ] ; then
        	week_days_array[$i]="0"$week_days_array[$i]; fi 

	echo ${week_days_array[$i]} >> ./notsorted"$month""$year".txt
done


# sort workdays in unsorted txt file and delete unsorted file
sort -h ./notsorted"$month""$year".txt > ./sorted"$month""$year".txt && rm ./notsorted"$month""$year".txt
cat "./sorted"$month$year".txt" | while read day; do
    sleep 2
	wget --auth-no-challenge --no-check-certificate -q -O $year$month$day"_wt_pv.csv" "https://www.pse.pl/getcsv/-/export/csv/PL_GEN_WIATR/data/"$year$month$day
done

rm "./sorted"$month$year".txt"

echo "Wind and PV generation for $month-$year downloaded"