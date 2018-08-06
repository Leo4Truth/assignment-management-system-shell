#!/bin/bash

# teacher functiion, edit a assignment
# 教师功能，编辑一项作业

teacher_edit_assignment() {
	echo "For teacher to edit a assignment."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the assignment ID: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	while [ ! -d $selectedID ] || [ ! -f ${selectedID}/title ]; do
		echo "No such assignment, please input valid assignment ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
	done
	
	cd $selectedID
	echo "Here is the current content of the assignment: "
	cat title
	cat content.txt

	echo "How do you want to edit the content?"
	echo "1. add content to the current one"
	echo "2. override the current content"
	read c
	[ "$c" == "q" ] && return
	while [ $c -ne 1 ] && [ $c -ne 2 ]; do
		echo "Wrong input, please input 1 or 2 or q"
		read c
		[ "$c" == "q" ] && return
	done
	
	if [ $c -eq 1 ]; then
		echo "Please input the added content: "
	else
		rm -rf content.txt
		touch content.txt
		echo "Please input new content of the assignment which will override the old one. End by a line of 'end'"
	fi
	
	read content
	[ "$content" == "q" ] && return
	while [ "$content" != "end" ]; do
		echo $content >>content.txt
		read content
		[ "$content" == "q" ] && return
	done
	
	cd ..
}
