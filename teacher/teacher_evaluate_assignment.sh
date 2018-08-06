#!/bin/bash

# teacher function, evaluate assignment
# 教师功能，判作业

teacher_evaluate_assignment() {
	echo "For teacher to view the assignment of the student and evaluate it."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the assignment ID: "
	read assignmentID
	[ "$assignmentID" == "q" ] && return
	while [ ! -d $assignmentID ] || [ ! -f ${assignmentID}/title ]; do
		echo "No such assignment, please input the valid assignment: "
		read assignmentID
		[ "$assignmentID" == "q" ] && return
	done
	
	cd $assignmentID
	echo "Please input the student ID"
	read studentID
	[ "$studentID" == "q" ] && return
	fileName=${assignmentID}_${studentID}.txt
	while [ ! -f $fileName ]; do
		echo "No his assignment for the assignment, please input another studnet ID: "
		read studentID
		[ "$studentID" == "q" ] && return
		fileName=${assignmentID}_${studentID}.txt
	done
	
	echo "This is the assignment content: "
	cat ${fileName}
	echo "End of the assignment content."

	tmp=`grep -c "^$studentID[[:space:]][a-zA-Z_]\{3,18\}[[:space:]][1-9]\{0,1\}[0-9]\{1\}$" list.txt` 
	if [ $tmp -ne 0 ]; then
		echo "The assignment has already been evaluated."
		echo "Do you want to evaluate it again? [y/n]"
		while true; do
			read c
			if [ "$c" == "y" ]; then
				sed -i "/^$studentID[[:space:]][a-zA-Z_]\{3,18\}[[:space:]][1-9]\{0,1\}[0-9]\{1\}$/d" list.txt
				break
			elif [ "$c" == "n" ]; then
				return
			else
				echo "Invalid choice, please input y or n: "
			fi
		done
	fi
	
	echo "Please input the score: "
	read score
	[ "$score" == "q" ] && return
	echo "$score" >temp
	tmp=`grep -c "^[1-9]\{0,1\}[0-9]\{1\}$" temp`
	while [ $tmp -eq 0 ]; do
		echo "Wrong input, the score should be within 0~99, please input again: "
		read score
		[ "$score" == "q" ] && return
		echo "$score" >temp
		tmp=`grep -c "^[1-9]\{0,1\}[0-9]\{1\}$" temp`
	done
	
	# write file
	# 写入文件
	studentName=`grep "^$studentID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" ../studentsList.txt`
	studentName=`echo ${studentName##*[[:space:]]}`
	echo -e "$studentID\t$studentName\t$score" >>list.txt
	cd ..
}
