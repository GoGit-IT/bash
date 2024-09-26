#!/bin/bash
#Define color codes
YELLOW='\033[1;33m' #Yellow
GREEN='\033[1;32m'  #Green
BLUE='\033[1;36m'   #Blue
RED='\033[1;31m'    #Red
GREY='\033[0;90m'   #Grey
NC='\033[0m'        #No Color
1SPC='\x00'            #1 space
#-- Start code --#
clear
while true; do
clear
echo " "
echo "$(echo -e ${YELLOW}\  \  \  Proxmox bash helper by Mato ${NC})"
echo "$(echo -e ${YELLOW}\  \  \  ${GREY}---------------------------${NC})"
echo " "
echo "$(echo -e ${YELLOW}\  1, Proxmox Host configuration${GREY}-beta${NC})"
echo "$(echo -e ${YELLOW}\  2, Proxmox LXC configuration${NC})"
echo "$(echo -e ${YELLOW}\  3, Proxmox vLinux PC configuration${GREY}-soon${NC})"
echo "$(echo -e ${YELLOW}\  4, Pre-Services preparation${NC})"
echo "$(echo -e ${YELLOW}\  5, Add or remove services${GREY}-soon${NC})"
echo "$(echo -e ${YELLOW}\  6, System Information${NC})"
echo "$(echo -e ${YELLOW}\____________________________________${NC})"
read -p "$(echo -e ${YELLOW} 0, Exit\  \  \  \  \  \  \  \  \  \  \  \  ${BLUE}... )" mainmenu
case "$mainmenu" in
  1 )
  #-- Proxmox HOST config menu--#
  clear
  while true; do
  echo " "
  echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
  echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}----Proxmox HOST Config----${NC})"
  echo " "
  echo "$(echo -e ${YELLOW}\  1, Just do it...now!${NC})"
  echo "$(echo -e ${YELLOW}\  \  \  ${GREY}or choose any step...${NC})"
  echo "$(echo -e ${YELLOW}\  \ 2, Fix Proxmox repository lists${NC})"
  echo "$(echo -e ${YELLOW}\  \ 3, Proxmox update and upgrade${NC})"
  echo "$(echo -e ${YELLOW}\  \ 4, SSH setup${NC})"
  echo "$(echo -e ${YELLOW}\  \ 5, Checking nested virtualization${NC})"
  echo "$(echo -e ${YELLOW}\  \ 6, Add access to shared drives in Unpriviliged LXC${NC})"
  echo "$(echo -e ${YELLOW}_____________________________________________________${NC})"
  read -p "$(echo -e ${YELLOW} 0, Back\  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \ ${BLUE}... )" phostmenu
  case "$phostmenu" in
    1 )
    clear
    echo "$(echo -e ${YELLOW}Just do it...now${NC})"
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    2 )
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}---Fix repository lists----${NC})"
    echo " "
    while true; do
    echo "$(echo -e ${YELLOW} Do you want to use the free no-subscription repository list instead of Enterprise?${NC})"
    read -p "$(echo -e ${YELLOW}  y/n ${NC} ${BLUE}... )" replist
    case "$replist" in
      y|Y )
      echo " "
      echo "$(echo -e ${YELLOW}Disabling Proxmox and Ceph enterprise edition repositories.${NC})"
      sed -i '1s/^/#/' /etc/apt/sources.list.d/pve-enterprise.list
      sed -i '1s/^/#/' /etc/apt/sources.list.d/ceph.list
      echo "$(echo -e ${YELLOW}Adding the no-subscription repository lists.${NC})"
      sh -c 'echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" >> /etc/apt/sources.list.d/pve-enterprise.list'
      sh -c 'echo "deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription" >> /etc/apt/sources.list.d/pve-enterprise.list'
      sh -c 'echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" >> /etc/apt/sources.list'
      echo " "
      echo "$(echo -e ${GREEN}Done.${NC})"
      echo "$(echo -e ${GREY}Press any key to continue...${NC})"
      read -n 1 -s
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Skipping this one...${NC})"
      sleep 1
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter 'y' or 'n'.${NC})"
      sleep 3
      ;;
    esac
    done
    ;;
    3 )
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}----Perform an update------${NC})"
    echo " "
    while true; do
    echo "$(echo -e ${YELLOW} Update Proxmox host?${NC})"
    read -p "$(echo -e ${YELLOW}  y/n ${NC} ${BLUE}... )" pupd
    case "$pupd" in
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
    ;;
    4 )
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}---------SSH setup---------${NC})"
    echo " "
    echo "$(echo -e ${YELLOW}Since SSH is and will be the primary way to manage your server${NC})"
    echo "$(echo -e ${YELLOW}it is a must to change default settings to custom/safer one.${NC})"
    sleep 2
    echo " "
    echo "$(echo -e ${YELLOW}\  First we need to change the default port number to a different one.${NC})"
    echo "$(echo -e ${YELLOW}\  Chose any number you like preferably between 10000 - 65535.${NC})"
    read -p "$(echo -e ${YELLOW}\  \  What port you want to use? Type the number: ${BLUE}... )" phsshport
    sleep 0.5
    sudo sed -i "14s/.*/Port $phsshport/" /etc/ssh/sshd_config
    echo "$(echo -e ${YELLOW} You just set a new SSH port for this device: ${BLUE}$phsshport ${NC})"
    local_ip=$(hostname -I | awk '{print $1}') #Get local IP
    user_name=$(whoami) #Get the user name
    echo "$(echo -e ${YELLOW} Dont forget, from this moment on instead of${BLUE} ssh ${user_name}@${local_ip}${NC})"
    echo "$(echo -e ${YELLOW} you must use the${BLUE} ssh $user_name@$local_ip -p $phsshport ${YELLOW} command to connect.${NC})"
    echo "$(echo -e ${YELLOW} In case something went wrong you can connect via Proxmox GUI any time.${NC})"
    sleep 3
    echo "$(echo -e ${YELLOW} Disabling empty passwords...${NC})"
    sudo sed -i "/PermitEmptyPasswords/s/.*/PermitEmptyPasswords no/" /etc/ssh/sshd_config
    #-- SSH root login --#
    while true; do
    echo " "
    echo "$(echo -e ${YELLOW} ONLY in case you already setup other admin user account${NC})"
    read -p "$(echo -e ${YELLOW} do you want to disable root user login? y/n ${BLUE}... )" psshroot
    case "$psshroot" in
      y|Y )
      echo " "
      echo "$(echo -e ${YELLOW}Disabling root access via SSH.${NC})"
      sudo sed -i "/^#PermitRootLogin/c\PermitRootLogin no" /etc/ssh/sshd_config
      sudo sed -i "/^PermitRootLogin/c\PermitRootLogin no" /etc/ssh/sshd_config
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Skipping or re-enabling root user login.${NC})"
      sudo sed -i "/^#PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
      sudo sed -i "/^PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
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
    echo "$(echo -e ${YELLOW} ONLY in case you already setup the authentication keys${NC})"
    read -p "$(echo -e ${YELLOW} do you want to disable login with passwords? y/n ${BLUE}... )" psshkey
    case "$psshkey" in
      y|Y )
      echo " "
      echo "$(echo -e ${YELLOW}Disabling logging in with passwords.${NC})"
      sudo sed -i "/^#PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
      sudo sed -i "/^PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Skipping or re-enabling password authentication.${NC})"
      sudo sed -i "/^#PasswordAuthentication/c\PasswordAuthentication yes" /etc/ssh/sshd_config
      sudo sed -i "/^PasswordAuthentication/c\PasswordAuthentication yes" /etc/ssh/sshd_config
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    echo " "
    echo "$(echo -e ${YELLOW} SSHConfiguration done.${NC})"
    echo "$(echo -e ${YELLOW} Restarting sshd process so changes take effect.${NC})"
    sudo systemctl restart sshd
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    5 )
    #-- Checking nested virtualization --#
    while true; do
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}Nested virtualization check${NC})"
    echo " "
    echo "$(echo -e ${YELLOW}Choose what CPU your system has!${NC})"
    echo "$(echo -e ${YELLOW}1. AMD${NC})"
    echo "$(echo -e ${YELLOW}2. Intel${NC})"
    read -p "$(echo -e ${YELLOW}Enter 1 or 2 ${BLUE}... )" cputype
    if [ "$cputype" -eq 1 ]; then
    result=$(cat /sys/module/kvm_amd/parameters/nested)
    if [ "$result" == "Y" ]; then
    echo "$(echo -e ${YELLOW}AMD nested virtualization is enabled.${NC})"
    elif [ "$result" == "N" ]; then
    echo "$(echo -e ${YELLOW}AMD nested virtualization is disabled.${NC})"
    else
    echo "$(echo -e ${YELLOW}...therefore it is not an AMD system.${NC})"
    fi
    break
    elif [ "$cputype" -eq 2 ]; then
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
    ;;
    6 )
    #-- Enabling network share access for unpriviliged LXC --#
    while true; do
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}Set network shares for LXCs${NC})"
    echo " "
    read -p "$(echo -e ${YELLOW}Do you want to mount external newtork drives or shared folders? y/n ${BLUE}... )" pshare
    case "$pshare" in
      y|Y )
      echo "$(echo -e ${YELLOW}Type the FULL path where you want to mount your drive/folder on this device: ${NC})"
      echo "$(echo -e ${GREY}Ex.: /mnt/shared/windowsdesktop or /home/user/work ${NC})"
      read -p "$(echo -e ${YELLOW} Path: ${BLUE}...)" localmountpath
      mkdir -p $localmountpath
      echo "$(echo -e ${YELLOW}To add a CIFS or SMB share we need the following: ${NC})"
      read -p "$(echo -e ${YELLOW} Device IP or Network name:${GREY}Ex. 192.168.0.2 ${YELLOW}or${GREY} WORKPC ${BLUE}... )" ipname
      read -p "$(echo -e ${YELLOW} Folder path to share:${GREY}Ex. /work/shared ${BLUE}... )" wsharepath
      read -p "$(echo -e ${YELLOW} Windows user name: ${BLUE}... )" wshareuser
      read -p "$(echo -e ${YELLOW} Windows user password: ${BLUE}... )" wsharepassword
