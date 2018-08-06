#!/bin/bash

# admin function, delete a course
# 管理员功能，删除一门课程

admin_delete_course() {
	echo "Delete a selected course in the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

	# if the file coursesList.txt doesn't exist, create it, set the header and set the permissions
	# 如果文件coursesList.txt不存在，创建它，写入表头，并设置权限
	if [ ! -f "coursesList.txt" ]; then
		touch coursesList.txt
		echo -e "CourseID\tCourseName\tTeacherID\tTeacherName">>coursesList.txt
		chmod u=rw coursesList.txt
	fi

	# input the course ID of the course you want to delete
	# 输入要删除的课程的课程ID
	echo "Please input the course ID of the course you want to delete from the system: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	# ensure the course ID is not empty
	# 确认课程ID非空
	while [ -z "$selectedID" ]; do
		echo "The course ID can't be empty, please input again: "
		read selectedID
		[ "$selectedID" == "q" ] && return
	done
	# ensure the course ID is valid which means that it exists in the coursesList.txt
	# 确认课程ID合法，即改ID存在于coursesList.txt文件中
	tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such course, please input the right course ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	done

	# Delete the selected course
	# 删除选中的课程
	sed -i "/^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$/d" coursesList.txt
	
	# delete the course folder and the course assignment folders
	# 删除该课程的文件夹和该课程的作业的文件夹
	rm -rf ${selectedID}
	rm -rf ${selectedID}*
}
