#!/bin/bash

# student function, view the assignment score
# 学生功能，查看作业成绩

student_view_assignment_score() {
	echo "For student view the score of the specific assignment."
	
	echo "Please input the assignment ID: "
	read assignmentID
	while [ ! -d $assignmentID ]; do
		echo "No such assignment, please input the valid assignment: "
		read assignmentID
	done
	
	echo -e "studentID\tstudentName\tscore"
	cd $assignmentID
	grep $ID list.txt
	cd ..
}
