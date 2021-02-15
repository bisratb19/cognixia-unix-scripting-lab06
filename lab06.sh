#!/bin/bash

#Argument of server IPs to check
#Loop through one at a time

# 1

#Check if port 22 is open
#SSH and print internal IP
#-- Print failed report and continue to top of list

# 2

#Run system report on ssh instance
#Scp report log file back, rm script and log file
#Continue to top of list or exit 0

#----

# 1

IP_ADD_1=$1
IDENTITY_FILE_1=~/id_file.pub

for IP_ADD in $IP_ADD_1
do
	PORT_CHECKER=$(nc -zv $IP_ADD 22 | printf $?)
	if [ $PORT_CHECKER < 1 ]; then
		ssh -i $IDENTITY_FILE_1 ec2-user@$IP_ADD "printf $HOSTNAME;wget https://raw.githubusercontent.com/bisratb19/cognixia-unix-scripting-lab01/main/lab01.sh;./lab01.sh;exit" #try it like this first
		scp -i $IDENTITY_FILE_1 ec2-user@$IP_ADD:~/report_*.log ~/. #fix file name issues
	else
		printf 'Port 22 is not open. Failed to connect and print a report'
	fi
done
exit 0
