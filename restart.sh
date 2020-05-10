#!/bin/bash

# Minecraft 重启脚本

# 进入所有带有Linux-Minecraft-Scripts的目录
cd "$( dirname $0 )"

# 读取配置文件
source config.cfg

# 停止服务器
source stop.sh

# 启动服务器
source start.sh
