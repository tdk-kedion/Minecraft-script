### Minecraft Java 1.15.2 一键安装脚本

此脚本为一键安装脚本

请在`/root`下安装，暂不支持在其他目录下安装


使用方法

```sh
yum update -y && yum install -y wget && wget --no-check-certificate https://cos.tdk.wiki/mc/Minecraft.sh && bash Minecraft.sh
```

进入Minecraft控制台

```
screen -r
```

重复安装请删除`/etc/crontab`里面多余的定时任务，以免重复执行备份
