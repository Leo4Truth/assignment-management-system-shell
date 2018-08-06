#!/bin/bash
	
chmod +x admin/*.sh

. admin/admin_add_teacher.sh
. admin/admin_delete_teacher.sh
. admin/admin_edit_teacher.sh
. admin/admin_list_teacher.sh

. admin/admin_add_course.sh
. admin/admin_delete_course.sh
. admin/admin_edit_course.sh
. admin/admin_list_course.sh

. admin/admin_reset.sh

# The User Interface of the Admin user
# 管理员用户的交互界面

admin() {
	while true; do
		echo "======================================================================"
		echo "1. add teacher"
		echo "2. delete teacher"
		echo "3. edit teacher"
		echo "4. list teacher"
		echo "5. add course"
		echo "6. delete course"
		echo "7. edit course"
		echo "8. list course"
		echo "9. reset the system"
		echo "0. quit"
		echo "======================================================================"
	
		read c
		case $c in
		1) admin_add_teacher;;
		2) admin_delete_teacher;;
		3) admin_edit_teacher;;
		4) admin_list_teacher;;
		5) admin_add_course;;
		6) admin_delete_course;;
		7) admin_edit_course;;
		8) admin_list_course;;
		9) admin_reset;;
		0) exit 0;;
		esac
	done
}


