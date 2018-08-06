#!/bin/bash
export ID=-1
echo "=====================================log in====================================="
echo "Please choose your identity: "
echo "1. admin"
echo "2. teacher"
echo "3. student"
echo "================================================================================"

# read in the identity, ensure the input is valid
# 读入身份，确认输入合法
read identity
while [ $identity -ne 1 ] && [ $identity -ne 2 ] && [ $identity -ne 3 ]; do
	echo "Error input, please choose you identity again with right input: "
	read identity
done

# read in the ID and password and identify
# 读入ID和密码并认证
if [ $identity -eq 1 ]; then
	while true; do
		echo "ID: "
		read ID
		echo "Password: "
		read Password
		# the password of the admin is fixed
		# 管理员密码是设置好的，为123456
		if [ "$ID" != "admin" ] || [ "$Password" != "123456" ]; then
			echo "Wrong ID or Password, please input the right ID or Password."
		else
			echo "admin log in successful."
			return 1
		fi
	done
elif [ $identity -eq 2 ]; then
	while true; do
		echo "ID: "
		read ID
		echo "Password: "
		read Password
		# the password of teacher user is in the teachersList.txt
		# 教师用户的密码存储在teachersList.txt文件中
		tmp=`grep -c "^$ID[[:space:]]$Password[[:space:]]*" teachersList.txt`
		if [ $tmp -eq 0 ]; then
			echo "Wrong ID or Password, please input the right ID or Password."
		elif [ $tmp -eq 1 ]; then
			echo "teacher log in successful."
			return 2
		fi
	done
else
	while true; do
		echo "ID: "
		read ID
		echo "Password: "
		read Password
		# the password of student user is in the studentsList.txt
		# 学生用户的密码存储在studentsList.txt文件中
		tmp=`grep -c "^$ID[[:space:]]$Password[[:space:]]*" studentsList.txt`
		if [ $tmp -eq 0 ]; then
			echo "Wrong ID or Password, please input the right ID or Password."
		elif [ $tmp -eq 1 ]; then
			echo "student log in successful."
			return 3
		fi
	done
fi
