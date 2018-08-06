#!/bin/bash

chmod +x student/*.sh

. student/student_submit_assignment.sh
. student/student_view_assignment_score.sh
. student/student_detect_assignment.sh
. student/student_view_assignment_content.sh
. teacher/list_course_assignemnt.sh

# The User Interface of the Student user
# 学生用户的交互界面

student() {
	while true; do
		echo "======================================================================"
		echo "1. submit assignment"
		echo "2. view assignment score"
		echo "3. detect assignment"
		echo "4. view the content of a assignment"
		echo "5. list assignment of a course"
		echo "0. quit"
		echo "======================================================================"
	
		read c
		case $c in
		1) student_submit_assignment;;
		2) student_view_assignment_score;;
		3) student_detect_assignment;;
		4) student_view_assignment_content;;
		5) list_course_assignment;;
		0) exit 0;;
		esac
	done
}
