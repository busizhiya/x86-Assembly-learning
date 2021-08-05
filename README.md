# x86 汇编保护模式与实模式



### 	参考教程:https://www.bilibili.com/video/BV1xE411N74T

### 	笔记:[个人博客](http://www.busizhiya.xyz/)

本git用于学习过程中的代码分享,笔记记录,不定时更新

### 	Mac下的环境部署:

​	笔者在此处分享在MacOs Big Sur的环境部署,仅供参考

#### 		编辑器(IDE):Sublime Text3

​		使用插件:[汇编高亮](https://blog.csdn.net/liuchuo/article/details/51987174)、[HexViewer](https://facelessuser.github.io/HexViewer/)

#### 		编译器:nasm

​	为了方便,本人编写了一些小脚本

​	在终端下输入`export ASM_PATH=<NAME>`更改编译**目录**,asm文件需与目录名相同

​	执行`./auto_gen`自动进行编译,在目录下生成bin文件、lst文件、vhd文件

​	vhd文件通过python脚本生成,请确保脚本目录下有Template.vhd与python环境

#### 		虚拟机:Bochs、Virtual Box

​		通过Bochs运行调试插入主引导扇区的.vhd文件`bochs -f bochconf.txt`加载配置程序

​		同时,可以用Virtual Box加载vhd硬盘文件,简单的拷贝即可

#### 				

