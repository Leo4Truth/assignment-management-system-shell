#!/bin/bash

# admin function, edit the teacher" information
# 管理员功能，编辑教师信息

admin_edit_teacher() {
	echo "Edit an existed teacher account in the Student Performance Management System."
	echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."
	
	echo "Please input the ID of the teacher you want to edit his/her information: "
	read selectedID
	[ "$selectedID" == "q" ] && return
	tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
	while [ $tmp -eq 0 ]; do
		echo "No such teacher ID, please ensure the ID and input again: "
		read selectedID
		[ "$selectedID" == "q" ] && return
		tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
	done
	
	# save the ID and the Name information of the teacher
	# 保存教师的ID和姓名
	newID=$selectedID
	inf=`grep "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
	newName=`echo ${inf##*[[:space:]]}`
	
	# delete the previous information of the teacher which is a line in the file teachersList.txt
	# 删除该教师在teahcersList.txt中之前的信息，是一行
	sed -i "/^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$/d" teachersList.txt

	echo "Now please input the new information of the teacher."
	# input the teacher's password
	# 输入该教师的密码
	echo "The password must starts with a letter and can only contain letters, digits, and underscores and its length must be between 6 and 18 characters."
	echo "Please input the teacher's password: "
	read newPassword
	[ "$newPassword" == "q" ] && return
	# write the read in varible into a temporary file, test if it is valid
	# 将从变量读入的内容写入临时文件，测试其是否合法
	echo $newPassword >temp
	# teacher Password must consists of 8~16 characters which can only be digits in 0~9 or 26 lower or upper letters
	# 教师密码必须由8~16个字符组成，字符只能是0~9的数字或者26个大写或小写的字母
	tmp=`grep -c "^[a-zA-Z]\w\{5,17\}$" temp`
	while [ $tmp -eq 0 ]; do
		echo "The password must starts with a letter and can only contain letters, digits, and underscores and its length must be between 6 and 18 characters."
		echo "Please input the teacher's password again: "
		read newPassword
		[ "$newPassword" == "q" ] && return
		echo $newPassword >temp
		tmp=`grep -c "^[a-zA-Z]\w\{5,17\}$" temp`
	done
	
	# write the new teacher account information into the teachersList.txt file
	# 将新的教师账户信息写入teachersList.txt文件
	echo -e "$newID\t$newPassword\t$newName">>teachersList.txt
}