cat >> /etc/fstab <<EOL
$ipname$wsharepath $localmountpath cifs username=$wshareuser,password=$wsharepassword,uid=100000,gid=110000 0 0
EOL
      systemctl daemon-reload
      mount -a
      break
      ;;
      n|N )
      echo "$(echo -e ${YELLOW}Skipping network drive and folder mounting...${NC})"
      sleep 1
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    #-- Enable access to the shared mount to in a LXC --#
    while true; do
    read -p "$(echo -e ${YELLOW}Do you want to add shared folders for a specific LXC? y/n ${BLUE}... )" lxcshare
    case "$lxcshare" in
    y|Y )
    read -p "$(echo -e ${YELLOW} Proxmox ID: ${GREY}Ex.: 111 ${BLUE}... )" lxcid
cat >> /etc/pve/lxc/$lxcid.conf <<EOL
mp0: $localmountpath,mp=$wsharepath
EOL
    echo "$(echo -e ${YELLOW}Mount added for ${BLUE}$lxcid${YELLOW}.${NC})"
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    break
    ;;
    n|N )
    echo "$(echo -e ${YELLOW} Skip adding mounts to a specific LXC...${NC})"
    sleep 1
    break
    ;;
    * )
    echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
    sleep 3
    ;;
    esac
    done
    ;;
    0 )
    clear
    break
    ;;
    esac
    done
  ;;
 2 )
  #-- Proxmox LXC config menu--#
  clear
  while true; do
  clear
  echo " "
  echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
  echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}----Proxmox LXC Config-----${NC})"
  echo " "
  echo "$(echo -e ${YELLOW}\  1, Just do it...now!${NC})"
  echo "$(echo -e ${YELLOW}\  \  \  ${GREY}or choose any step...${NC})"
  echo "$(echo -e ${YELLOW}\  \ 2, Add a new user${NC})"
  echo "$(echo -e ${YELLOW}\  \ 3, Setup SSH${NC})"
  echo "$(echo -e ${YELLOW}\  \ 4, Install essentials${NC})"
  echo "$(echo -e ${YELLOW}\  \ 5, Customise prompt${NC})"
  echo "$(echo -e ${YELLOW}\  \ 6, Customize message of the day${NC})"
  echo "$(echo -e ${YELLOW}_____________________________________________________${NC})"
  read -p "$(echo -e ${YELLOW} 0, Back\  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \  \ ${BLUE}... )" lxcmenu
  case "$lxcmenu" in
    1 )
    clear
    echo "$(echo -e ${YELLOW}Just do it...now${NC})"
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    2 )
    groupadd -g 10000 lxc_shares
    while true; do
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}------Add a new user-------${NC})"
    echo " "
    read -p "$(echo -e ${YELLOW} Do you want to add a new user? y/n ${BLUE}... )" addusr
    case "$addusr" in
      y|Y )
      echo " "
      read -p "$(echo -e ${YELLOW}Enter new user name: ${BLUE}... )" username
      read -p "$(echo -e ${YELLOW}Enter its password: ${BLUE}... )" pasword
      apt install sudo -y >/dev/null 2>&1
      useradd -m "$username"
      echo "$username:$pasword" | chpasswd
      echo "$(echo -e ${YELLOW}User ${BLUE}${username} ${YELLOW}has been created and password set.${NC})"
      mkdir -p /user/$username
      chown $username:$username /home/$username
      while true; do
      echo " "
      read -p "$(echo -e ${YELLOW}Add sudo privileges for new user? y/n ${BLUE}... )" addsudo
      case "$addsudo" in
        y|Y )
        sudo usermod -aG sudo $username
        echo "$(echo -e ${YELLOW} ${username} have now sudo/admin privileges.${NC})"
        break
        ;;
        n|N )
        break
        ;;
        * )
        echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
        sleep 3
        ;;
      esac
      done
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Skipping new user creation...${NC})"
      sleep 2
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    while true; do
    echo " "
    echo "$(echo -e ${YELLOW}ONLY if you already set another user with root/sudo/admin priviliges! ${NC})"
    read -p "$(echo -e ${YELLOW}Do you want to disable root user? y/n ${BLUE}... )" killroot
    case "$killroot" in
      y|Y )
      sudo passwd -l root
      echo "$(echo -e ${YELLOW} Root user is disabled.${NC})"
      break
      ;;
      n|N )
      echo "$(echo -e ${YELLOW}Root user remain.${NC})"
      sleep 1
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    while true; do
    echo " "
    read -p "$(echo -e ${YELLOW}Give access for the shared network drives and folers? y/n ${BLUE}... )" usrshare
    case "$usrshare" in
      y|Y )
      sudo usermod -aG lxc_shares $username
      echo "$(echo -e ${YELLOW}User added to the lxc_shares group.${NC})"
      break
      ;;
      n|N )
      echo "$(echo -e ${YELLOW}Skipping...${NC})"
      sleep 1
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    echo "$(echo -e ${GREY}User configuration complete.Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    3 )
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}--------SSH setup----------${NC})"
    echo " "
    echo "$(echo -e ${YELLOW}Since SSH is and will be the primary way to manage your LXC${NC})"
    echo "$(echo -e ${YELLOW}it is a must to change default settings to custom/safer one.${NC})"
    sleep 2
    echo " "
    echo "$(echo -e ${YELLOW}\  First we need to change the default port number to a different one.${NC})"
    echo "$(echo -e ${YELLOW}\  Chose any number you like preferably between 10000 - 65535.${NC})"
    read -p "$(echo -e ${YELLOW}\  \  What port you want to use? Type the number: ${BLUE}... )" lxcsshport
    sleep 0.5
    sed -i "14s/.*/Port $lxcsshport/" /etc/ssh/sshd_config
    echo "$(echo -e ${YELLOW} You just set a new SSH port for this container: ${BLUE}$lxcsshport ${NC})"
    local_ip=$(hostname -I | awk '{print $1}') #Get local IP
    user_name=$(whoami) #Get the user name
    echo "$(echo -e ${YELLOW} Dont forget, from this moment on instead of${BLUE} ssh ${user_name}@${local_ip}${NC})"
    echo "$(echo -e ${YELLOW} you must use the${BLUE} ssh $user_name@$local_ip -p $lxcsshport ${YELLOW} command to connect.${NC})"
    echo "$(echo -e ${YELLOW} In case something went wrong you can connect via Proxmox GUI any time.${NC})"
    sleep 2
    sed -i "/#AddressFamily any/s/.*/AddressFamily any/" /etc/ssh/sshd_config
    echo "$(echo -e ${YELLOW} Disabling empty passwords...${NC})"
    sed -i "/PermitEmptyPasswords/s/.*/PermitEmptyPasswords no/" /etc/ssh/sshd_config
    #-- SSH root login --#
    while true; do
    echo " "
    echo "$(echo -e ${YELLOW} ONLY in case you already setup other admin user account${NC})"
    read -p "$(echo -e ${YELLOW} do you want to disable root user login? y/n ${BLUE}... )" psshroot
    case "$psshroot" in
      y|Y )
      echo " "
      echo "$(echo -e ${YELLOW}Disabling root access via SSH.${NC})"
      sudo sed -i "/^#PermitRootLogin/c\PermitRootLogin no" /etc/ssh/sshd_config
      sudo sed -i "/^PermitRootLogin/c\PermitRootLogin no" /etc/ssh/sshd_config
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Skipping or re-enabling root user login.${NC})"
      sudo sed -i "/^#PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
      sudo sed -i "/^PermitRootLogin/c\PermitRootLogin yes" /etc/ssh/sshd_config
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
    echo "$(echo -e ${YELLOW}ONLY in case you already setup the authentication keys${NC})"
    read -p "$(echo -e ${YELLOW}do you want to disable login with passwords? y/n ${BLUE}... )" psshkey
    case "$psshkey" in
      y|Y )
      echo " "
      echo "$(echo -e ${YELLOW}Disabling logging in with passwords.${NC})"
      sudo sed -i "/^#PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
      sudo sed -i "/^PasswordAuthentication/c\PasswordAuthentication no" /etc/ssh/sshd_config
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Skipping or re-enabling password authentication.${NC})"
      sudo sed -i "/^#PasswordAuthentication/c\PasswordAuthentication yes" /etc/ssh/sshd_config
      sudo sed -i "/^PasswordAuthentication/c\PasswordAuthentication yes" /etc/ssh/sshd_config
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    echo " "
    echo "$(echo -e ${YELLOW} SSH Configuration done.${NC})"
    echo "$(echo -e ${YELLOW} Restarting sshd process so changes take effect.${NC})"
    systemctl mask ssh.socket >/dev/null 2>&1
    systemctl mask sshd.socket >/dev/null 2>&1
    systemctl disable sshd >/dev/null 2>&1
    systemctl enable ssh >/dev/null 2>&1
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    4 )
    while true; do
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}--Install essential tools--${NC})"
    echo " "
    echo "$(echo -e ${YELLOW}Select the item to install:${NC})"
    echo "$(echo -e ${YELLOW}\  1, All !${NC})"
    echo "$(echo -e ${YELLOW}\  2, Only docker and docker compose.${NC})"
    echo "$(echo -e ${YELLOW}\  3, Install recommended tools:${NC})"
    echo "$(echo -e ${GREY}\  \  Git,Curl,Python3,Net-Tools,Tmux,Htop,Midnight Commander${NC})"
    echo "$(echo -e ${YELLOW}_____________________________________________________${NC})"
    read -p "$(echo -e ${YELLOW} 0, Back\  \  \  \  \  \  \  \  \  \  \  \  \  \  \  Install:${BLUE}... )" sinstall
    case "$sinstall" in
      1 )
      echo " "
      read -p "$(echo -e ${YELLOW}Username for whom we seup:${BLUE}... )" $dockeriuser
      echo "$(echo -e ${YELLOW}Okay, here we go...${NC})"
      apt-get install ca-certificates curl gnupg -y
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      chmod a+r /etc/apt/keyrings/docker.gpg
      echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt update
      apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
      groupadd docker
      sudo usermod -aG docker $dockeriuser
      apt install git -y >/dev/null 2>&1
	  apt install curl -y >/dev/null 2>&1
	  apt install python3 -y >/dev/null 2>&1
      apt-get install net-tools -y >/dev/null 2>&1
      apt install tmux -y >/dev/null 2>&1
      apt install mc -y >/dev/null 2>&1
      echo "$(echo -e ${GREEN}Done${GREY}...please reboot the device.${NC})"
      read -n 1 -s
      ;;
      2 )
      echo " "
      echo "$(echo -e ${YELLOW}Installing Docker and docker compose...${NC})"
      echo "$(echo -e ${GREY}Please wait, can take 2-5 minutes.${NC})"
      apt-get install ca-certificates curl gnupg -y >/dev/null 2>&1
      install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      chmod a+r /etc/apt/keyrings/docker.gpg
      echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      apt update >/dev/null 2>&1
      apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y >/dev/null 2>&1
      groupadd docker >/dev/null 2>&1
      read -p "$(echo -e ${YELLOW}Username for whom we seup:${BLUE}... )" $dockeriuser
      sudo usermod -aG docker $dockeriuser
      echo "$(echo -e ${GREEN}Done${GREY}...please reboot the device${NC})"
      read -n 1 -s
      ;;
      3 )
      echo " "
      echo "$(echo -e ${YELLOW}Installing...${NC})"
      apt update >/dev/null 2>&1
      clear
      echo "$(echo -e ${YELLOW} - Git${NC})"
      apt install git -y
      clear
      echo "$(echo -e ${YELLOW} - Curl${NC})"
      apt install curl -y
      clear
      echo "$(echo -e ${YELLOW} - Python3${NC})"
      apt install python3 -y
      clear
      echo "$(echo -e ${YELLOW} - Net-Tools${NC})"
      apt-get install net-tools -y
      clear      
      echo "$(echo -e ${YELLOW} - Tmux${NC})"
      apt install tmux -y
      clear
      echo "$(echo -e ${YELLOW} - Midnight Commander${NC})"
      apt install mc -y
      clear
      echo "$(echo -e ${YELLOW} - Htop${NC})"
      apt install htop -y
    echo "$(echo -e ${GREEN}Done${GREY}, press any key to continue...${NC})"
    read -n 1 -s
    ;;
    0 )
    break
    ;;
    * )
    echo "$(echo -e ${RED}Invalid input. Please use 0 - 3.${NC})"
    sleep 3
    ;;
    esac
    done
    ;;
    5 )
    while true; do
    #-- Set custom prompt and terminal colors --#
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}------Custom prompt--------${NC})"
    echo " "
    read -p "$(echo -e ${YELLOW}Do you want to customize the prompt?${BLUE}... )" cprompt
    case "$cprompt" in
      y|Y )
      read -p "$(echo -e ${YELLOW}Enter the username to customize its promt: ${BLUE}... )" usrp
      sleep 1
      chsh -s /bin/bash $usrp
      touch /home/$usrp/.bashrc
      touch /home/$usrp/.profile
      touch /home/$usrp/.dircolors
      chown $usrp:$usrp /home/$usrp/.dircolors
