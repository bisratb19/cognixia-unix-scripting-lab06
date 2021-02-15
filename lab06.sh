#!/bin/bash
#Author: Bisrat Belay
#Lab 06 - February 15, 2021

#Give IP address as argument

IP_ADD_1=$1
IDENTITY_FILE_1=~/.ssh/chitra-feb21.pem

for IP_ADD in $IP_ADD_1
do
	PORT_CHECKER=$(nc -zv $IP_ADD 22 | printf $?)
	if [ $PORT_CHECKER == 0 ];then
		ssh -i $IDENTITY_FILE_1 ec2-user@$IP_ADD "printf $HOSTNAME > remote_hostname.txt;wget https://raw.githubusercontent.com/bisratb19/cognixia-unix-scripting-lab01/main/lab01.sh;chmod u+x lab01.sh;./lab01.sh;exit" #try it like this first
		scp -i $IDENTITY_FILE_1 ec2-user@$IP_ADD:~/remote_hostname.txt ~/Desktop/test/remote_hostname.txt
		scp -i $IDENTITY_FILE_1 ec2-user@$IP_ADD:~/testfile.txt ~/Desktop/test/testfile.txt #get the log file fix this
	else
		printf 'Port 22 is not open. Failed to connect and print a report'
	fi
done
#delete files on server
exit 0
