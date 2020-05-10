#!/bin/bash

#常规变量设置
Green="\033[32m" 
Red="\033[31m" 
Yellow="\033[33m"
Font="\033[0m"
Info="${Green}[信息]${Font}"
Error="${Red}[错误]${Font}"
Tip="${Green}[注意]${Font}"
dir=$(dirname $(readlink -f "$0"))

check_root(){
	[[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green} sudo su ${Font}来获取临时ROOT权限（执行后请输入当前账号的密码）。" && exit 1
}

check_system(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
	#res = $(cat /etc/redhat-release | awk '{print $4}')
	#if [[ ${release} == "centos" ]] && [[ ${bit} == "x86_64" ]] && [[ ${res} -ge 7 ]]; then
	if [[ ${release} == "centos" ]] && [[ ${bit} == "x86_64" ]]; then
	echo -e "你的系统为[${release} ${bit}],检测${Green} 可以 ${Font}搭建。"
	else 
	echo -e "你的系统为[${release} ${bit}],检测${Red} 不可以 ${Font}搭建。"
	echo -e "${Yellow} 正在退出脚本... ${Font}"
	exit 0;
	fi
}

#设置防火墙
Add_firewall(){
    firewall-cmd --add-port=25565/tcp --permanent
    firewall-cmd --reload
}
Del_firewall(){
    firewall-cmd --remove-port=25565/tcp --permanent
    firewall-cmd --reload
}

File_download(){
    yum update -y
    yum install -y wget screen java-1.8.0 vim
	wget https://github.com/tdk-kedion/Minecraft-Script/archive/v1.0.tar.gz
	tar -xvf v1.0.tar.gz && rm -rf v1.0.tar.gz
	mv Minecraft-Script-1.0 minecraft
	cd minecraft && chmod -R o+x *.sh
	wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar
}

url="https://minecraft-zh.gamepedia.com/Server.properties#Java"
Minecraft_conf(){
	clear
	while [ "${yes}" != 'yes' ] && [ "${yes}" != 'y' ] && [ "${yes}" != 'n' ]
	do
		echo -e "----------------------------------------------------"
		echo -e "请按照官方文档进行配置"
		echo -e "链接: ${url}"
		echo -e "----------------------------------------------------"
		read -p "是否修改配置文件 (yes/n): " yes;
	done 
	if [ "${yes}" == 'y' ];then
		vim server.properties
	fi
}

Scheduled_tasks(){
	echo -e "----------------------------------------------------"
	echo -e "每天几点进行数据备份"
	echo -e "0-23"
	echo -e "----------------------------------------------------"
	read -p "请输入：" date;
	echo "*  ${date}  *  *  * root /${dir}/minecraft/backup.sh" >> /etc/crontab
}
start_up(){
	clear
	while [ "${confirm}" != 'yes' ] && [ "${confirm}" != 'y' ] && [ "${confirm}" != 'n' ]
	do
		echo -e "----------------------------------------------------"
		echo -e "如需更改其他文件请选择否"
		echo -e "手动开启Minecraft请到${Red}minecraft${Font}文件夹执行${Green}./start.sh${Font} "
		echo -e "----------------------------------------------------"
		read -p "是否启动Minecraft (yes/n): " confirm;
	done 
	if [ "${confirm}" == 'n' ];then
		exit
	fi
	bash start.sh
}

check_root
check_system
File_download
Minecraft_conf
Add_firewall
Scheduled_tasks
start_up
cd ${dir} && rm -rf Minecraft.sh