cat << 'EOF' >  /home/$usrp/.bashrc
# Set history/scrollback size
HISTSIZE=2000
HISTFILESIZE=2000

# Customize the prompt
force_color_prompt=yes

function bash_prompt(){
    PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
}

bash_prompt

# Set LS_COLORS to color directories
export LS_COLORS="di=1;36"

# User specific aliases and functions
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Enable color support for ls and add handy aliases
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
EOF
   chmod +x /home/$usrp/.bashrc
   chown $usrp:$usrp /home/$usrp/.bashrc
   echo "$(echo -e ${YELLOW} .bashrc file created and set.${NC})"
   echo "$(echo -e ${YELLOW} .bashrc file set.${NC})"
   cat << 'EOF' >> /home/$usrp/.profile
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
EOF
      chmod +x /home/$usrp/.profile
      chown $usrp:$usrp /home/$usrp/.profile
      echo "$(echo -e ${YELLOW} .profile file created and set.${NC})"
      break
      ;;
      n|N )
      echo "$(echo -e ${YELLOW}Skipping promt customization...${NC})"
      sleep 1
      break
      ;;
      * )
     echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
     sleep 3
     ;;
     esac
    done
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    6 )
    #-- Set custom message of the day --#
    while true; do
    clear
    echo " "
    echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
    echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}-----Custom M.o.t.d.-------${NC})"
    echo " "
    read -p "$(echo -e ${YELLOW}Do you want to customize the message of the day?${BLUE}... )" cmotd
    case "$cmotd" in
      y|Y )
      rm /etc/motd
      rm /etc/update-motd.d/10-uname
      ln -s /var/run/motd /etc/motd
      sed -i "37s/.*/#session    optional     pam_mail.so standard noenv # [1]/" /etc/pam.d/sshd
      sed -i "/^#PrintLastLog yes/c\PrintLastLog no" /etc/ssh/sshd_config
      sed -i "/^PrintLastLog yes/c\PrintLastLog no" /etc/ssh/sshd_config
      service ssh restart
      apt install lsb-release -y >/dev/null 2>&1
      apt install fortune -y >/dev/null 2>&1
      apt install cowsay -y >/dev/null 2>&1
      touch /etc/update-motd.d/00-header
      cat << 'EOF' > /etc/update-motd.d/00-header
