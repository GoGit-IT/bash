#!/bin/bash
#Define color codes
YELLOW='\033[1;33m' #Yellow
GREEN='\033[1;32m'  #Green
BLUE='\033[1;36m'   #Blue
RED='\033[1;31m'    #Red
GREY='\033[0;90m'   #Grey
NC='\033[0m'        #No Color
user_name=$(whoami) #Get the user name
local_ip=$(hostname -I | awk '{print $1}') #Get local IP
#-- Introduction text --#
clear
echo " "
echo "$(echo -e ${YELLOW}   Configuring basic SSH settings${NC})"
echo "$(echo -e ${YELLOW} Since SSH is and will be the primary way to access your server${NC})"
echo "$(echo -e ${YELLOW} we will change default settings to safer one.${NC})"
sleep 2
echo " "
echo "$(echo -e ${YELLOW} The first thing we need to change is the default port number -22- to something different.${NC})"
echo "$(echo -e ${YELLOW} Chose any number you like preferably between 10000 - 65535.${NC})"
read -p "$(echo -e ${YELLOW}   What port you want to use? Type the number: ${BLUE})" choice1
sleep 1
sudo sed -i "14s/.*/Port $choice1/" /etc/ssh/sshd_config
echo "$(echo -e ${YELLOW} You just set a new SSH port for this device: ${BLUE}$choice1${NC})"
echo "$(echo -e ${YELLOW} Dont forget, from this moment on instead of${BLUE} ssh ${user_name}@${local_ip}${NC})"
echo "$(echo -e ${YELLOW} you must use the${BLUE} ssh $user_name@$local_ip -p $choice1 ${YELLOW} command to connect.${NC})"
sleep 3
echo "$(echo -e ${YELLOW} Disabling empty passwords...${NC})"
sudo sed -i "/PermitEmptyPasswords/s/.*/PermitEmptyPasswords no/" /etc/ssh/sshd_config
#-- SSH root login --#
while true; do
echo " "
echo "$(echo -e ${YELLOW} In case you already setup other admin user account,${NC})"
read -p "$(echo -e ${YELLOW} do you want to disable root user login? y/n ${BLUE})" choice2
case "$choice2" in
  y|Y )
echo " "
echo "$(echo -e ${YELLOW}Disabling root access via SSH.${NC})"
sudo sed -i "/^#PermitRootLogin/c\PermitRootLogin no" /etc/ssh/sshd_config
sudo sed -i "/^PermitRootLogin/c\PermitRootLogin no" /etc/ssh/sshd_config
    sleep 1
    break
    ;;
  n|N )
    echo "$(echo -e ${BLUE}Skipping or re-enabling root user login.${NC})"
    sudo sed -i "/^#PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
    sudo sed -i "/^PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
    sleep 2
    break
    ;;
  * )
    echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
    sleep 3
    ;;
esac
done
#-- SSH password or key authentication --#
while true; do
echo " "
echo "$(echo -e ${YELLOW} In case you already setup the authentication keys${NC})"
read -p "$(echo -e ${YELLOW} do you want to disable password login? y/n ${BLUE})" choice3
case "$choice3" in
  y|Y )
echo " "
echo "$(echo -e ${YELLOW}Disabled logging in with passwords.${NC})"
    sudo sed -i "/^#PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
    sudo sed -i "/^PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
    sleep 1
    break
    ;;
  n|N )
    echo "$(echo -e ${BLUE}Skipping or re-enabling password authentication.${NC})"
    sudo sed -i "/^#PasswordAuthentication/c\PasswordAuthentication yes" /etc/ssh/sshd_config
    sudo sed -i "/^PasswordAuthentication/c\PasswordAuthentication yes" /etc/ssh/sshd_config
    sleep 2
    break
    ;;
  * )
    echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
    sleep 3
    ;;
esac
done
#-- Proxmox LXC or other device --#
while true; do
echo " "
read -p "$(echo -e ${YELLOW} Is this device a Proxmox LXC? y/n ${BLUE})" choice4
case "$choice4" in
  y|Y )
echo " "
echo "$(echo -e ${YELLOW} SSHConfiguration done.${NC})"
echo "$(echo -e ${YELLOW} Restarting sshd process in this LXC so changes take effect.${NC})"
#    sudo systemctl mask ssh.socket
#    sudo systemctl mask sshd.socket
#    sudo systemctl disable sshd
#    sudo systemctl enable ssh
    sleep 1
    break
    ;;
  n|N )
echo "$(echo -e ${YELLOW} SSHConfiguration done.${NC})"
echo "$(echo -e ${YELLOW} Restarting sshd process so changes take effect.${NC})"
#    sudo systemctl restart sshd
    sleep 2
    break
    ;;
  * )
    echo "$(echo -e ${RED}Invalid input. Please enter y or n.${NC})"
    sleep 3
    ;;
esac
done
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
