#!/bin/bash

# admin function, reset, remove all the data files.
# 管理员功能，重置系统，删除所有数据文件

admin_reset() {
	echo "All teachers, students, courses and assignments will be removed."
	echo "Do you want to continue? [y/n]"

	while true; do
		read c
		case $c in
		y) rm -rf zju_* # remove the course folders
		   rm -rf 00* # remove the teacher and student folders
		   rm -rf *.txt # remove the List files
		   rm -rf temp # remove the temporary files
		   return;;
		n) return;;
		*) echo "Invalid input, please input y or n: ";;
		esac
	done
}