#!/bin/bash
clear
[ -r /etc/lsb-release ] && . /etc/lsb-release

if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
        # Fall back to using the very slow lsb_release utility
        DISTRIB_DESCRIPTION=$(lsb_release -s -d)
fi

echo
printf "\033[1;32mWelcome to %s (%s).\n\033[0m" "$DISTRIB_DESCRIPTION" "$(uname -r)"
EOF
  chmod +x /etc/update-motd.d/00-header
  touch /etc/update-motd.d/10-sysinfo
  cat << 'EOF' > /etc/update-motd.d/10-sysinfo
#!/bin/sh

hostname=$(hostname)
user=$(whoami)
date=`date`
load=`cat /proc/loadavg | awk '{print $3"% (15minutes)"}'`
root_usage=`df -h / | awk '/\// {print $(NF-1)}'`
root_used=`df -h / | awk '/\// {print $(NF-2)}'`
root_total=`df -h / | awk '/\// {print $(NF-3)}'`
memory_usage=`free -m | awk '/Mem/ {printf("%.2f%%\n", $3/$2*100)}'`
memory=`free -m | awk '/Mem:/ { print $2 }'`
memory_used=`free -m | grep Mem | awk '{print $3 }'`
swap_usage=`free -m | awk '/Swap/ { printf("%3.1f%%", "exit !$2;$3/$2*100") }'`
users=` w -s | grep -v WHAT | grep -v "load average" | wc -l`
time=`uptime | grep -ohe 'up .*' | sed 's/,/\ hours/g' | awk '{ printf $2" "$3 }'`
processes_total=`ps aux | wc -l`
processes_user=`ps -U ${user} u | wc -l`
ip=`ip a | grep inet | grep -v inet6 | awk '$2 ~ /^192/ {print $2}'`
lastlog=`lastlog -u ${user} | grep -v Latest |  awk '{ printf $5" "$6" "$7" "$8" "$9" from "$3 }')`


