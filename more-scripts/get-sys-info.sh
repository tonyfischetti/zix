#!/usr/local/bin/zsh


mkdir -p sys-info
cd sys-info



~/.zsh/more-scripts/apt-history > apt-history

apt list --installed > apt-installed

echo "$ date" > DATE
date >> DATE

echo '# uname -a' > uname
uname -a >> uname

echo '# lsb_release -a' > lsb_release
lsb_release -a >> lsb_release

echo '# lsusb' > lsusb
lsusb >> lsusb
echo -e '\n' >> lsusb
echo '# lsusb -t' >> lsusb
lsusb -t >> lsusb
echo '# lsusb -v' >> lsusb
lsusb -v >> lsusb

echo '# lscpu' > lscpu
lscpu >> lscpu
echo -e '\n' >> lscpu
echo '# lscpu -a -e' >> lscpu
lscpu -a -e >> lscpu

echo '# lsblk' > lsblk
lsblk >> lsblk
echo -e '\n' >> lsblk
echo '# lsblk -O' >> lsblk
lsblk -O >> lsblk

echo '# lsmod' > lsmod
lsmod >> lsmod

echo '# glxinfo' > glxinfo
glxinfo >> glxinfo

echo '# neofetch' > neofetch
neofetch >> neofetch

echo '# lspci' > lspci
lspci >> lspci
echo -e '\n' >> lspci
echo '# lspci -tv' >> lspci
lspci -tv >> lspci
echo -e '\n' >> lspci
echo '# lspci -vv' >> lspci
lspci -vv >> lspci

sudo lshw -html > lshw.html

echo '# inxi -v 8' > inxi
sudo inxi -v 8 >> inxi

echo '# dmidecode' > dmidecode
sudo dmidecode >> dmidecode

echo '# versions' > versions
echo -e '\n' >> versions
echo 'zsh --version' >> versions
zsh --version >> versions
echo -e '\n' >> versions
echo 'vim --version' >> versions
vim --version >> versions
echo -e '\n' >> versions
echo 'tmux -V' >> versions
tmux -V >> versions
echo -e '\n' >> versions
echo 'lisp --eval "(quit)"' >> versions
lisp --eval '(quit)' >> versions
echo -e '\n' >> versions
echo 'ffmpeg' >> versions
ffmpeg 2>> versions
echo -e '\n' >> versions
echo 'cmus --version' >> versions
cmus --version >> versions
echo -e '\n' >> versions
echo 'R --version' >> versions
R --version >> versions
echo -e '\n' >> versions
echo 'openssl version' >> versions
openssl version >> versions
echo -e '\n' >> versions
echo 'man bcrypt | tail -n1' >> versions
man bcrypt | tail -n 1 >> versions
echo -e '\n' >> versions
echo 'zpaq' >> versions
zpaq >> versions
echo -e '\n' >> versions
echo 'veracrypt --text --version 2> /dev/null' >> versions
veracrypt --text --version 2> /dev/null >> versions

tar --exclude="/home/tony/.config/walc" --exclude="/home/tony/.config/WALC" -Jcvf DOTconfig.tar.xz ~/.config

sudo tar cvf SLASHboot.tar /boot

sudo tar cvfJ ETC.tar.xz /etc


