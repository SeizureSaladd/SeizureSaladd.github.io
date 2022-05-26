#!/bin/sh

ETC_HOSTS=/etc/hosts
OLD_OSX=/private/etc/hosts
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' 


function uninstall() {
   if [ -f "$ETC_HOSTS" ]
   then
		echo -e "${BLUE}======= Cloaks+ Installer =======${NC}"
		IP="161.35.130.99"
		HOSTNAME="s.optifine.net"
		HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
		if [ -n "$(grep $HOSTS_LINE $ETC_HOSTS)" ]
		then
			echo -e "${YELLOW}Cloaks+ found in hosts file, Removing now...${NC}";
			sudo sed -i".bak" "/$HOSTS_LINE/d" $ETC_HOSTS
			sudo dscacheutil -flushcache;
			if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo -e "${RED}Failed to uninstall Cloaks+, Try again.${NC}";
                else
                    echo -e "${GREEN}Cloaks+ successfully uninstalled!${NC}";
			fi
		else
			echo -e "${RED}Cloaks+ was not found in your $ETC_HOSTS file.${NC}";
		fi
   else
		IP="161.35.130.99"
		HOSTNAME="s.optifine.net"
		HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
		if [ -n "$(grep $HOSTS_LINE $OLD_OSX)" ]
		then
			echo -e "${YELLOW}Cloaks+ found in hosts file, Removing now...${NC}";
			sudo sed -i".bak" "/$HOSTS_LINE/d" $OLD_OSX
			sudo dscacheutil -flushcache;
			if [ -n "$(grep $HOSTNAME $OLD_OSX)" ]
                then
                    echo -e "${RED}Failed to uninstall Cloaks+, Try again.${NC}";
                else
                    echo -e "${GREEN}Cloaks+ successfully uninstalled!${NC}";
			fi
		else
			echo -e "${RED}Cloaks+ was not found in your $OLD_OSX file.${NC}";
		fi
	fi	
}

function install() {
	echo -e "${BLUE}======= Cloaks+ Installer =======${NC}"
    IP="161.35.130.99"
    HOSTNAME="s.optifine.net"
    HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
    line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )
	if [ -f "$ETC_HOSTS" ];
	then
		if [ -n "$(grep $HOSTS_LINE $ETC_HOSTS)" ]
        then
            echo -e "${RED}Cloaks+ is already installed : ${YELLOW}$(grep $HOSTNAME $ETC_HOSTS)${NC}"
        else
            echo -e "${YELLOW}Installing Cloaks+...${NC}";
			sudo sed -i".bak" "/$HOSTNAME/d" $ETC_HOSTS;
            sudo -- sh -c -e "echo '$line_content' >> /etc/hosts";
			sudo dscacheutil -flushcache;

            if [ -n "$(grep $HOSTNAME $ETC_HOSTS)" ]
                then
                    echo -e "${GREEN}Cloaks+ was installed succesfully!${NC}";
                else
                    echo -e "${RED}Failed to install Cloaks+, Try again.${NC}";
            fi
		fi
	else
		IP="161.35.130.99"
		HOSTNAME="s.optifine.net"
		HOSTS_LINE="$IP[[:space:]]$HOSTNAME"
		line_content=$( printf "%s\t%s\n" "$IP" "$HOSTNAME" )
		if [ -n "$(grep $HOSTS_LINE $OLD_OSX)" ]
        then
            echo -e "${RED}Cloaks+ is already installed : ${YELLOW}$(grep $HOSTNAME $OLD_OSX)${NC}"
        else
            echo "Installing Cloaks+...";
			echo -e "${YELLOW}Installing Cloaks+...${NC}";
			sudo sed -i".bak" "/$HOSTNAME/d" $OLD_OSX;
            sudo -- sh -c -e "echo '$line_content' >> /private/etc/hosts";
			sudo dscacheutil -flushcache;

            if [ -n "$(grep $HOSTNAME $OLD_OSX)" ]
                then
                    echo -e "${GREEN}Cloaks+ was installed succesfully!${NC}";
                else
                    echo -e "${RED}Failed to install Cloaks+, Try again.${NC}";
            fi
		fi
	fi
}

if [ $# -eq 0 ]
  then
    echo -e "${BLUE}======= Cloaks+ Installer =======${NC}"
    echo -e "${RED}Please supply an argument and try again.${NC}"
fi

$@