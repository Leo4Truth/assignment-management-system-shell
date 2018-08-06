#!/bin/bash

# teacher function,assign a assignment for a course
# 教师功能，为某一门课程布置一项作业

teacher_assign_assignment_course() {
	echo "Assign a assignment of a course."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the course ID: "
	read courseID
	[ "courseID" == "q" ] && return
	tmp=`grep -c "^$courseID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z_]\{2,18\}$" coursesList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such course, please input the valid course ID: "
		read courseID
		[ "courseID" == "q" ] && return
		tmp=`grep -c "^$courseID[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z_]\{2,18\}$" coursesList.txt`
	done
	
	# the title is rely on the teacher
	# 输入作业题目
	echo "Please input the title of the assignment: "
	read assignmentTitle
	[ "$assignmentTitle" == "q" ] && return
	
	# choose the type of the assignment
	# 选择作业的类型：homework或者experiment
	echo "Please choose the type of the assignment."
	echo "1. homework"
	echo "2. experiment"
	read t
	[ "$t" == "q" ] && return
	while [ $t -ne 1 ] && [ $t -ne 2 ]; do
		echo "Wrong choice, please input 1 or 2: "
		read t
		[ "$t" == "q" ] && return
	done

	# produce a unique assignment ID for the assignment
	# 为该作业产生一个唯一的作业ID
	num=`cat ${courseID}/${courseID}_assignmentNum.txt`
	let num+=1
	if [ $t -eq 1 ]; then
		assignmentID=${courseID}_${num}_hw
		echo "The assignment ID of the homework is ${assignmentID}"
	elif [ $t -eq 2 ]; then
		assignmentID=${courseID}_${num}_ex
		echo "The assignment ID of the experient is ${assignmentID}"
	fi
	# create the directory of the assignment
	# 为该作业创建一个目录
	mkdir ${assignmentID}
	cd ${assignmentID}
	# create a file named title whose content is the title of the assignment
	# 创建一个名为title的文件，其内容位该作业的title
	touch title
	echo "$assignmentTitle" >title

	# edit the content of the request
	# 编辑作业要求的内容
	touch content.txt
	echo "Please input the content of the assignment which end with a line of 'end': "
	read content
	while [ "$content" != "end" ]; do
		echo $content >>content.txt
		read content
	done
	
	# create a list of students
	# 创建一个学生列表文件，名为list.txt
	touch list.txt
	echo -e "studentID\tstudentName\tscore" >list.txt
	
	if [ $t -eq 1 ]; then
		echo -e "$courseID\t$assignmentID\t$assignmentTitle\thomework" >>../assignmentsList.txt
		echo -e "$assignmentID\t$assignmentTitle\thomework" >>../${courseID}/${courseID}_assignmentsList.txt
	elif [ $t -eq 2 ]; then
		echo -e "$courseID\t$assignmentID\t$assignmentTitle\texperient" >>../assignmentsList.txt
		echo -e "$assignmentID\t$assignmentTitle\texperient" >>../${courseID}/${courseID}_assignmentsList.txt
	fi
	echo "$num" >../${courseID}/${courseID}_assignmentNum.txt
	
	echo "Assign successful."
	cd ..
}
	
