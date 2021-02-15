#!/bin/bash
#Author: Bisrat Belay
#Lab 01 - Febrary 11th, 2021

REPORT_DATE=$(date +"%Y-%m-%d-%T")
REPORT_FILE='report_'$REPORT_DATE'.log'

# 1

touch $REPORT_FILE
printf 'HOSTNAME: '$HOSTNAME'\n' >> $REPORT_FILE
printf 'IP address: '$(ifconfig | cut -d ' ' -f10 | head -n 2 | tail -n 1)'\n' >> $REPORT_FILE
printf 'Free memory: '$(free -mh | awk '/Mem:/ {print $4}')'\n' >> $REPORT_FILE
printf 'Number of CPU cores: '$(lscpu | awk '/CPU/ {print $2}' | head -n 2 | tail -n 1)'\n' >> $REPORT_FILE

# 2
printf 'Number of processes running: '$(ps -aux | wc -l)'\n' >> $REPORT_FILE

# 3
printf 'Enter username to check: '
read REPORT_USERNAME

USER_CHECK=$(sed -n '/^$REPORT_USERNAME/p' /etc/passwd | wc -l)
if [ $USER_CHECK ]; then
	printf "User is found\n\n" >> $REPORT_FILE
else
	printf "User is not found\n\n" >> $REPORT_FILE
fi

# print report
printf 'Log file name: '$REPORT_FILE'\n\n'
cat $REPORT_FILE

exit 0
