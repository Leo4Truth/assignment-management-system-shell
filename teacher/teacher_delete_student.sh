#!/bin/bash

# teacher function, delete a student from the system
# 教师功能，从系统中删除一名学生

teacher_delete_student() {
	echo "Delete a selected student from the system."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

	# input the student ID of the student you want to delete from the system
	# 输入要删除的学生的ID
	echo "Please input the student ID of the student you want to delete from the system: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,10\}$" studentsList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such student, please input the right student ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,10\}$" studentsList.txt`
	done

	# delete the selected student ID
	sed -i "/^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,10\}$/d" studentsList.txt
	rm -rf $selectedID
}