echo "\033[1;37mSystem information as of: $date\033[0m"
echo " "
echo "\033[1;31mHost name......... \033[1;34m" $hostname
echo "\033[1;31mIP................ \033[1;34m" $ip
echo "\033[1;31mUptime............ \033[1;34m" "$time"
echo "\033[1;31mProcesses......... \033[1;34m" $processes_total "total," $processes_user "yours"
echo "\033[1;31mSystem load....... \033[1;34m" $load
echo "\033[1;31mMemory usage...... \033[1;34m" "using" $memory_used" of "$memory" MB ("$memory_usage")"
echo "\033[1;31mDisk Usage........ \033[1;34m" $root_total"/"$root_used "("$root_usage")"
echo "\033[1;31mSwap usage........ \033[1;34m" $swap_usage
echo "\033[1;31mSSH logins........ \033[1;34m" $users "open sessions"
echo "\033[1;31mLast login........ \033[1;34m" $lastlog
EOF
      chmod +x /etc/update-motd.d/10-sysinfo
      touch /etc/update-motd.d/90-footer
      cat << 'EOF' > /etc/update-motd.d/90-footer
#!/bin/sh

echo "\033[33m"
/usr/games/fortune fortunes | /usr/games/cowsay
#[ -f /etc/motd.tail ] && cat /etc/motd.tail || true
EOF
      chmod +x /etc/update-motd.d/90-footer
      break
      ;;
      n|N )
      echo "$(echo -e ${YELLOW} Skipping message of the day customization...${NC})"
      sleep 1
      break
      ;;
      * )
      echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
      sleep 3
      ;;
    esac
    done
    echo "$(echo -e ${GREY}Press any key to continue...${NC})"
    read -n 1 -s
    ;;
    0 )
    clear
    break
    ;;
    esac
    done
  ;;
