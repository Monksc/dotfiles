#!/usr/bin/env bash
 

__ScriptVersion="1.0.0"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
	echo "Usage :  $0 [options] [--]

    Options:
    -h|help             Display this message
    -v|version          Display script version
    add [song name]+    Adds a song to the queue
    play                Plays the songs in queue
    skip                Skips the top song in queue
    queue|list          Shows the queue
    display             Shows queue but updated constantly
    banner              Shows current song as a banner
    edit                Edits queue"

}    # ----------  end of function usage  ----------

function handleRequest() {
    echo "handle request"
}

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hv" opt
do
  case $opt in

	h|help     )  usage; exit 0   ;;

	v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

	* )  echo -e "\n  Option does not exist : $OPTARG\n"
		  usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))


if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi


#===  FUNCTION  ================================================================
#         NAME:  makeCache
#  DESCRIPTION:  Makes a tempory directory and files for use
#===============================================================================
function makeCache() {
    mkdir -p /tmp/songqueue/songs
    touch /tmp/songqueue/queue.txt
}


#===  FUNCTION  ================================================================
#         NAME:  handleAdd
#  DESCRIPTION:  Handles the add command
#===============================================================================
function handleAdd() {
    function usage ()
    {
        echo "Usage :  0 [options] [--]

        Options:
        -h|help       Display this message
        -v|version    Display script version
        -s|silent     Silent mode"

    }    # ----------  end of function usage  ----------

    #-----------------------------------------------------------------------
    #  Handle command line arguments
    #-----------------------------------------------------------------------

    isSilent=false

    while getopts ":hvs" opt
    do
      case $opt in

        h|help     )  usage; exit 0   ;;

        v|version  )  echo "$0 -- Version __ScriptVersion"; exit 0   ;;

        s|silent   )  isSilent=true;;

        * )  echo -e "\n  Option does not exist : $OPTARG\n"
              usage; exit 1   ;;

      esac    # --- end of case ---
    done
    shift $(($OPTIND-1))

    makeCache
    while [ $# -gt 0 ]
    do
        if $isSilent; then
            (youtube-dl "ytsearch:$1" --audio-format wav -o "/tmp/songqueue/songs/$1.wav" > /dev/null)&
        else
            echo "$1"
            youtube-dl "ytsearch:$1" --audio-format wav -o "/tmp/songqueue/songs/$1.wav"
        fi
        echo "$1" >> /tmp/songqueue/queue.txt
        shift
    done
}

#===  FUNCTION  ================================================================
#         NAME:  handleSkip
#  DESCRIPTION:  Handles the skip command
#===============================================================================
function handleSkip() {
    #cat /tmp/songqueue/queue.txt | head -n 1 | awk -v quote="'" '{ print "rm " quote "/tmp/songqueue/songs/" $0 ".wav" quote }' | bash
    tail -n +2 /tmp/songqueue/queue.txt > /tmp/songqueue/queue-temp.txt
    head -n 1 /tmp/songqueue/queue.txt >> /tmp/songqueue/queue-temp.txt
    cat /tmp/songqueue/queue-temp.txt > /tmp/songqueue/queue.txt
}


#===  FUNCTION  ================================================================
#         NAME:  handlePlay
#  DESCRIPTION:  Handles the play command
#===============================================================================
function handlePlay() {
    while [ $(cat "/tmp/songqueue/queue.txt" | wc -l | awk '{ print $1 }') -gt 0 ]
    do 
        cat /tmp/songqueue/queue.txt | head -n 1 | awk -v quote="'" -v "args=$*" '{ print "afplay " args " " quote "/tmp/songqueue/songs/" $0 ".wav" quote }' | bash
        handleSkip
    done
}


#===  FUNCTION  ================================================================
#         NAME:  handleQueue
#  DESCRIPTION:  Handles the queue command
#===============================================================================
function handleQueue() {
    cat -b /tmp/songqueue/queue.txt
}

#===  FUNCTION  ================================================================
#         NAME:  handleDisplay
#  DESCRIPTION:  Handles the display command
#===============================================================================
function handleDisplay() {
    clear
    echo "Queue"
    handleQueue "$@"
    while true; do
        fswatch -o /tmp/songqueue/queue.txt | (\
            clear; \
            echo "Queue"; \
            handleQueue "$@";)
    done
}

#===  FUNCTION  ================================================================
#         NAME:  handleBanner
#  DESCRIPTION:  Handles the banner command
#===============================================================================
function handleBanner() {
    #===  FUNCTION  ================================================================
    #         NAME:  usage
    #  DESCRIPTION:  Display usage information.
    #===============================================================================
    function usage ()
    {
        echo "Usage :  0 [options] [--]

        Options:
        -h|help       Display this message
        -v|version    Display script version
        -w            Param for width
        -t            Param for time interval"

    }    # ----------  end of function usage  ----------

    #-----------------------------------------------------------------------
    #  Handle command line arguments
    #-----------------------------------------------------------------------

    timeInterval=0.01
    width=50

    while getopts :hvw:t: flag
    do
        case "${flag}" in

            h|help     )  usage; exit 0   ;;

            v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

            w          )  width=${OPTARG}   ;;

            t          )  timeInterval=${OPTARG}   ;;

            * )  echo -e "\n  Option does not exist : $OPTARG\n"
                  usage; exit 1   ;;

      esac    # --- end of case ---
    done
    shift $(($OPTIND-1))

    while true; do
        ((head -n 1 /tmp/songqueue/queue.txt | (xargs banner -w "$width") ) | slowcat "$timeInterval" | lolcat) || exit 1
    done
}

#===  FUNCTION  ================================================================
#         NAME:  handleEdit
#  DESCRIPTION:  Handles edit command
#===============================================================================
function handleEdit() {
    $EDITOR /tmp/songqueue/queue.txt
}

if [[ $1 == "add" ]]; then
    shift
    handleAdd "$@"
    exit 0
fi

if [[ $1 == "play" ]]; then
    shift
    handlePlay "$@"
    exit 0
fi

if [[ $1 == "skip" ]]; then
    shift
    handleSkip "$@"
    exit 0
fi

if [[ $1 == "queue" ]]; then
    shift
    handleQueue "$@"
    exit 0
fi

if [[ $1 == "list" ]]; then
    shift
    handleQueue "$@"
    exit 0
fi

if [[ $1 == "display" ]]; then
    shift
    handleDisplay "$@"
    exit 0
fi

if [[ $1 == "banner" ]]; then
    shift
    handleBanner "$@"
    exit 0
fi

if [[ $1 == "edit" ]]; then
    shift
    handleEdit "$@"
    exit 0
fi

usage
exit 1

