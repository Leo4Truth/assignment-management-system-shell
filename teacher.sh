#!/bin/bash
	
chmod +x teacher/*.sh
	
. teacher/teacher_new_student.sh
. teacher/teacher_delete_student.sh
. teacher/teacher_edit_student.sh
. teacher/teacher_list_student.sh
. teacher/teacher_add_student_course.sh
. teacher/teacher_search_student.sh
. teacher/teacher_view_course_student.sh
. teacher/teacher_assign_assignment_course.sh
. teacher/teacher_cancel_assignment.sh
. teacher/teacher_edit_assignment.sh
. teacher/teacher_evaluate_assignment.sh
. teacher/teacher_view_assignment_score.sh
. teacher/list_course_assignment.sh

# The User Interface of the Teacher user
# 教师用户的交互界面

teacher() {
	while true; do
		echo "======================================================================"
		echo "1. new student"
		echo "2. delete student"
		echo "3. edit student"
		echo "4. list student"
		echo "5. add student to course"
		echo "6. search student"
		echo "7. view course student"
		echo "8. assign assignment"
		echo "9. cancel assignment"
		echo "10. edit assignment"
		echo "11. evaluate assignment"
		echo "12. view assignment score"
		echo "13. list assignments of the course"
		echo "0. quit"
		echo "======================================================================"
	
		read c
		case $c in
		1) teacher_new_student;;
		2) teacher_delete_student;;
		3) teacher_edit_student;;
		4) teacher_list_student;;
		5) teacher_add_student_course;;
		6) teacher_search_student;;
		7) teacher_view_course_student;;
		8) teacher_assign_assignment_course;;
		9) teacher_cancel_assignment;;
		10) teacher_edit_assignment;;
		11) teacher_evaluate_assignment;;
		12) teacher_view_assignment_score;;
		13) list_course_assignment;;
		0) exit 0;;
		esac
	done
}

