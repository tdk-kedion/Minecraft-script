#!/bin/bash

# Minecraft 停止脚本

# 进入所有带有Linux-Minecraft-Scripts的目录
cd "$( dirname $0 )"

# 读取配置文件
source config.cfg

# 提醒玩家服务器将被关闭。我们将“ stop”命令填充到屏幕会话。\ 015是返回的转义值。
screen -p 0 -S minecraft -X eval "stuff \"say Server will be shutting down in 10 seconds.\"\015"

# 等待片刻，然后停止服务器。
sleep 10
screen -p 0 -S minecraft -X eval "stuff \"stop\"\015"