3 )
clear
echo "Config. Proxmox vLinux PC"
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
;;
4 )
#-- Pre-Services preparations --#
  while true; do
  clear
  echo " "
  echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
  echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}-Pre-Services preparations-${NC})"
  echo " "
  echo "$(echo -e ${YELLOW}ONLY if docker is already installed and this is a new device!${NC})"
  read -p "$(echo -e ${YELLOW}Do you want to finalize preparation of docker? y/n ${BLUE}... )" startprep
  case $startprep in
    y|Y )
    echo "$(echo -e ${YELLOW}Before we can start adding services, a basic configuration/personalization is required.${NC})"
    echo "$(echo -e ${YELLOW}We just focus the most important and safety critical settings.${NC})"
    echo " "
    echo "$(echo -e ${YELLOW}The following informations are required:${NC})"
    host_name=$(hostname)
    read -p "$(echo -e ${YELLOW}Enter user name for whom we prepare the the docker environment: ${BLUE}... )" dockeruser
    read -p "$(echo -e ${YELLOW}What is your Timezone${GREY}/TZ identifier/ ${BLUE}... )" dockertz
    read -p "$(echo -e ${YELLOW}What is your public domain name${GREY}/eaxmple.com/ ${BLUE}... )" pubdom
    read -p "$(echo -e ${YELLOW}Provide a valid E-Mail addres for TLS certificate${GREY}/example@mail.com/ ${BLUE}... )" tlsmail
    read -p "$(echo -e ${YELLOW}Username for Basic HTTP Authentication ${BLUE}... )" authusr
    read -p "$(echo -e ${YELLOW}Password for Basic HTTP Authentication ${BLUE}... )" authpsw
    echo " "
    sudo usermod -aG docker $dockeruser
    mkdir -p /home/$dockeruser/docker/{secrets,scripts,services}
    chown root:root /home/$dockeruser/docker/secrets
    chmod 600 /home/$dockeruser/docker/secrets
    touch /home/$dockeruser/docker/.env
    chown root:root /home/$dockeruser/docker/.env
    chmod 600 /home/$dockeruser/docker/.env
    echo "$(echo -e ${YELLOW}Your dockerized services will be located ${BLUE}/home/$dockeruser/docker${NC})"
    apt install acl -y >/dev/null 2>&1
    chmod 775 /home/$dockeruser/docker
    setfacl -Rdm u:$dockeruser:rwx /home/$dockeruser/docker
    setfacl -Rm u:$dockeruser:rwx /home/$dockeruser/docker
    setfacl -Rdm g:docker:rwx /home/$dockeruser/docker
    setfacl -Rm g:docker:rwx /home/$dockeruser/docker
    cat > /home/$dockeruser/docker/.env <<EOL
