#!/bin/bash

#prompt the user what they want to do
echo "Select log to Archive:"
echo "1) Heart rate"
echo "2) Temperature"
echo "3) Water usage"
read -p "Enter choice (1-3):" choice

case $choice in
	1)
		log_name="heart_rate_log.log"
		archive_dir="heart_data_archive"
		;;
	2)
		log_name="temperature_log.log"
		archive_dir="temperature_data_archive"
		;;
	3)
		log_name="water_usage_log.log"
		archive_dir="water_usage_data_archive"
		;;
	*)
		echo "Invalid choice...Exiting"
		exit 1
		;;
esac

timestamp=$(date "+%Y-%m-%d_%H:%M:%S")

src="hospital_data/active_logs/$log_name"
destination="hospital_data/archived_logs/$archive_dir/${log_name%.log}_$timestamp.log"

if [ ! -f "$src" ]; then
	echo "log file doesn't exist: $src"
	exit 1
fi

mv "$src" "$destination"
touch "$src"
echo "File successfully archived to $destination"


