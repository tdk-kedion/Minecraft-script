#!/bin/bash

# Minecraft 启动脚本

# 进入所有带有Linux-Minecraft-Scripts的目录
cd "$( dirname $0 )"

# 读取配置文件
source config.cfg

# 进入minecraft目录。
cd $minecraftDir

# 在GNU屏幕上启动游戏。它将自动发送。
screen -dmS minecraft java -Xmx1024M -Xms1024M -jar $minecraftJar nogui