PUID=1000
PGID=1000
TZ="$dockertz"
USERDIR="/home/$dockeruser"
DOCKERDIR="/home/$dockeruser/docker"
DOMAINNAME_1=$pubdom
HOSTNAME="$host_name"
TLSEMAIL="$tlsmail"
EOL
    apt install apache2-utils -y >/dev/null 2>&1
    htpasswd -cBb /home/$dockeruser/docker/secrets/basic_auth_credentials $authusr $authpsw >/dev/null 2>&1
    chown root:root /home/$dockeruser/docker/secrets/basic_auth_credentials
    docker network create --driver bridge socket_proxy >/dev/null 2>&1
    docker network create --driver bridge traefik_proxy >/dev/null 2>&1
    mkdir -p /home/$dockeruser/docker/services/socketproxy
    touch /home/$dockeruser/docker/services/socketproxy/socketproxy-compose.yml
    cat << 'EOF' > /home/$dockeruser/docker/services/socketproxy/socketproxy-compose.yml
services:
  socket-proxy:
    container_name: socket-proxy
    image: tecnativa/docker-socket-proxy
    security_opt:
      - no-new-privileges:true
    restart: unless-stopped
    networks:
      socket_proxy:
        ipv4_address: 192.168.10.254 # You can specify a static IP
    privileged: false # true for VM. false for unprivileged LXC container on Proxmox.
    ports:
      - "127.0.0.1:2375:2375" # Do not forrward this port
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    environment:
      - LOG_LEVEL=info # debug,info,notice,warning,err,crit,alert,emerg
      ## Variables match the URL prefix (i.e. AUTH blocks access to /auth/* parts of the API, etc.).
      # 0 to revoke access.
      # 1 to grant access.
      ## Granted by Default
      - EVENTS=1
      - PING=1
      - VERSION=1
      ## Revoked by Default
      # Security critical
      - AUTH=0
      - SECRETS=0
      - POST=1 # Watchtower
      # Not always needed
      - BUILD=0
      - COMMIT=0
      - CONFIGS=0
      - CONTAINERS=1 # Traefik, Portainer, etc.
      - DISTRIBUTION=0
      - EXEC=0
      - IMAGES=1 # Portainer
      - INFO=1 # Portainer
      - NETWORKS=1 # Portainer
      - NODES=0
      - PLUGINS=0
      - SERVICES=1 # Portainer
      - SESSION=0
      - SWARM=0
      - SYSTEM=0
      - TASKS=1 # Portainer
      - VOLUMES=1 # Portainer
