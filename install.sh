#!/usr/bin/env sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    ${SCRIPT_NAME} [-h | --help ] [-v | --verbose ] [ --version ] [ dir/in/path ]
#%
#% DESCRIPTION
#%    ${SCRIPT_NAME} simply copies the git-ignore* scripts to a file location which should be in the usrs PATH variable.
#%
#% OPTIONS
#%    -h, --help                  Print this help, cease further execution
#%    -i                          Sets Interactive mode
#%    --log-level                 Sets the log level of the script, similarly to syslog
#%                                Defualt log level is INFO(6)
#%                                See https://en.wikipedia.org/wiki/Syslog#Severity_level for more info.
#%
#%    -v, --verbose               Sets --log-level to Debug(7)
#%    --version                   Displays script information
#%
#% EXAMPLES
#%    ${SCRIPT_NAME}             This will copy the git-ignore* scripts to the default install location: ${DEFALUT_DEST}
#%    ${SCRIPT_NAME} /usr/bin    This will copy the git-ignore* scripts to the /usr/bin directory
#%
#================================================================
#% IMPLEMENTATION
#-    version         ${SCRIPT_NAME} ${SCRIPT_VERSION}
#-    author          Michel J. Reed
#-    license         GPL3
#-    script_id       12345
#-
#================================================================
#  DEBUG OPTION
#    set -n  # Uncomment to check your syntax, without execution.
#    set -x  # Uncomment to debug this shell script
#
#================================================================
# END_OF_HEADER
#================================================================

# This is probably overkill for the installation script but thought this might be useful incase it does more in the future.

#== Required variables ==#
SCRIPT_HEADSIZE=$(head -200 ${0} | grep -n "^# END_OF_HEADER" | cut -f1 -d:)
SCRIPT_NAME="$(basename ${0})"
SCRIPT=$(basename ${BASH_SOURCE[0]})
SCRIPT_VERSION="0.0.1"

InteractiveMode=

#SET DEFAULT OPTIONS
OPT_VERBOSE=false
OPT_LOGLEVEL=6
OPT_GLOBAL=false
OPT_LOCAL=false
OPT_MODE=0
OPT_DEST=/usr/lib/git-core/

#Set fonts for Help.
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

#Set loglevels
LVL_EMERG=0
LVL_ALERT=1
LVL_CRIT=2
LVL_ERR=3
LVL_WARN=4
LVL_NOTICE=5
LVL_INFO=6
LVL_DEBUG=7

declare -A LOG_LEVELS
LOG_LEVELS=([0]="emerg" [1]="alert" [2]="crit" [3]="err" [4]="warning" [5]="notice" [6]="info" [7]="debug")
function log () {
  local LEVEL=${1}
  shift
  if [ ${OPT_LOGLEVEL} -ge ${LEVEL} ]; then
      echo "[${LOG_LEVELS[$LEVEL]}]" "$@"
  fi
}

function replace_bash_variables () {
    output=''
    while IFS='' read -r line ; do
        local sed_args=()
        local varname
        while read varname ; do
            sed_args+=(-e "s/\${$varname}/${!varname}/g")
        done < <(echo "$line" | grep -o '\${[a-zA-Z_][a-zA-Z_]*}' | grep -o '[a-zA-Z_][a-zA-Z_]*' | sort -u)
        if [[ "${#sed_args[@]}" = 0 ]] ; then
            output+="$line"
        else
            output+="$( printf "$line" | sed "${sed_args[@]}")"
        fi
    done
    echo "$output"
}

#== usage functions ==#
usage() { printf "Usage: "; head -${SCRIPT_HEADSIZE:-99} ${0} | grep -e "^#+" | sed -e "s/^#+[ ]*//g" | replace_bash_variables ; }
usagefull() { head -${SCRIPT_HEADSIZE:-99} ${0} | grep -e "^#[%+-]" | sed -e "s/^#[%+-]//g" | replace_bash_variables ; }
scriptinfo() { head -${SCRIPT_HEADSIZE:-99} ${0} | grep -e "^#-" | sed -e "s/^#-//g" | replace_bash_variables ; }

version(){
    echo "${SCRIPT_NAME} ${SCRIPT_VERSION}"
    echo
}

die() {
    printf "$*: " >&2; usage;echo
    echo "Run '${SCRIPT_NAME} -h' to display full help text"
    exit 1
}





main(){

    while getopts :hvi-: opt "$@"; do
        case "${opt}" in
            h )
                usagefull; exit 0;;
            i )
                OPT_MODE=1;;
            v )
                OPT_VERBOSE=true;;
            - ) LONG_OPTARG="${OPTARG#*=}"
                case "${OPTARG}" in
                    version ) version; exit 0;;
                    verbose ) OPT_VERBOSE=true;;
                    log-level* ) OPT_LOGLEVEL=${LONG_OPTARG};;
                    version* | verbose* )
                        die "Option '--$OPTARG' doesn't allow an argument" ;;
                esac;;
            \? ) die "Option '-$OPTARG' is unknown" ;;
        esac
    done
    shift "$((OPTIND-1))"
    
    # set verbosity once (set logging level)
    if [ "$OPT_VERBOSE" = "true" -a "${OPT_LOGLEVEL}" -le "${LVL_INFO}" ]; then
        OPT_LOGLEVEL=$LVL_DEBUG
    fi

    # validate destination argument
    if [ $# -gt 1 ]; then
        die "Illegal number of parameters, Too many arguments given. "
    else
        if [ $# -eq 1 ]; then
            if [ ! -d $1 ]; then
                die "$1 is not a directory"
            else
                OPT_DEST="$1"
            fi
        fi
    fi

    InteractiveMode=${OPT_MODE}

    DEST=$OPT_DEST
    log $LVL_DEBUG "Destination path: $DEST"
    #chmod +x git-*
    cp git-* $DEST

    exit 0
}

main "$@"

