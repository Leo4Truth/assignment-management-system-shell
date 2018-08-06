#!/bin/bash

# student function, view the content of the specific assignment
# 学生功能，查看制定作业的内容

student_view_assignment_content() {
	echo "View the content of the specific assignment"
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the assignment ID: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	while [ ! -d $selectedID ] && [ ! -f ${selectedID}/title ]; do
		echo "No such assignment, please input a valid assignment ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
	done
	
	echo "Here is the content of the assignment $selectedID: "
	cat ${selectedID}/title
	cat ${selectedID}/content.txt 
}
