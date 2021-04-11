# 实战systemd

## 一、实验目的

熟练掌握Linux守护进程系统工具systemd的基本用法

## 二、实验环境

ubutu20.04、asciinema

## 三、实验过程

命令篇：

命令篇3.1-3.6

![asciicast](https://asciinema.org/a/Z453MYZm0UcaoKAESTsRIGTRE.svg)

命令篇4.1-4.4

![asciicast](https://asciinema.org/a/6lnQbvUIUZXCwHhovIAdGHUuK.svg)

命令篇5.1-5.4

![asciicast](https://asciinema.org/a/R956lxAzaA273ZKDYlAyF1CyX.svg)

命令篇6、target

![asciicast](https://asciinema.org/a/WK1AjhLqVavyqTSm3eD1GpFNu.svg)

命令篇7、日志管理

![asciicast](https://asciinema.org/a/E6y7F9Zo9nPNEpvyWj51ShVd6.svg)

### 实战篇：

![asciicast](https://asciinema.org/a/la8BaHWBGbdVVB28bTLOrI8L1.svg)

## 四、自查清单

1、如何添加一个用户并使其具备sudo执行程序的权限？

答：

添加用户：

```
sudo adduser xt
```

使其具备sudo执行程序的权限：

```
sudo usermod -G sudo -a xt
```

2、如何将一个用户添加到一个用户组？

```
usermod -a -G [GroupName] [UserName]
```

3、如何查看当前系统的分区表和文件系统详细信息？

查看分区表：

df -hT 只可以查看已经挂载的分区和文件系统类型。

fdisk -l 可以显示出所有挂载和未挂载的分区，但不显示文件系统类型。

gdisk -l 同样也可

parted -l 可以查看未挂载的文件系统类型，以及哪些分区尚未格式化。大于2TB分区支持使用此

lsblk -f 也可以查看未挂载的文件系统类型



4、如何实现开机自动挂载Virtualbox的共享目录分区？

创建一个共享文件夹的挂载目录：mkdir/mnt/share

用以下命令实现挂载：mount-t  vboxsf share_file_name /mnt/share

进入/etc/fstab进行编辑：share_file_name /mnt/share vboxsf default



5、基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

创建分区并修改为LVM模式：fdisk 分区名

动态扩容：lvextend -L {{size}}

缩减容量：lvreduce -L {{size}}



6、如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

修改systemd-network中的service

ExecStartPost=网络联通时运行的指定脚本

ExecStopPost=网络断开时运行的另一个脚本



7、如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现***杀不死\***？

在[service]区块中设置

```
Restart=always
```

然后重载配置文件

```
sudo systemctl daemon-reload
```

## 五、参考文件

http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html

http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html

