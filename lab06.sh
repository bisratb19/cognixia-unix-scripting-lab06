#!/bin/bash
#Author: Bisrat Belay
#Lab 06 - February 15, 2021

#Give IP address as argument
#Provide ssh identify file path

IP_ADD_1=$1
IDENTITY_FILE_1=~/.ssh/chitra-feb21.pem

for IP_ADD in $IP_ADD_1
do
	PORT_CHECKER=$(nc -zv $IP_ADD 22 | printf $?)
	if [ $PORT_CHECKER == 0 ];then
		ssh -i $IDENTITY_FILE_1 ec2-user@$IP_ADD "hostname > remote_hostname.txt;wget https://raw.githubusercontent.com/bisratb19/cognixia-unix-scripting-lab01/main/lab01.sh;chmod u+x lab01.sh;./lab01.sh;exit"
		ssh -i $IDENTITY_FILE_1 ec2-user@$IP_ADD "ls -lart | grep report_*.log | cut -d' ' -f11 > logfile_name.txt"
		scp -i $IDENTITY_FILE_1 ec2-user@$IP_ADD:~/remote_hostname.txt ./remote_hostname.txt
		scp -i $IDENTITY_FILE_1 ec2-user@$IP_ADD:~/logfile_name.txt ./logfile_name.txt
		LOG_FILE_NAME=$(cat ./logfile_name.txt)
		scp -i $IDENTITY_FILE_1 ec2-user@$IP_ADD:~/$LOG_FILE_NAME ./$LOG_FILE_NAME
	else
		printf 'Port 22 is not open. Failed to connect and print a report'
	fi
	
	ssh -i $IDENTITY_FILE_1 ec2-user@$IP_ADD "rm lab01.sh remote_hostname.txt logfile_name.txt;exit"
done
exit 0

#print IP in report log file -- not working
