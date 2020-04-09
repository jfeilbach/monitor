#!/bin/bash
# mount remote filesystems
# nas shares:
#    backup
#    documentary
#    extras
#    formula1
#    kids_movies
#    kids_tv
#    movies
#    music
#    shorts
#    shorts_adult
#    tv


HOST=''
OPTS='guest,rw,iocharset=utf8,file_mode=0777,dir_mode=0777,soft,user,noperm'
LOCAL_PATH='/mnt'
CMD='sudo mount'
DIR=${1}
NC='\e[0m'
WHITE='\e[1;37m'
YELLOW='\e[1;33m'
LIGHT_BLUE='\e[1;34m'
CYAN='\e[0;36m'
RED='\e[0;31m'

echo "Checking for root privelages..."
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

echo -e "${CYAN}You are now user:${NC} ${YELLOW}$(whoami)${NC}\n"

if [ -z $1 ] ; then
	echo -e "${RED}You totally failed...${NC}\n"
	exit 1
fi

check_mount_exist () {
    if [[ -d "${LOCAL_PATH}/${DIR}" ]] ; then
        echo -e "Mount point ${WHITE}${LOCAL_PATH}/${DIR}${NC} exists. Proceeding...\n"
        else
        	echo -e "${RED}Mount point ${WHITE}${LOCAL_PATH}/${DIR}${NC}${RED} does not exist. Exiting.${NC}\n"
        	exit 2
    fi
}

mount_remote () {
	echo -e "Mounting /${WHITE}${HOST}${NC}/${WHITE}${REMOTE_MOUNT}${NC} at ${WHITE}${LOCAL_PATH}/${MOUNT_POINT}${NC}...\n"
	${CMD} \
	-t cifs \
	--verbose \
	-o ${OPTS} \
	\/\/${HOST}\/${REMOTE_MOUNT} \
	\/${LOCAL_PATH}\/${MOUNT_POINT}
}

#check_if_mounted () {
#    if [ $? -eq 0 ]; then
#        echo -e "Mounted\n."
#        else
#            echo -e "Something went wrong. Try again.\n"
#    fi
#}

check_mountpoint () {
    if mountpoint -q ${LOCAL_PATH}/${MOUNT_POINT} ; then
        echo -e "\n${CYAN}Mount ${WHITE}/${HOST}/${REMOTE_MOUNT}${NC}${CYAN} was successful.${NC}\n"
        else
            echo -e "\n${RED}Mount ${WHITE}${HOST}/${REMOTE_MOUNT}${NC}${RED} failed. Try again.${NC}\n"
    fi
}
	
case "$1" in
        f1)
            REMOTE_MOUNT='formula1'
            MOUNT_POINT='f1'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
        tv)
            REMOTE_MOUNT='tv'
            MOUNT_POINT='tv'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
        movies)
            REMOTE_MOUNT='movies'
            MOUNT_POINT='movies'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
        kids_tv)
            REMOTE_MOUNT='kids_tv'
            MOUNT_POINT='kids_tv'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
        kids_movies)
            REMOTE_MOUNT='kids_movies'
            MOUNT_POINT='kids_movies'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
	documentary)
            REMOTE_MOUNT='documentary'
            MOUNT_POINT='documentary'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
	shorts)
            REMOTE_MOUNT='shorts_adult'
            MOUNT_POINT='shorts'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
	kids_shorts)
            REMOTE_MOUNT='shorts'
            MOUNT_POINT='kids_shorts'	    
            check_mount_exist
	    mount_remote
	    check_mountpoint
            ;;
        *)
            echo $"Usage: $0 {f1|tv|movies|kids_tv|kids_movies|documentary|shorts|kids_shorts}"
            exit 1
	    ;;
esac

exit 0
