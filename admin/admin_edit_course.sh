#!/bin/bash

# admin function, edit the course information
# 管理员功能，编辑课程信息

admin_edit_course() {
	echo "Edit the information of a selected course in the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

	echo "Please input the course ID of the course whose information you want to edit: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such course, please input the right course ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	done

	inf=`grep "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	courseName=`echo ${inf#*[[:space:]]}`
	courseName=`echo ${courseName%%[[:space:]]*}`
	
	# input the new information of the course
	# 输入课程的新信息
	echo "Now you can update the information of the course."
	echo "Notice: the teacher ID must be like such format \"000ddd\" in which d represents a digit."
	echo "Please input the teacher ID of the new course teacher: "
	read newTID
	[ "$newTID" == "q" ] && return
	# ensure the new course teacher ID is valid, which means it exists in the file teachersList.txt
	# 确认新的教师ID是合法的，即其存在于teachersList.txt文件中
	tmp=`grep -c "^$newTID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such teacher in the system, please input the right teacher ID: "
		read newTID
		[ "$newTID" == "q" ] && return
		tmp=`grep -c "^$newTID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
	done

	# search the information of the teacher in the teachersList.txt file
	# 在teachersList.txt文件中搜索该教师的信息
	# intercept the teacher's Name with specific teacher ID
	# 通过教师ID搜索
	inf=`grep "^$newTID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
	teacherName=`echo ${inf##*[[:space:]]}`
	
	# delete the previous information
	# 删除之前的课程信息
	sed -i "/^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$/d" coursesList.txt
	
	# write the new course information into the coursesList.txt file
	# 写入新的课程信息
	echo -e "$selectedID\t$courseName\t$newTID\t$teacherName" >>coursesList.txt
}
