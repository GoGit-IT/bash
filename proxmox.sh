#!/bin/bash
#Define color codes
YELLOW='\033[1;33m' #Yellow
GREEN='\033[1;32m'  #Green
BLUE='\033[1;36m'   #Blue
RED='\033[1;31m'    #Red
GREY='\033[0;90m'   #Grey
NC='\033[0m'        #No Color
#-- Proxmox repository list fix --#
clear
while true; do
clear
echo " "
echo "$(echo -e ${YELLOW} Do you want to use Proxmox no-subscription repository list instead of Enterprise?${NC})"
read -p "$(echo -e ${YELLOW}  y/n ${NC}${GREY}...or press Ctrl+C to exit. ${BLUE})" choice1
case "$choice1" in
  y|Y )
echo " "
echo "$(echo -e ${YELLOW}Disabling Proxmox and Ceph enterprise edition repositories.${NC})"
#sed -i '1s/^/#/' /etc/apt/sources.list.d/pve-enterprise.list
#sed -i '1s/^/#/' /etc/apt/sources.list.d/ceph.list
echo "$(echo -e ${YELLOW}Adding the no-subscription repository lists.${NC})"
#sh -c 'echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" >> /etc/apt/sources.list.d/pve-enterprise.list'
#sh -c 'echo "deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription" >> /etc/apt/sources.list.d/pve-enterprise.list'
#sh -c 'echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" >> /etc/apt/sources.list'
echo " "
echo "$(echo -e ${GREEN}Done.${NC})"
    sleep 1
    break
    ;;
  n|N )
    echo "$(echo -e ${BLUE}Skipping this one...${NC})"
    sleep 2
    break
    ;;
  * )
    echo "$(echo -e ${RED}Invalid input. Please enter 'y' or 'n'.${NC})"
    sleep 3
    ;;
esac
done
#-- Proxmox update and upgrade --#
clear
while true; do
clear
echo " "
echo "$(echo -e ${YELLOW} Do you want now update Proxmox?${NC})"
read -p "$(echo -e ${YELLOW}  y/n ${NC}${GREY}...or press Ctrl+C to exit. ${BLUE} )" choice2
case "$choice2" in
  y|Y )
echo " "
echo "$(echo -e ${YELLOW}Updating...${NC})"
apt-get update
echo "$(echo -e ${YELLOW}Starting distribution upgrade...${NC})"
apt dist-upgrade
echo "$(echo -e ${GREEN}Done.${NC})"
    sleep 1
    break
    ;;
  n|N )
    echo "$(echo -e ${BLUE}Skipping this one...${NC})"
    sleep 2
    break
    ;;
  * )
    echo "$(echo -e ${RED}Invalid input. Please enter 'y' or 'n'.${NC})"
    sleep 3
    ;;
esac
done
#-- Checking nested virtualization --#
while true; do
clear
echo " "
echo "$(echo -e ${YELLOW}Choose what CPU your system has!${NC})"
echo "$(echo -e ${YELLOW}1. AMD${NC})"
echo "$(echo -e ${YELLOW}2. Intel${NC})"
read -p "$(echo -e ${YELLOW}Enter 1 or 2: ${BLUE})" choice3

if [ "$choice3" -eq 1 ]; then
    result=$(cat /sys/module/kvm_amd/parameters/nested)
    if [ "$result" == "Y" ]; then
    echo "$(echo -e ${YELLOW}AMD nested virtualization is enabled.${NC})"
    elif [ "$result" == "N" ]; then
    echo "$(echo -e ${YELLOW}AMD nested virtualization is disabled.${NC})"
    else
    echo "$(echo -e ${YELLOW}...therefore it is not an AMD system.${NC})"
    fi
    break
elif [ "$choice3" -eq 2 ]; then
    result=$(cat /sys/module/kvm_intel/parameters/nested)
    if [ "$result" == "Y" ]; then
    echo "$(echo -e ${YELLOW}Intel virtualisation is enabled.${NC})"
    elif [ "$result" == "N" ]; then
    echo "$(echo -e ${YELLOW}Intel virtualisation is disabled.${NC})"
    else
    echo "$(echo -e ${YELLOW}...therefore not an Intel system.${NC})"
    fi
    break
else
    echo "$(echo -e ${RED}Invalid choice. Please enter 1 or 2.${NC})"
    sleep 3
fi
done
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
clear
echo "$(echo -e ${YELLOW} Proxmox is ready${NC})"
echo " "
echo "$(echo -e ${YELLOW} Before you continue make sure:${NC})"
echo "$(echo -e ${BLUE} - You added other users to your Proxmox host if need!${NC})"
echo "$(echo -e ${BLUE} - Made SSH access more secure!${NC})"
echo "$(echo -e ${BLUE} - Enabled the firewall and understand how it is working!${NC})"
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
