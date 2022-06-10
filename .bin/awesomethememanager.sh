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
        Windows"
}

#===  FUNCTION  ================================================================
#         NAME:  handleSwitchTheme
#  DESCRIPTION:  changes theme
#===============================================================================
function handleSwitchTheme() {
    if [[ "$1" == "MacOs" ]]; then
        if [[ -L "$HOME/.config/awesome/theme/theme.lua" ]]; then
            rm "$HOME/.config/awesome/theme/theme.lua"
        fi

        if [[ -f "~/.config/awesome" ]]; then
            echo "Error: ~/.config/awesome already exist." 1>&2
            exit 1
        fi

        ln -s "$HOME/Project/dotfiles/config/awesome-macos" "$HOME/.config/awesome"
    elif [[ "$1" == "Cartoon" ]]; then
        if [[ -L "$HOME/.config/awesome/theme/theme.lua" ]]; then
            rm "$HOME/.config/awesome/theme/theme.lua"
        fi

        if [[ -f "~/.config/awesome" ]]; then
            echo "Error: ~/.config/awesome already exist." 1>&2
            exit 1
        fi

        ln -s "$HOME/Project/dotfiles/config/awesome" "$HOME/.config/awesome"
    elif [[ "$1" == "Windows" ]]; then
        echo "Windows is being built."
    else
        echo "We dont support $@. Sorry."
        handleList
    fi

    if [[ "$2" == "Dark" ]]; then
        if [[ -L "$HOME/.config/awesome/theme/theme.lua" ]]; then
            rm "$HOME/.config/awesome/theme/theme.lua"
            ln -s "$HOME/.config/awesome/theme/themedark.lua" "$HOME/.config/awesome/theme/theme.lua"
        fi
        if [[ -L "$HOME/.config/rofi" ]]; then
            rm "$HOME/.config/rofi"
            ln -s "$HOME/Projects/dotfiles/config/rofi.darktheme" "$HOME/.config/rofi"
        fi
    fi
    if [[ "$2" == "Light" ]]; then
        if [[ -L "$HOME/.config/awesome/theme/theme.lua" ]]; then
            rm "$HOME/.config/awesome/theme/theme.lua"
            ln -s "$HOME/.config/awesome/theme/themelight.lua" "$HOME/.config/awesome/theme/theme.lua"
        fi
        if [[ -L "$HOME/.config/rofi" ]]; then
            rm "$HOME/.config/rofi"
            ln -s "$HOME/Projects/dotfiles/config/rofi.lighttheme" "$HOME/.config/rofi"
        fi
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

