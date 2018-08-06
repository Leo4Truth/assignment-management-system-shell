#!/bin/bash

# teacher function,view the students in the specific course
# 教师功能，查看指定课程的所有学生


teacher_view_course_student() {
	echo "View the students that join in the specific course."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the course ID: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No scho course, please input the right course ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$" coursesList.txt`
	done
	
	filename=${selectedID}.txt
	echo "Here is the students List of the course $selectedID and their score."
	cat ${selectedID}/${filename}
}
