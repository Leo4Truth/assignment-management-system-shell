#!/bin/bash

# admin function, print the course list
# 管理员功能，打印课程列表


admin_list_course() {
	echo "List all the courses information in the Student Performance Management System."
	
	# if the coursesList.txt file doesn't exist, create it, set the header and set the permissions. 	
	# 如果coursesList.txt文件不存在，创建它，写入表头并设置权限
	if [ ! -f "coursesList.txt" ]; then
		touch coursesList.txt
		echo -e "CourseID\tCourseName\tTeacherID\tTeacherName">>coursesList.txt
		chmod u=rw coursesList.txt
	fi
	
	num=`cat coursesList.txt | wc -l`
	one=1
	num=$(expr $num - $one)
	echo "There are $num courses in the Student Performance Management System."
	cat coursesList.txt
}
