### Minecraft Java 1.15.2 一键安装脚本

此脚本为一键安装脚本

使用方法

```sh
yum update -y && yum install -y wget https://cos.tdk.wiki/mc/Minecraft.sh && bash Minecraft.sh
```

进入Minecraft控制台

```
screen -r
```

重复安装请删除`/etc/crontab`里面多余的定时任务，以免重复执行备份