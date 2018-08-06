#!/bin/bash

# admin function, delete a teacher
# 管理员功能，删除一个教师账户

admin_delete_teacher() {
  echo "Delete a selected teacher account from Student Performance Management System."
  echo "Anytime and anywhere you can input 'q' to cancel your work and go back to the previous menu."

  # input the teacher ID of the teacher you want to Delete
  # 输入要删除的教师的教师ID
  echo "Please input the teacher ID of the course you want to Delete: "
  read selectedID
  [ "$selectedID" == "q" ] && return
  # ensure the teacher ID is not empty
  # 确认教师ID非空
  while [ -z $selectedID ]; do
    echo "The teacher ID cannot be empty, please input again: "
    read selectedID
    [ "$selectedID" == "q" ] && return
  done
  # ensure the teacher ID is valid which means that it exists in the file teachersList.txt
  # 确认教师ID合法
  tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
  while [ $tmp -eq 0 ]; do
    echo "No such teacher in the system, please input the right teacher ID: "
    read selectedID
    [ "$selectedID" == "q" ] && return
    tmp=`grep -c "^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$" teachersList.txt`
  done

  # Delete the teacher information from the teachersList.txt
  # 从teachersList.txt中删除教师账户信息
  sed -i "/^$selectedID[[:space:]][a-zA-Z]\w\{5,17\}[[:space:]][a-zA-Z]\{3,10\}$/d" teachersList.txt

  # Delete th courses whose course teacher is the selected teacher
  # 删除授课教师为所删除教师的课程
  sed -i "/^zju_[a-zA-Z]00[0-9]\{3\}[[:space:]][a-zA-Z]\{2,18\}[[:space:]]000[0-9]\{3\}[[:space:]][a-zA-Z]\{3,10\}$/d" coursesList.txt
}
