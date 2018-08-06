#!/bin/bash

# teacher function, add a student to a course
# 教师功能，将一名学生添加至一门课程

teacher_add_student_course() {
	echo "Add a student to a course."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the student ID: "
	read studentID
	[ "$studentID" == "q" ] && return
	tmp=`grep -c "^$studentID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" studentsList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such student, please input the right student ID"
		read studentID
		[ "$studentID" == "q" ] && return
		tmp=`grep -c "^$studentID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" studentsList.txt`
	done
	
	echo "Please input the course ID: "
	read courseID
	[ "$courseID" == "q" ] && return
	tmp=`grep -c "^$courseID[[:space:]][a-zA-Z_]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z_]\{2,18\}$" coursesList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such course, please input the right course ID"
		read courseID
		[ "$courseID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z_]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z_]\{2,18\}$" coursesList.txt`
	done
	
	# test if the student is already added to the course
	# 检测该学生是否已经在该课程中了
	tmp=`grep -c "^$courseID[[:space:]][a-zA-Z_]\{2,18\}[[:space:]][1-9]\{0,1\}[0-9]$" ${studentID}/${studentID}_course.txt`
	if [ $tmp -ne 0 ]; then
		echo "The student is already added to the course."
		return
	fi
	
	# add a line to the studentID_course.txt
	# 在相应的studentID_course.txt文件中加入一行
	courseName=`grep "^$courseID[[:space:]][a-zA-Z_]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z_]\{2,18\}$" coursesList.txt`
	courseName=`echo ${courseName#*[[:space:]]}`
	courseName=`echo ${courseName%%[[:space:]]*}`
	cd $studentID
	echo -e "$courseID\t$courseName\t0" >>${studentID}_course.txt
	cd ..
	
	# add a line to the courseID_studentsList.txt
	# 在相应的courseID_studentsList.txt文件中加入一行
	studentName=`grep "^$studentID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" studentsList.txt`
	studentName=`echo ${studentName##*[[:space:]]}`
	echo -e "$studentID\t$studentName\t0" >>${courseID}/${courseID}.txt
}
