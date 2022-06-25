#!/usr/bin/env sh

__ScriptVersion="1.0.0"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    echo "Usage :  $0 [options] [--]

    Options:
    list          Display a list of themes
    switch        Changes display to options chosen
    -h|help       Display this message
    -v|version    Display script version"

}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hv" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $__ScriptVersion"; exit 0   ;;

    * )  echo -e "n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))

if [[ $# -lt 1 ]]; then
    usage
    exit 1
fi

#===  FUNCTION  ================================================================
#         NAME:  handleList
#  DESCRIPTION:  Handles list command
#===============================================================================
function handleList() {
    echo "Themes:
        Cartoon Dark
        Cartoon Light
        MacOs Dark
        MacOs Light
        Windows XP"
}


function removeAwesomeConfigAndLink() {
    if [[ -L "$HOME/.config/awesome" ]]; then
        rm "$HOME/.config/awesome"
    fi

    if [[ -f "~/.config/awesome" ]]; then
        echo "Error: ~/.config/awesome already exist." 1>&2
        exit 1
    fi

    ln -s "$HOME/Projects/dotfiles/config/awesome$1" "$HOME/.config/awesome"
}

function switchRofiTheme() {
    if [[ -L "$HOME/.config/rofi" ]]; then
        rm "$HOME/.config/rofi"
    fi

    if [[ -f "~/.config/rofi" ]]; then
        echo "Error: ~/.config/rofi already exist." 1>&2
        exit 1
    fi

    ln -s "$HOME/Projects/dotfiles/config/rofi.$1" "$HOME/.config/rofi"
}


#===  FUNCTION  ================================================================
#         NAME:  handleSwitchTheme
#  DESCRIPTION:  changes theme
#===============================================================================
function handleSwitchTheme() {
    if [[ "$1" == "MacOs" ]]; then
        removeAwesomeConfigAndLink  "-macos"
    elif [[ "$1" == "Cartoon" ]]; then
        removeAwesomeConfigAndLink ""
    elif [[ "$1" == "Windows" ]] && [[ "$2" == "XP" ]]; then
        removeAwesomeConfigAndLink "-windowsxp"
        switchRofiTheme "windowsxp"
        exit 0
    elif [[ "$1" == "Windows" ]]; then
        echo "We dont have that version of windows"
        exit 1
    else
        echo "We dont support $@. Sorry."
        handleList
        exit 1
    fi

    if [[ "$2" == "Dark" ]]; then
        if [[ -L "$HOME/.config/awesome/theme/theme.lua" ]]; then
            rm "$HOME/.config/awesome/theme/theme.lua"
            ln -s "$HOME/.config/awesome/theme/themedark.lua" "$HOME/.config/awesome/theme/theme.lua"
        fi
        switchRofiTheme "darktheme"
    fi
    if [[ "$2" == "Light" ]]; then
        if [[ -L "$HOME/.config/awesome/theme/theme.lua" ]]; then
            rm "$HOME/.config/awesome/theme/theme.lua"
            ln -s "$HOME/.config/awesome/theme/themelight.lua" "$HOME/.config/awesome/theme/theme.lua"
        fi
        switchRofiTheme "lighttheme"
    fi
}

if [[ $1 == "list" ]]; then
    shift
    handleList "$@"
    exit 0
fi

if [[ $1 == "switch" ]]; then
    shift
    handleSwitchTheme "$@"
    exit 0
fi

