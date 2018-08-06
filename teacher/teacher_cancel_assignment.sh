#!/bin/bash

# teacher function, cancel a assignment
# 教师功能，取消作业

teacher_cancel_assignment() {
	echo "For teacher to cancel a assignment."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the assignment ID: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	while [ ! -d $selectedID ]; do
		echo "No such assignment, please input valid assignment ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
	done
	
	rm -rf $selectedID
	courseID=`echo ${selectedID#*_}`
	courseID=`echo ${courseID%%_*}`
	courseID=`echo zju_${courseID}`
	sed -i "/^$courseID[[:space:]]$selectedID[[:space:]]*/d" assignmentsList.txt
	cd $courseID
	sed -i "/^$assignmentID[[:space:]]*/d" ${courseID}_assignmentsList.txt
	cd ..
}
