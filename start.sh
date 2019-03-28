#!/bin/sh
#===============================================================================
#   SYSTEM REQUIRED:  Linux
#   DESCRIPTION:  ubuntu
#   AUTHOR: EattingWind
#   EMAIL: 949477774@qq.com
#   time:2015-05-16
#===============================================================================

cur_dir=`pwd`
package_dir=$cur_dir/package
install_dir=$cur_dir/install_pag
conf_dir=$cur_dir/conf

#载入函数
load_functions(){
	local function=$1
	if [[ -s $cur_dir/function/${function}.sh ]];then
		. $cur_dir/function/${function}.sh
	else
		echo "$cur_dir/function/${function}.sh not found,shell can not be executed."
		exit 1
	fi	
}

main(){
#开始载入
load_functions public
load_functions path
load_functions init
load_functions install_software


clear
echo "#############################################################################"
echo 
echo "SYSTEM REQUIRED:  Linux"
echo "DESCRIPTION:  ubuntu"
echo "AUTHOR: EattingWind"
echo "EMAIL:949477774@qq.com"
echo "time:2016-02-16"
echo "note:本脚使用兼容处理方式，支持各种重复执行安装！"
echo "warning:如安装失败请将/tmp/EattingWind_ubuntu.log文件发予作者"
echo
echo "############################################################################"
echo
#初始化配置
init_install

#菜单
memu_index
}
#菜单
memu_index(){
echo "#############################################################################"
echo
echo "请选择要执行的操作"
echo
echo "############################################################################"
echo "1) 一键无脑安装UBUNTU所需软件"
echo "2) 安装jdk"
echo "3) 安装phpstorm2018稳定版"
read menu_select
case $menu_select in
1)
    rm -rf $install_dir/*
    mkdir -p $install_dir
    chmod 777 -R $cur_dir
	install_software
	echo "恭喜您！顺利安装完成！如有疑问请联系【作者EattingWind】"
	;;
2)
	install_jdk
	echo "恭喜您！顺利安装完成！如有疑问请联系【作者EattingWind】"
	;;
3)
	install_phpstorm
	echo "恭喜您！顺利安装完成！如有疑问请联系【作者EattingWind】"
	;;
esac
}

########从这里开始运行程序######
#rm -rf /tmp/EattingWind_ubuntu.log

main 2>&1 | tee -a /tmp/EattingWind_ubuntu.log



