#!/bin/bash

# admin function, print the teacher list
# 管理员功能，打印教师列表

admin_list_teacher() {
	echo "List all the teachers' accounts information in the Student Performance Management System."
	
	# if the teachersList.txt file doesn't exist, create it, set the header and set the permissions.
	# 如果teachersList.txt文件不存在，创建它，写入表头并设置权限	
	if [ ! -f "teachersList.txt" ]; then
		touch teachersList.txt
		echo -e "ID\tPassword\tName">>teachersList.txt
		chmod u=rw teachersList.txt
	fi
	
	num=`cat teachersList.txt | wc -l`
	one=1
	num=$(expr $num - $one)
	echo "There are $num teachers in the Student Performance Management System."
	cat teachersList.txt
}
