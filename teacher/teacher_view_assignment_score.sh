#!/bin/bash

# teacher function, view assignment score
# 教师功能，查看作业分数

teacher_view_assignment_score() {
	echo "For student view the score of the specific assignment."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the assignment ID: "
	read assignmentID
	[ "$assignmentID" == "q" ] && return
	while [ ! -d $assignmentID ]; do
		echo "No such assignment, please input the valid assignment: "
		read assignmentID
		[ "$assignmentID" == "q" ] && return
	done
	
	cd $assignmentID
	cat list.txt
	cd ..
}
