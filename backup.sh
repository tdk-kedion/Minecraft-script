#!/bin/bash

# 我的世界备份脚本

# 进入所有带有Linux-Minecraft-Scripts的目录
cd "$( dirname $0 )"

# 读取配置文件
source config.cfg

# 我们首先需要将服务器置于只读模式，以减少存档丢失。
screen -p 0 -S minecraft -X eval "stuff \"save-off\"\015"
screen -p 0 -S minecraft -X eval "stuff \"save-all\"\015"

# 等待几秒钟，以确保Minecraft已完成备份。
sleep 5

#为最新的服务器映像目录创建一个副本（这是一种方便的恢复方法
#在不解压整个档案的情况下，单个玩家的数据或数据块。如果您不需要
#目录中包含最新图像，您可以将此部分注释掉。
rm -rvf $backupDest/$serverNick-most-recent
mkdir $backupDest/$serverNick-most-recent
cp -Rv $minecraftDir/* $backupDest/$serverNick-most-recent

# 创建.tar.gz格式的存档副本。
rm -rvf $backupDest/$serverNick-$backupStamp.tar.gz
tar -cvzf $backupDest/$serverNick-$backupStamp.tar.gz $minecraftDir/*

#不要忘记使服务器退出只读模式。
screen -p 0 -S minecraft -X eval "stuff \"save-on\"\015"

# 等待一秒钟，等待gnu屏幕允许其他填充，并有选择地提醒用户备份已完成。
sleep 1
screen -p 0 -S minecraft -X eval "stuff \"say Backup has been completed.\"\015"

# （可选）删除所有旧的（早于7天）备份，以减少磁盘利用率。
find $backupDest* -mtime +7 -exec rm {} -fv \;
