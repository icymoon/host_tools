#!/bin/bash

cmd_id="/bin/id"
cmd_dmidecoded=`which dmidecode`
my_uid=`$cmd_id -u`

dmidecode_cpu_info(){
	echo "=======CPU Infomation from dmidecode tool======"
	$cmd_dmidecoded -t processor | grep -v \)$ | grep -v Cache | grep -v Flags |\
	grep -v Number | grep -v Tag | grep -v Family | grep -v Manufacturer | \
	grep -v Upgrade | grep -v ^$ | grep -v ID: | grep -v Handle | \
	grep -v Voltage | grep -v Type: | grep -v Status:
	echo "==============================================="
}

proc_cpu_info(){
	physicalNumber=0
	coreNumber=0
	logicalNumber=0
	HTNumber=0
	physicalNumber=$(grep "physical id" /proc/cpuinfo|sort -u|wc -l)
	logicalNumber=$(grep "processor" /proc/cpuinfo|sort -u|wc -l)
	coreNumber=$(grep "cpu cores" /proc/cpuinfo|uniq|awk -F':' '{print $2}'|xargs)
	HTNumber=$((logicalNumber / (physicalNumber * coreNumber))) 
	echo "=======CPU Infomation from /proc/cpuinfo ======"
	echo "Physical CPU Number : $physicalNumber"
	echo "Logical CPU Number  : $logicalNumber"
	echo "CPU Core Number     : $coreNumber"
	if [ $HTNumber -eq 1 ];
	then
		echo "Hyperthread         : Off"
	else
		echo "HyperThread Number  : $HTNumber"
	fi
	echo "==============================================="
}

##### Main process #####
proc_cpu_info

if [ $my_uid -eq 0 ]
then
	if [ "x$cmd_dmidecoded" == "x" ]
	then
		echo "Hint: you are root, use dmidecode can get more info."
	else
		dmidecode_cpu_info
	fi
else
	echo "Hint: use root to get more info..."
fi


