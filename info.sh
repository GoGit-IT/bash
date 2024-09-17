#!/bin/bash
#Define color codes
YELLOW='\033[1;33m' #Yellow
GREEN='\033[1;32m'  #Green
BLUE='\033[1;36m'   #Blue
RED='\033[1;31m'    #Red
GREY='\033[0;90m'   #Grey
NC='\033[0m'        #No Color
clear
release_version=$(lsb_release -d | grep 'Description' | cut -f2-) # Get Distro version
user_name=$(whoami) #Get the user name
host_name=$(hostname) #Get host name
home_path=$(echo $HOME) #Get your home folder path
domain_name=$(dnsdomainname) #Get domain name
external_ip=$(curl -s ifconfig.me) #Get external IP
gateway_ip=$(ip route | grep default | awk '{print $3}') #Get gateway IP
dns_server=$(nslookup www.google.com | grep 'Server:' | awk '{print $2}') #Get DNS server
local_ip=$(hostname -I | awk '{print $1}') #Get local IP
time_zone=$(timedatectl | grep "Time zone" | awk '{print $3}') #Get time zone
puid=$(id -u) #Get PUID (Process User ID)
pgid=$(id -g) #Get PGID (Process Group ID)
hdd_space=$(df -h / | grep / | awk '{print $4}') #Get HDD space
memory_size=$(free -h | grep Mem | awk '{print $2}') #Get memory size

# Display all the the information
echo "Before we start let's check your basic system information."
echo "Make notes if necessary and doublecheck if all present and as expected."
echo " "
echo -e "Your username is \033[1;33m$user_name\033[0m,"
echo -e "and the full path of your Home folder is \033[1;33m$home_path\033[0m."
echo -e "You are running Linux version \033[1;33m$release_version\033[0m."
echo -e "Your actual PUID is \033[1;33m$puid\033[0m and the PGID is \033[1;33m$pgid\033[0m."
echo -e "Your Time Zone is set to \033[1;33m$time_zone\033[0m."
echo -e "The host name of this device is \033[1;33m$host_name\033[0m,"
echo -e "and it's domain name is \033[1;33m$domain_name\033[0m."
echo -e "This device has the IP address \033[1;33m$local_ip\033[0m assigned to it."
echo -e "The local IP address of your network gateway is \033[1;33m$gateway_ip\033[0m."
echo -e "The DNS server you use has the IP address of \033[1;33m$dns_server\033[0m."
echo -e "Your external or WAN IP address is at the moment \033[1;33m$external_ip\033[0m."
echo -e "Your disk has \033[1;33m$hdd_space\033[0m free space available,"
echo -e "and you have \033[1;33m$memory_size\033[0m of system memory installed."
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
