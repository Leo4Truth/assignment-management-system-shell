#!/bin/bash

# teacher function, search student in the system by student ID
# 教师功能，在系统中按学生ID搜索学生

teacher_search_student() {
	echo "Search student in the system by student ID."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input student ID: "
	read searchID
	[ "$searchID" == "q" ] && return
	tmp=`grep -c "^$searchID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" studentsList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such student, please input the right student ID: "
		read searchID
		[ "$searchID" == "q" ] && return
		tmp=`grep -c "^$searchID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" studentsList.txt`
	done
	studentName=`grep "^$searchID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" studentsList.txt`
	studentName=`echo ${studentName##*[[:space:]]}`
	
	# display the information of the student
	# 显示该学生的信息
	echo "Here is the information of the student: $studentName ( $searchID )"
	cat ${searchID}/${searchID}_course.txt
	cat ${searchID}/${searchID}_assignment.txt
}
