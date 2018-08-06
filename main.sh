#!/bin/bash

chmod +x admin.sh
chmod +x teacher.sh
chmod +x student.sh

. ./admin.sh
. ./teacher.sh
. ./student.sh

log_in() {
	export ID=-1
	export NAME=NULL
		
	echo "=====================================log in====================================="
	echo "Please choose your identity: "
	echo "1. admin"
	echo "2. teacher"
	echo "3. student"
	echo "0. exit"
	echo "================================================================================"

	# read in the identity, ensure the input is valid
	# 读入身份，确认输入合法
	read identity
	while [ $identity -ne 1 ] && [ $identity -ne 2 ] && [ $identity -ne 3 ] && [ $identity -ne 0 ]; do
		echo "Error input, please choose you identity again with right input: "
		read identity
	done
	
	# read in the ID and password and identify
	# 读入ID和密码并认证
	if [ $identity -eq 1 ]; then
		echo "admin log in"
		while true; do
			echo "ID: "
			read ID
			echo "Password: "
			read Password
			if [ "$ID" != "admin" ] || [ "$Password" != "123456" ]; then
				echo "Wrong ID or Password, please input the right ID or Password."
			else
				echo "admin log in successful."
				return 1
			fi
		done
		NAME=admin
	elif [ $identity -eq 2 ]; then
		echo "teacher log in"
		while true; do
			echo "ID: "
			read ID
			echo "Password: "
			read Password
			tmp=`grep -c "^$ID[[:space:]]$Password[[:space:]]" teachersList.txt`
			if [ $tmp -eq 0 ]; then
				echo "Wrong ID or Password, please input the right ID or Password."
			elif [ $tmp -eq 1 ]; then
				echo "teacher log in successful."
				return 2
			fi
		done
		NAME=`grep "^$ID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,18\}$" teachersList.txt`
		NAME=`echo ${NAME##*[[:space:]]}`
	elif [ $identity -eq 3 ]; then
		echo "student log in"
		while true; do
			echo "ID: "
			read ID
			echo "Password: "
			read Password
			tmp=`grep -c "^$ID[[:space:]]$Password[[:space:]]" studentsList.txt`
			if [ $tmp -eq 0 ]; then
				echo "Wrong ID or Password, please input the right ID or Password."
			elif [ $tmp -eq 1 ]; then
				echo "student log in successful."
				return 3
			fi
		done
		NAME=`grep "^$ID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,18\}$" studentsList.txt`
		NAME=`echo ${NAME##*[[:space:]]}`
	elif [ $identity -eq 0 ]; then
		exit 0
	else
		echo "admin log in"
		while true; do
			echo "ID: "
			read ID
			echo "Password: "
			read Password
			if [ "$ID" != "admin" ] || [ "$Password" != "123456" ]; then
				echo "Wrong ID or Password, please input the right ID or Password."
			else
				echo "admin log in successful."
				return 1
			fi
		done
		NAME=admin
	fi
}

	clear
	echo "================================================================================"
	echo "=====================Student Performance Management System======================"
	echo "================================================================================"
	

	# if the teachersList.txt file doesn't exist, create it, set the header and set the permissions.
	# 如果teachersList.txt文件不存在，创建，写入表头并赋予权限
	if [ ! -f "teachersList.txt" ]; then
		touch teachersList.txt
		echo -e "ID\tPassword\tName" >teachersList.txt
		chmod u=rw teachersList.txt
	fi
	
	# if the file coursesList.txt doesn't exist, create it, set the header and set the permissions	
	# 如果coursessList.txt文件不存在，创建，写入表头并赋予权限
	if [ ! -f "coursesList.txt" ]; then
		touch coursesList.txt
		echo -e "CourseID\tCourseName\tTeacherID\tTeacherName" >coursesList.txt
		chmod u=rw coursesList.txt
	fi
	
	# if studentsList.txt doesn't exist, create it and set the header and set the permissions for it
	# 如果studentsList.txt文件不存在，创建，写入表头并赋予权限
	if [ ! -f studentsList.txt ]; then
		touch studentsList.txt
		echo -e "studentID\tstudentPassword\tstudentName" >studentsList.txt
		chmod u=rw studentsList.txt
	fi
	
	# if assignmentsList.txt doesn't exist, create it and set the header and set the permissions for it
	# 如果assignmentsList.txt文件不存在，创建，写入表头并赋予权限
	if [ ! -f assignmentsList.txt ]; then
		touch assignmentsList.txt
		echo -e "assignmentID\tassignmentTitle\tcourseID\tcourseName\ttype" >assignmentsList.txt
		chmod u=rw assignmentsList.txt
	fi
	
	log_in
	
	case $? in
	1) admin;;
	2) teacher;;
	3) student;;
	0) exit 0;;
	esac
