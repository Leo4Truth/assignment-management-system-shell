#!/bin/bash

# Admin function, add a new teacher account into the system, add its information into teachersList.txt
# 管理员功能，增加一个新的教师账户，将其信息写入teachersList.txt文件

admin_add_teacher() {
	echo "Add a new teacher account to the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

	echo "Teacher ID must be like such format \"000ddd\" in which d represents a digit."
	echo "Please input the teacher ID for the new teacher: "

	tmp1=0
	tmp2=1
	while [ $tmp1 -eq 0 ] || [ $tmp2 -ne 0 ]; do
		read teacherID
		[ "$teacherID" == "q" ] && return
		# ensure the teacher ID format is valid
		# 确认教师ID格式正确
		echo $teacherID > temp
		tmp1=`grep -c "^000[0-9]\{3\}$" temp`
		# ensure the teacherID is unique
		# 确认教师ID是不重复的
		tmp2=`grep -c "^$teacherID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{2,18\}$" teachersList.txt`
		if [ $tmp1 -eq 0 ]; then
			echo "Teacher ID must be like such format \"000ddd\" in which d represents a digit."
			echo "Please input valid teacher ID for the new teacher: "
		elif [ $tmp2 -ne 0 ]; then
			echo "The teacher ID already exists, please input another unique teacher ID: "
		else
			echo "valid teacher ID."
		fi
	done

	# read in the teacher name
	# 读入教师姓名
	echo "The name of the teacher must consists of 2~10 lower or upper letters."
	echo "Please input the name of the new teacher: "
	
	tmp1=0
	while [ $tmp1 -eq 0 ]; do
		read teacherName
		[ "$teacherName" == "q" ] && return
		# ensure the teacherName is valid
		# 确认教师姓名合法，使用正则表达式匹配
		echo $teacherName >temp
		tmp1=`grep -c "^[a-zA-Z_]\{2,18\}" temp`
		if [ $tmp1 -eq 0 ]; then
			echo "The name of the teacher must consists of 2~10 lower or upper letters."
			echo "Please input the right name for the new teacher: "
		else
			echo "Valid teacher Name."
		fi
	done

	# set the password for the new teacher account
	# 为新教师账户设置密码
	echo "The password of the teacher account must consists of 6~18 lower or upper letters and digits and must starts with a letter."
	echo "Now please input the password of the teacher account you have just created: "

	tmp1=0
	while [ $tmp1 -eq 0 ]; do
		read teacherPassword
		[ "$teacherPassword" == "q" ] && return
		# ensure the teacher Password format is valid
		# 确认教师密码格式正确，使用正则表达式匹配
		echo $teacherPassword > temp
		tmp1=`grep -c "^[a-zA-Z]\w\{5,17\}$" temp`
		if [ $tmp1 -eq 0 ]; then
			echo "Teacher Password must consists of 6~18 lower or upper letters and digits and must starts with a letter."
			echo "Please input valid Password for the new teacher: "
		else
			echo "valid teacher Password."
		fi
	done	

	# write the information into the teachersList.txt
	# 将教师账户信息写入teachersList.txt
	echo -e "$teacherID\t$teacherPassword\t$teacherName" >>teachersList.txt
}
