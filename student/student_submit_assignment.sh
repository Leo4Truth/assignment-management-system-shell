#!/bin/bash

# student function, submit assignment
# 学生功能，提交作业

student_submit_assignment() {
	echo "For student to edit, finish and submit assignments"
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the assignment ID: "
	read assignmentID
	[ "$assignmentID" == "q" ] && return
	while [ ! -d $assignmentID ] || [ ! -f ${assignmentID}/title ]; do
		echo "No such assignment, please input valid assignment ID: "
		read assignmentID
		[ "$assignmentID" == "q" ] && return
	done
	
	echo "Please choose the way to submit."
	echo "1. upload a txt file"
	echo "2. create a new file which will override the older one (if it exists)"
	echo "3. add content to the current assignment file (if it not exists, create a new file)"
	read choice
	[ "$choice" == "q" ] && return
	while [ $choice -ne 1 ] && [ $choice -ne 2 ] && [ $choice -ne 3 ]; do
		echo "Wrong choice, please input 1, 2 or 3: "
		read choice
		[ "$choice" == "q" ] && return
	done
	
	if [ $choice -eq 1 ]; then
		echo "Please input file path: "
		read filePath
		if [ ! -f $filePath ]; then
			echo "File doesn't exist!"
			return
		else
			cp ${assignmentID}_${ID}.txt ./${assignmentID}
		fi
	elif [ $choice -eq 2 ] || [ $choice -eq 3 ] && [ ! -f ${assignmentID}_${ID}.txt ]; then
		cd ${assignmentID}
		touch ${assignmentID}_${ID}.txt
		echo "Please input content of the file which should end with a line of 'end':"
		read content
		echo "$content" >${assignmentID}_${ID}.txt
		[ "$content" == "end" ] && echo "submit successful!" && return
		read content
		while [ "$content" != "end" ]; do
			echo "$content" >>${assignmentID}_${ID}.txt
			read content
		done
	else
		read content
		while [ "$content" != "end" ]; do
			echo "$content" >>${assignmentID}_${ID}.txt
			read content
		done
	fi
	echo "submit successful!" && return
}
