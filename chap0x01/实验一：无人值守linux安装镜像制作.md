# 实验一：linux无人机值守安装

## 一、实验目的

1、能自主进行手动安装ubuntu

2、通过ssh连接本地主机到虚拟机

3、了解无人机值守安装的过程制作镜像并实现系统自动安装

## 二、实验内容：

1、提前下载好[纯净版 Ubuntu 安装镜像 iso 文件](https://releases.ubuntu.com/focal/ubuntu-20.04.2-live-server-amd64.iso)，后手动安装Ubuntu

2、手动安装 Ubuntu 后得到的一个初始「自动配置描述文件」 /var/log/onstaller/autoinstall-user-data

①通过cat命令查看文件：

```cmd
cat /var/log/onstaller/autoinstall-user-data 
```

②通过sudo su - 赋予查看权限

```cmd
sudo su-
```

![8](照片\8.jpg)

查找到user-data文件

![9](照片\9.jpg)

③通过

```cmd
sudo chown xt:xt /var/log/installer/autoinstall-user-data
```

改变宿主，在本地主机找到文件下载后用编辑器打开

3、修改本地配置文件user-data

![10](照片\10.jpg)

4、制作包含 `user-data` 和 `meta-data` 的 ISO 镜像文件，假设命名为 `focal-init.iso`

①安装依赖工具 genisoimage

```cmd
sudo apt install genisoimage
```

②将user-data文件和meta-data文件传给虚拟机

```cmd
scp C:\Users\奚婷\Desktop\meta-data xt@192.168.56.104：/home

scp C:\Users\奚婷\Desktop\user-data xt@192.168.56.104：/home
```

③创建clone-init镜像

```cmd
genisoimage -input-charset utf-8 -output init.iso -volid cidata -joliet -rock user-data meta-data
```

5、同手工安装系统步骤，新建可以用于安装 `Ubuntu 64位系统` 的虚拟机配置

6、移除新建虚拟机「设置」-「存储」-「控制器：IDE」在「控制器：SATA」下新建 2 个虚拟光盘，**按顺序** 先挂载「纯净版 Ubuntu 安装镜像文件」后挂载 `focal-init.iso`

7、启动虚拟机，稍等片刻会看到命令行中出现以下提示信息。此时，需要输入 `yes` 并按下回车键，剩下的就交给「无人值守安装」程序自动完成系统安装和重启进入系统可用状态了

## 三、实验遇到问题以及解决方法

1、关于复制粘贴的问题:通过ssh连接到虚拟机就可以直接在本地进行复制粘贴，运行命令。虚拟机是没有鼠标的。

2、关于ssh失败的问题。![1](C:\Users\奚婷\Desktop\study\大二下\linux\实验\实验一：无人机值守安装\照片\1.jpg

![1](照片\1.jpg)

![2](照片\2.jpg)

ssh连接失败，虚拟机用户名和地址都没错，通过向老师请教得知应该是安装过程时候没有勾选install openssh server服务导致失败。

![6](照片\6.png)

通过执行 sudo apt update && sudo apt install openssh-server解决问题![7](照片\7.jpg)

