#!/bin/bash

# teacher function, create a new student account
# 教师功能，创建一个新的学生账户

teacher_new_student() {
	echo "Add a new student account to the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."	

	echo "Student ID must be like such format \"001ddd\" in which d represents a digit."
	echo "Please input the student ID for the new student: "

	tmp1=0
	tmp2=1
	while [ $tmp1 -eq 0 ] || [ $tmp2 -ne 0 ]; do
		read studentID
		[ "$studentID" == "q" ] && return
		# ensure the student ID format is valid
		# 确认学生ID格式合法
		echo $studentID > temp
		tmp1=`grep -c "^001[0-9]\{3\}$" temp`
		# ensure the studentID is unique
		# 确认学生ID唯一
		tmp2=`grep -c "^$studentID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" studentsList.txt`
		if [ $tmp1 -eq 0 ]; then
			echo "Student ID must be like such format \"001ddd\" in which d represents a digit."
			echo "Please input valid student ID for the new student: "
		elif [ $tmp2 -ne 0 ]; then
			echo "The student ID already exists, please input another unique student ID: "
		else
			echo "valid student ID."
		fi
	done

	# read in the student name
	# 读入学生姓名
	echo "The name of the student must consists of 3~10 lower or upper letters."
	echo "Please input the name of the new student: "
	
	tmp1=0
	while [ $tmp1 -eq 0 ]; do
		read studentName
		[ "$studentName" == "q" ] && return
		# ensure the studentName is valid
		# 确认学生姓名合法
		echo $studentName > temp
		tmp1=`grep -c "^[a-zA-Z_]\{3,18\}" temp`
		if [ $tmp1 -eq 0 ]; then
			echo "The name of the student must consists of 3~10 lower or upper letters."
			echo "Please input the right name for the new student: "
		else
			echo "Valid student Name."
		fi
	done

	# set the password for the new student account
	# 微信的学生账户设置密码
	echo "The password of the student account must consists of 6~18 lower or upper letters and digits and must starts with a letter."
	echo "Now please input the password of the student account you have just created: "

	tmp1=0
	while [ $tmp1 -eq 0 ]; do
		read studentPassword
		[ "$studentPassword" == "q" ] && return
		# ensure the student Password format is valid
		# 确认学生密码格式合法
		echo $studentPassword > temp
		tmp1=`grep -c "^[a-zA-Z]\w\{5,17\}$" temp`
		if [ $tmp1 -eq 0 ]; then
			echo "Student Password must consists of 6~18 lower or upper letters and digits and must starts with a letter."
			echo "Please input valid Password for the new student: "
		else
			echo "valid student Password."
		fi
	done	

	# write the information into the studentsList.txt
	# 将信息写入studentsList.txt
	echo -e "$studentID\t$studentPassword\t$studentName" >>studentsList.txt

	# create the student file
	# 创建代表该学生的文件
	mkdir $studentID
	cd $studentID
	touch ${studentID}_course.txt
	touch ${studentID}_assignment.txt
	echo -e "courseID\tCcourseName\tscore" >>${studentID}_course.txt
	echo -e "courseID\tassignmentID\tassignmentName\ttype" >>${studentID}_assignment.txt
	cd ..
}	
