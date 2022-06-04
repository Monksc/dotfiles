#!/usr/bin/env sh

#defaultIp="192.168.86.26"
#defaultIp="192.168.86.29"
defaultIp="192.168.86.34"

__ScriptVersion="1.0.0"

function displayCommands() {
    echo "Commands:
    volume
    power"
}

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] [--]

    Options:
    -l|list       Display commands
    -h|help       Display this message
    -v|version    Display script version"

}    # ----------  end of function usage  ----------


sendCommand() {
    ip="$1"
    restcommand="$2"
    curl -d "" "http://$ip:8060/$restcommand"
}

keyCommand() {
    ip="$1"
    key="$2"
    curl -d "" "http://$ip:8060/$restcommand"
    sendCommand "$ip" "keypress/$key"
}

inputCommand() {
    ip="$1"
    key="$2"
    curl -d "" "http://$ip:8060/$restcommand"
    sendCommand "$ip" "input/$key"
}


function volume() {
    #===  FUNCTION  ================================================================
    #         NAME:  usage
    #  DESCRIPTION:  Display usage information.
    #===============================================================================
    function volumeusage ()
    {
        echo "Usage :  $0 [options] [--]

        Options:
        -h|help       Display this message
        -v|version    Display script version
        -ip           Ip"

    }    # ----------  end of function usage  ----------

    #-----------------------------------------------------------------------
    #  Handle command line arguments
    #-----------------------------------------------------------------------

    ip="$defaultIp"

    while getopts :hv:i: flag
    do
        case "${flag}" in

            h|help     )  volumeusage; exit 0   ;;

            v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

            i          )  ip=${OPTARG} ;;

            * )  echo -e "\n  Option does not exist : $OPTARG\n"
                  volumeusage; exit 1   ;;

      esac    # --- end of case ---
    done
    shift $(($OPTIND-1))

    if [[ $1 == "up" ]]; then
        shift
        keyCommand "$ip" "volumeUp"
        exit 0
    elif [[ $1 == "down" ]]; then
        shift
        keyCommand "$ip" "volumeDown"
        exit 0
    fi
}

function power() {
    #===  FUNCTION  ================================================================
    #         NAME:  usage
    #  DESCRIPTION:  Display usage information.
    #===============================================================================
    function powerusage ()
    {
        echo "Usage :  $0 [options] [--]

        Options:
        -h|help       Display this message
        -v|version    Display script version
        -ip           Ip"

    }    # ----------  end of function usage  ----------

    #-----------------------------------------------------------------------
    #  Handle command line arguments
    #-----------------------------------------------------------------------

    ip="$defaultIp"

    while getopts :hv:i: flag
    do
        case "${flag}" in

            h|help     )  powerusage; exit 0   ;;

            v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

            i          )  ip=${OPTARG} ;;

            * )  echo -e "\n  Option does not exist : $OPTARG\n"
                  powerusage; exit 1   ;;

      esac    # --- end of case ---
    done
    shift $(($OPTIND-1))

    if [[ $1 == "on" ]]; then
        shift
        keyCommand "$ip" "powerOn"
        exit 0
    elif [[ $1 == "off" ]]; then
        shift
        keyCommand "$ip" "powerOff"
        exit 0
    fi
}

if [[ "$1" == "volume" ]]; then
    shift
    volume "$@"
    exit 0
elif [[ "$1" == "power" ]]; then
    shift
    power "$@"
    exit 0
else
    #-----------------------------------------------------------------------
    #  Handle command line arguments
    #-----------------------------------------------------------------------

    while getopts ":lhv" opt
    do
      case "$opt" in

        l|list     )  displayCommands; exit 0 ;;

        h|help     )  usage; exit 0   ;;

        v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
              usage; exit 1   ;;

      esac    # --- end of case ---
    done
    shift $(($OPTIND-1))
fi

