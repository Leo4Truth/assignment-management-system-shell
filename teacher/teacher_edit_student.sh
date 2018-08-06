#!/bin/bash

# teacher function, edit a student
# 教师功能，编辑一个学生

teacher_edit_student() {
	echo "Edit the information of a student account in the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

	# if studentsList.txt doesn't exist, create it and set the header and set the permissions for it
	# 如果studentsList.txt不存在，创建它，写入表头并设置权限
	if [ -f studentsList.txt ]; then
		echo ""
	else
		touch studentsList.txt
		echo -e "studentID\tstudentPassword\tstudentName" > studentsList.txt
		chmod u=rw studentsList.txt
		echo "There is no student in the system."
		return
	fi

	echo "Please input the student ID of the student you want to edit: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,10\}" studentsList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such student, please input the right studnet ID: "
		read selectedID
		[ "$selectedID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,10\}" studentsList.txt`
	done

	inf=`grep "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z_]\{3,18\}$" studentsList.txt`
	newName=`echo ${inf##*[[:space:]]}`

	# delete the previous information of the student which is a line in the file studentsList.txt
	# 删除该学生在studentsList.txt中先前的信息
	sed -i "/^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$/d" studentsList.txt

	echo "Now please input the new information for the selected student."
	# input the student's password
	# 输入学生的密码
	echo "The password must starts with a letter and can only contain letters, digits, and underscores and its length must be between 6 and 18 characters."
	echo "Please input the student's password: "
	read newPassword
	[ "$newPassword" == "q" ] && return
	# write the read in varible into a temporary file, test if it is valid
	# 将从变量读入的内容写入临时文件，以便测试其是否合法
	echo $newPassword >temp
	# student Password must consists of 8~16 characters which can only be digits in 0~9 or 26 lower or upper letters
	# 学生密码必须由8~16位字符组成，每个字符都必须是0~9或者大写或小写的英文字母
	tmp=`grep -c "^[a-zA-Z]\w\{5,17\}$" temp`
	while [ $tmp -eq 0 ]; do
		echo "The password must starts with a letter and can only contain letters, digits, and underscores and its length must be between 6 and 18 characters."
		echo "Please input the student's password again: "
		read newPassword
		echo $newPassword >temp
		tmp=`grep -c "^[a-zA-Z]\w\{5,17\}$" temp`
	done
	
	# write the new student account information into the studentsList.txt file
	# 将新的学生账户信息写入studentsList.txt文件
	echo -e "$selectedID\t$newPassword\t$newName">>studentsList.txt
}
