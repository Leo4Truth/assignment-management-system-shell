#!/bin/bash

# teacher function, list all students
# 教师功能，列出所有学生的列表

teacher_list_student() {
	echo "List all the students in the system."
	
	# if the studentsList.txt file doesn't exist, create it, set the header and set the permissions.
	# 如果studentsList.txt文件不存在，创建它，写入表头并设置权限
	if [ ! -f "studentsList.txt" ]; then
		touch studentsList.txt
		echo -e "studentID\tstudentPassword\tstudentName">>studentsList.txt
		chmod u=rw studentsList.txt
	fi

	num=`cat studentsList.txt | wc -l`
	one=1
	num=$(expr $num - $one)
	echo "There are $num students in the Student Performance Management System."
	cat studentsList.txt
}
