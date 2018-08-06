#!/bin/bash

# list all the assignments of the specific course
# 列出某项课程的所有作业

list_course_assignment() {
	echo "List all the assignments of the specific course."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the course ID: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	while [ ! -d $selectedID ]; do
		echo "No such course, please input a valid course ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
	done

	cat ${selectedID}/${selectedID}_assignmentsList.txt
}
