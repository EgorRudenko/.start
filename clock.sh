#!bin/bash

print(){
	for (( ; ; ))
	do
		DATE=`date +"%d-%m-%Y"`
		TIME=`date +"%T"`
		xsetroot -name "${DATE} || ${TIME}"
		sleep 1
	done
}

print 
