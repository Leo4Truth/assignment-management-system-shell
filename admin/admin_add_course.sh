#!/bin/bash

# admin function, add a new course to the course list
# 管理员功能，增加一门新的课程至课程列表

admin_add_course() {
	echo "Add a new course to the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

	# input the course ID	
	# 输入课程ID，正则表达式匹配确保ID符合规则
	echo "The course ID must be with such format \"zju_x00ddd\" in which x represents a upper letter and d represents a digit."
	echo "Please input the course ID: "
	
	tmp1=0
	tmp2=1
	while [ $tmp1 -eq 0 ] || [ $tmp2 -ne 0 ]; do
		read courseID
		[ "$courseID" == "q" ] && return
		echo $courseID >>temp
		tmp1=`grep -c "^zju_[A-Z]00[0-9]\{3\}" temp`
		tmp2=`grep -c "^$courseID[[:space:]][a-zA-Z_]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z_]\{2,18\}$" coursesList.txt`
		if [ $tmp1 -eq 0 ]; then
			echo "The course ID must be with such format \"zju_x00ddd\" in which x represents a upper letter and d represents a digit."
			echo "Please input the course ID again: "
		elif [ $tmp2 -ne 0 ]; then
			echo "The course ID already exists, please input another course ID: "
		else
			echo "valid course ID."
		fi
	done

	# input the course Name
	# 输入课程名称，正则表达式匹配确保课程名符合规则
	echo "The course Name must consists of 2~20 lower or upper letters."
	echo "Please input the course name: "
	
	read courseName
	[ "$courseName" == "q" ] && return
	# ensure the course Name is valid
	# 确认课程名合法
	# write the read in varible into a temporary file to test if it is valid
	# 将从变量读入的内容写入临时文件，以便检查其是否合法
	echo $courseName > temp
	# The course name must be with such format "zju_x00ddd" in which x represents a upper letter and d represents a digit
	# 课程名必须满足“zju_x00ddd”的格式，其中x是一个大写字母，而d代表一个一位数字
	tmp=`grep -c "^[a-zA-Z_]\{2,18\}$" temp`
	while [ $tmp -eq 0 ]; do
		echo "The course Name must consists of letters and underlines and the length should be within 2~18."
		echo "Please input the course Name again: "
		read courseName
		echo $courseName >temp
		tmp=`grep -c "^[a-zA-Z_]\{2,18\}$" temp`
	done

	echo "Please input the teacher ID: "
	read teacherID
	[ "$teacherID" == "q" ] && return
	# ensure the teacher ID exists in the teachersList.txt
	# 确认教师ID存在于teachersList.txt文件中
	tmp=`grep -c "^$teacherID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" teachersList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such teacher, please input the right teacher ID: "
		read teacherID
		[ "$teacherID" == "q" ] && return
		tmp=`grep -c "^$teacherID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" teachersList.txt`
	done
	
	# search the information of the teacher in the teachersList.txt file
	# 在teachersList.txt文件中搜索该教师的信息
	# intercept the teacher's Name with specific teacher ID
	# 以ID为标志搜索
	inf=`grep "^$teacherID[[:space:]][a-zA-Z_]\w\{5,17\}[[:space:]][a-zA-Z_]\{2,18\}$" teachersList.txt`
	teacherName=`echo ${inf##*[[:space:]]}`
	
	# write the new course information into the coursesList.txt file
	# 将新的课程信息写入coursesList.txt文件中
	echo -e "$courseID\t$courseName\t$teacherID\t$teacherName">>coursesList.txt

	# create the course folder if it doesn't exist
	# 创建course文件夹如果其之前不存在
	if [ ! -d ${courseID} ]; then
		mkdir ${courseID}
		cd ${courseID}
		# create a file to record the student list of the course
		touch ${courseID}.txt
		echo -e "studentID\tstudentName\tscore" >${courseID}.txt
		# create a file to record the num of assignment
		touch ${courseID}_assignmentNum.txt
		echo 0 >${courseID}_assignmentNum.txt
		# create a file to record the assignment list of the course
		touch ${courseID}_assignmentsList.txt
		echo -e "assignmentID\tassignmentTitle\ttype" >${courseID}_assignmentsList.txt
		cd ..
	fi
}