EOF
    touch /home/$dockeruser/docker/start-stack.sh
    cat > /home/$dockeruser/docker/start-stack.sh << EOL
#!/bin/bash
# Sript for starting or stopping all docker services by Mato.
# The task of this script to start and restart all dockerized services
# in a proper order with some pre-determined delay.
# Also providing a query each hour about the status of the containers:
# Health, ping time, uptime.
docker compose -f /home/$dockeruser/docker/services/socketproxy/socketproxy-compose.yml up -d
sleep 15
EOL
    chmod +x /home/$dockeruser/docker/start-stack.sh
    echo "$(echo -e ${GREEN}Done.${NC})"
      break
      ;;
      n|N )
      echo "$(echo -e ${BLUE}Ok, maybe later then...${NC})"
      sleep 1
      break
      ;;
      * )
     echo "$(echo -e ${RED}Invalid input. Please enter Y or N.${NC})"
     sleep 3
     ;;
     esac
    done
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
;;
5 )
clear
echo "Add or remove services"
echo "$(echo -e ${GREY}Press any key to continue...${NC})"
read -n 1 -s
;;
6 )
clear
apt install lsb-release -y >/dev/null 2>&1
apt install curl -y >/dev/null 2>&1
#-- Read system information --#
echo " "
echo "$(echo -e ${YELLOW}\  \  \  ${GREY}Proxmox bash helper by Mato${NC})"
echo "$(echo -e ${YELLOW}\  \  \  ${YELLOW}----System informations----${NC})"
echo " "
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
#-- Display the informations --#
echo " "
echo "$(echo -e ${YELLOW}Your username is ${BLUE}$user_name${YELLOW},${NC})"
echo "$(echo -e ${YELLOW}and the full path of your Home folder is ${BLUE}$home_path${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}You are running Linux version ${BLUE}$release_version${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}Your actual PUID is ${BLUE}$puid${YELLOW} and the PGID is ${BLUE}$pgid${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}Your Time Zone is set to ${BLUE}$time_zone${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}The host name of this device is ${BLUE}$host_name${YELLOW},${NC})"
echo "$(echo -e ${YELLOW}and its domain name is ${BLUE}$domain_name${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}This device has the IP address ${BLUE}$local_ip ${YELLOW}assigned to it.${NC})"
echo "$(echo -e ${YELLOW}The local IP address of your network gateway is ${BLUE}$gateway_ip${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}The DNS server you use has the IP address of ${BLUE}$dns_server${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}Your external or WAN IP address is at the moment ${BLUE}$external_ip${YELLOW}.${NC})"
echo "$(echo -e ${YELLOW}Your disk has ${BLUE}$hdd_space${BLUE}Byte${YELLOW} free space available,${NC})"
echo "$(echo -e ${YELLOW}and you have ${BLUE}$memory_size${BLUE}gs${YELLOW} of system memory installed.${NC})"
echo -e " "
echo "$(echo -e ${YELLOW}Make notes if necessary and doublecheck if all present and as expected.${NC})"
echo "$(echo -e ${GREY}Press any key...${NC})"
read -n 1 -s
;;
0 )
clear
echo " "
echo "$(echo -e ${BLUE}Bye !${NC})"
sleep 0.4
break
;;
esac
done
