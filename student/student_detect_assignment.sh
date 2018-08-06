#!/bin/bash

# student function, detect assignment
# 学生功能，查询是否有作业需要完成

student_detect_assignment() {
	echo "Check if there is any assignment need to do."
	echo -e "courseID\tassignmentID\tassignmentTitle\ttype"

	cd $ID
	while read line; do
		line=`echo ${line%%[[:space:]]*}`
		grep "^$line" ../assignmentsList.txt
	done < ${ID}_course.txt

	cd ..
}
