#!/bin/bash
#lib-logging
#This is a library used for warning messages and logging.

ME=${0##*/}

##### COLORS ######
set_colors() {
    case $1 in
        f) tput setaf $2 ;;
        b) tput setab $2 ;;
        r) tput sgr0 ;;
        h) echo -e " f = forground color \n b = background color \n r = reset colors \n 0 = black \n 1 = red \n 2 = green \n 3 = yellow \n 4 = blue \n 5 = magenta \n 6 = cyan \n 7 = white \n These are the same as utilized by tput " ;;
    esac
}

##### STYLING #####
set_style() {
    case $1 in
        b) tput bold ;;
        d) tput dim  ;;
        u) tput smul ;;
        s) tput smso ;;
        h) echo -e " b = bold \n d = dim \n u = underline \n s = standout \n These are the same as utilized by tput " ;;
    esac
}

##### FATAL ERROR #####
fatal() {
	set_colors b 0 && set_colors f 1; 
	set_style b && set_style u && set_style s;
    echo "$ME: Fatal Error:$*";
    set_colors r;
    #exit 2
}

##### WARNING ######
warn() { 
	set_colors b 0 && set_colors f 3;
	echo "$ME: Warning: $*"; 
	set_colors r;
	}
	
##### PRINT TEXT #####	
say() { 
	echo "$ME: $*";
    }
	
##### LOG TEXT #####
log() { 
	echo "$ME: $*" >> $log_file; 
	}
	
##### PRINT AND LOG TEXT #####
shout() {
	set_colors b 0 && set_colors f 1; 
	set_style b; 
	echo "$ME: $*" | tee -a $log_file ; 
	set_colors r;
    }

##### PRINT TEXT IN PLURAL #####
###########SOMEHOW????##########
psay()  { 
	say "$(plural "$@")";
	}
	
plural() {
    local n=$1 str=$2
    case $n in
        1) local s=  ies=y   are=is    have=has;;
        *) local s=s ies=ies are=are   have=have;;
    esac
    echo "$str" | sed -e "s/%s/$s/g" -e "s/%ies/$ies/g"  \
        -e "s/%are/$are/g" -e "s/%have/$have/" -e "s/%n/$n/g"
    }
