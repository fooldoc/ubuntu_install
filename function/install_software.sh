#!/bin/sh

install_software(){
#sudo apt-get install vim -y
#if check_sys packageManager apt;then
#   	apt-get update
#   	apt-get install wget -y
#elif check_sys packageManager yum; then
#	yum  update -y
#    yum  install wget -y
#fi

#使用``包围防止wget未下载完，程序往下执行了
sogoupinyin=`Download_Files http://cdn2.ime.sogou.com/dl/index/1524572264/sogoupinyin_2.2.0.0108_amd64.deb sogoupinyin_2.2.0.0108_amd64.deb`
#安装搜狗输入法

cd $install_dir/
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
echo 222;
exit;

#删除自带的火狐浏览器重新自己安装
sudo apt-get remove firefox -y
#删除libreoffice
sudo apt-get remove libreoffice-common -y
#删除Amazon的链接
sudo apt-get -y remove unity-webapps-common  
#删掉基本不用的自带软件
sudo apt-get -y remove thunderbird totem rhythmbox empathy brasero simple-scan gnome-mahjongg aisleriot gnome-mines cheese transmission-common gnome-orca webbrowser-app gnome-sudoku  landscape-client-ui-install  
sudo apt-get -y remove onboard deja-dup  
#安装为知笔记-搜狗输入法-docky任务栏
#sudo add-apt-repository ppa:wiznote-team -y
sudo add-apt-repository ppa:fcitx-team/nightly -y
sudo add-apt-repository ppa:docky-core/ppa -y
sudo add-apt-repository ppa:ubuntu-wine/ppa -y
#Ubuntu-tweak
sudo apt-add-repository ppa:tualatrix/ppa -y


sudo apt-get update 
#Ubuntu-tweak  启动： ubuntu-tweak
sudo apt-get install Ubuntu-tweak -y
#安装搜狗输入法支持，貌似要先删除这个 
#sudo apt-get -y remove im-switch
#安装这个
sudo apt-get install im-config -y
#安装virtialBox所需扩增
sudo apt-get install dkms -y
#sudo apt-get install libsdl1.2debian -y
sudo apt-get install libsdl1.2debian:amd64 -y
#修复 im-config  dkms libsdl1.2debian 的错误包。
sudo apt-get -f install

#安装语言支持
sudo apt-get install language-selector-gnome -y
#安装分屏终端
sudo apt-get install terminator -y
#安装SSH客户端
sudo apt-get install openssh-client -y
#安装SSH服务端
sudo apt-get install openssh-server -y

#为知 启动   WizNote
#sudo apt-get install wiznote -y
#docky
#sudo apt-get install docky -y
#搜狗支持语言包
sudo apt-get install fcitx fcitx-config-gtk fcitx-table-all im-switch -y

#安装virtialBox
sudo dpkg -i $virtualbox_path

#安装phpstom
#tar zxvf $phpstorm_path -C $opt_path/

#安装genymotion   账户：517480195@qq.com  密码我知道
sudo cp -rf $package_dir/genymotion/genymotion.desktop $application_path/
chmod +x $genymotion_path
cd $opt_path/
bash $genymotion_path
#安装charles-需要先安装JDK，不然启动不起来，安装完JDK可能需要重启系统
tar zxvf $charles_path -C $opt_path/

#git安装
sudo apt-get install git -y
#wps安装
sudo dpkg -i $wps_path
#firefox
sudo cp -rf $package_dir/firefox/firefox.desktop $application_path/
sudo tar -vxjf $firefox_path -C $opt_path/
sudo mkdir -p /usr/lib/mozilla/plugins
#复制flash
sudo cp $firefox_flash_path /usr/lib/mozilla/plugins/
sudo chmod 755 -R  /usr/lib/mozilla
sudo chown -R lyh:lyh /usr/lib/mozilla
#安装chrome  启动 google-chrome
sudo dpkg -i $chrome_path
sudo apt-get -f install -y
sudo dpkg -i $chrome_path
#安装navicat
sudo apt-get install wine1.7 -y
sudo tar zxvf $navicat_path -C $opt_path/
sudo cp -rf $package_dir/navicat/navicat.jpg $navicat_run_path/
sudo cp -rf $package_dir/navicat/navicat.desktop $application_path/
##安装virtialBox  第二次修复安装
sudo dpkg -i $virtualbox_path
#安装JDK
install_jdk
#权限
sudo chown -R lyh:lyh $opt_path
}
install_jdk(){
#安装jdk
tar zxvf $jdk_path -C $install_dir/
cp -rf $install_dir/$jdk_name /usr/lib/jvm/
#-----配置jdk环境变量--------------------------------
if [ -s /etc/profile ] && grep $jdk_name /etc/profile;then
echo 'has'
else
cat>>/etc/profile<<EOF
export JAVA_HOME=/usr/lib/jvm/${jdk_name}
export JRE_HOME=\${JAVA_HOME}/jre  
export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib  
export PATH=\${JAVA_HOME}/bin:\$PATH
EOF
fi
#切换用户生效当前用户的变量
sudo su lyh
source /etc/profile
#切回root
#sudo su
}

