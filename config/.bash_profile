#export PS1="\u:\w\n$ "
#export PS1="\u@\h\w $ "
#alias valgrind="$HOME/RPI/RPI/Year1/Semester1/DataStructures/valgrind-patched-mac-10-13/vg-in-place"
#export PATH="$PATH:/$HOME/.flutterd/bin"
#export JAVA_HOME='/Library/Java/JavaVirtualMachines/openjdk-14.0.1.jdk/Contents/Home'
export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/'
export PATH=$PATH:$JAVA_HOME/bin
#export PATH_TO_FX="/Library/Java/Libraries/javafx-sdk-11.0.2/lib"

#export ANDROID_HOME="$HOME/Library/Android/"
#alias newjava="/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java"
export PATH="$PATH:$ANDROID_HOME"
#export GOROOT="$HOME/Projects/go"
#export GOPATH="$HOME/Projects"
unset GOROOT
export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$HOME/Projects/bin"
export PATH="$PATH:$HOME/Projects/dotfiles/.bin"
export PATH="$PATH:$HOME/Projects/cproj/viminput"

#export PATH="$PATH:./"


# For Seliunium
#alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
#export PATH="$PATH:$HOME/Projects/socialmedia"

# Dotnet
#export PATH=$HOME/.dotnet/tools:$PATH

alias t="set -o ignoreeof"
#alias ll="ls -G -lh -all --color=auto"
#alias ll="ls -G -lh -all"
alias c="gcc -g -Wall -Werror -Wvla -fsanitize=address"

alias wine32v2="WINEARCH=win32 WINEPREFIX=~/.wine32 winecfg"

echo "Welcome Cameron!"
# cal
# date


# add git graph alias
alias gitg='git log --oneline --abbrev-commit --all --graph --decorate --color'

# Con bash prompt
function exit_color {
if [[ $? = "0" ]]; then
	xcolor="\\[\\033[32m\\]";
else
	xcolor="\\[\\033[31m\\]";
fi
}

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function get_prompt {
	exit_color
	PS1="\[\033[01;36m\]\w\[\033[01;35m\]$(parse_git_branch)\n$(echo $xcolor)> \[\033[01;00m\]"
}

PROMPT_COMMAND=get_prompt
#export PATH="/usr/local/opt/llvm/bin:$PATH"

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
#export COCOS_CONSOLE_ROOT=$HOME/Projects/cocos/cocos2d-x-4.0/tools/cocos2d-console/bin
#export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
#export COCOS_X_ROOT=$HOME/Projects/cocos
#export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
#export COCOS_TEMPLATES_ROOT=$HOME/Projects/cocos/cocos2d-x-4.0/templates
#export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export ANDROID_SDK_ROOT="/usr/local/Caskroom/android-sdk/4333796"
export NDK_ROOT="/usr/local/Caskroom/android-sdk/4333796/ndk/21.3.6528147"
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/usr/local/opt/llvm/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/libffi/lib"
#export CPPFLAGS="-I/usr/local/opt/libffi/include"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"


# Folders
export RPI="$HOME/RPI"
export PROJ="$HOME/Projects"


export PYENV_VERSION="3.7.9"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"

# eval "$(opam env)"

# Changing python versions
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

EDITOR="vim"
export EDITOR

# silence zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# Functions

confirm() {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

ip() {
    if [ "$1" == "tor" ]; then
        curl --socks5-hostname localhost:9050 ifconfig.me
    elif [ "$1" == "global" ]; then
        curl ifconfig.me
    elif [ "$1" == "local" ]; then
        ifconfig | grep "192" | awk '{print $2}'
    else
        echo '[tor|global|local]'
    fi
}

ssh-helper() {
    if [ "$1" == "list" -a $# -eq 1 ]; then
        nmap -rn $(ip local)/24 -p 22 | grep -B 5 "open"
    elif [ "$1" == "list" -a "$2" == "ip" -a $# -eq 2 ]; then
        ssh-helper list | sed -rn 's/.*([0-9]{3}\.[0-9]+\.[0-9]+\.[0-9]+).*/\1/gp'
    elif [ "$1" == "list" -a "$2" == "ip" ]; then
        ssh-helper list ip | head -n "$3"
    elif [ $# -eq 1 ]; then
        ssh "$1"@$(ssh-helper list ip 1)
    else
        echo "[list[ ip][ #]|username]"
    fi
}

random-sequence() {
    if [ $# == 2 ]; then
        cat /dev/urandom | LC_ALL=C tr -dc "$1" | fold -w "$2" | head -n 1
    else
        echo "random-sequence <regex> <length>"
    fi
}

my-tmux-cddir() {
    tmux command-prompt "attach -c $(pwd)"
}

my-flutter-device-id() {
    flutter devices | grep 'mobile' | awk -v'FS=•' 'NF>2{ print $2 }'
}

my-kill-regex() {
    if [ "$#" -lt 1 ]; then
        echo "You need to supply an argument"
    else
        ps aux | grep -i "$1"
        confirm "Do you want to kill these applications?" && kill -s 9 $(ps aux | grep -i "$1" | awk '{print $2}')
    fi
}

my-kill-wine() {
    my-kill-regex 'lutris\|wine\|unreal\|epic'
}

my-kill-discord() {
    my-kill-regex 'discord'
}

my-cpu-speed() {
    if [ "$#" -lt 1 ]; then
        echo "You need to supply an argument of performance or energy."
    elif [ "$@" == "performance" ]; then
        sudo cpupower frequency-set -u 4.8GHZ
        sudo cpupower frequency-set -g performance
        sudo x86_energy_perf_policy --turbo-enable 1
        PCIE_ASPM_ON_BAT=powersupersave
    elif [ "$@" == "energy" ]; then
        sudo cpupower frequency-set -u 1.2GHZ
        sudo cpupower frequency-set -g powersave
        sudo x86_energy_perf_policy --turbo-enable 0
    fi
}

my-setup-awesome() {
    setxkbmap -option 'caps:ctrl_modifier' &
    xinput --set-prop --type=int "PIXA3854:00 093A:0274 Touchpad" 'libinput Natural Scrolling Enabled Default' 1
    xinput --set-button-map "PIXA3854:00 093A:0274 Touchpad" 1 2 3 5 4
    xinput set-prop "PIXA3854:00 093A:0274 Touchpad" "libinput Click Method Enabled" 0 1
    echo "Good"
}

my-setup-disablemouse() {
    xinput --set-prop --type=int 'PIXA3854:00 093A:0274 Touchpad' 'libinput Disable While Typing Enabled' "$1"
    xinput --set-prop --type=int 'PIXA3854:00 093A:0274 Touchpad' 'libinput Disable While Typing Enabled Default' "$1"
}

my-setup-gaming() {
    my-setup-disablemouse 0
}

my-setup-get-monitor-size() {
    xrandr --prop | rg "^$1" | awk '{print $4}' | awk -v 'FS=[x+]' '{ print $'"$2"' }'
}

my-setup-external-monitor-open() {
    xrandr --output DP-1 --scale 1.5 --primary --auto --right-of eDP-1
    xrandr --output DP-2 --scale 1.5 --primary --auto --right-of DP-1
    xrandr --output DP-2 --scale 1.5 --pos 5136x0
    # xrandr --setmonitor VIRTUAL-LEFT 1440/0x1620/1+5136+0 DP-2
    # xrandr --setmonitor VIRTUAL-RIGHT 1440/1x1620/1+6576+0 none
}

my-setup-external-monitor-close() {
    xrandr --output 'DP-1' --off
    xrandr --output 'DP-2' --off
}

my-setup-apple-trackpad() {
    xinput --set-prop --type=int "Apple Inc. Magic Trackpad 2" 'libinput Natural Scrolling Enabled' 1
    xinput --set-prop --type=int "Apple Inc. Magic Trackpad 2" 'libinput Natural Scrolling Enabled Default' 1
    setxkbmap -option 'caps:ctrl_modifier' &
}

my-setup-i3() {
    #setxkbmap -option ctrl:swapcaps &
    #setxkbmap -option capslock:ctrl_modifier &
    setxkbmap -option 'caps:ctrl_modifier' &
    xinput --set-prop --type=int "PIXA3854:00 093A:0274 Touchpad" 'libinput Natural Scrolling Enabled Default' 1
    #xinput --set-prop --type=int "Apple Inc. Magic Trackpad 2" 'libinput Natural Scrolling Enabled Default' 1
    #xinput --set-button-map "PIXA3854:00 093A:0274 Touchpad" 1 2 3 5 4 7 6
    # xinput --set-button-map "Apple Inc. Magic Trackpad 2" 1 2 3 5 4 7 6
    #synclient VertScrollDelta=-111
    xinput set-prop "PIXA3854:00 093A:0274 Touchpad" "libinput Click Method Enabled" 0 1
    feh --bg-fill --randomize /home/cammonks/Projects/dotfiles/images/
    echo "Good"
}

say() {
    if [ "$(uname -s)" == 'Darwin' ]; then
        say "$@"
    else
        if [ "$#" -eq 0 ]; then
            espeak-ng -v en-gb-scotland
        else
            echo "$@" | espeak-ng -v en-gb-scotland
        fi
    fi
}

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias tre='tree -I "node_modules|cache|test_*|build"'

alias ishell2='rlwrap -a -c'
alias vimdebug='/usr/local/bin/vim'

alias vimjupyter='rlwrap fromterminal easypipe read vim "|"'
alias vimjupyterpython='rlwrap fromterminal easypipe read vim "|" ipython'

alias psql13='/usr/local/Cellar/postgresql@13/13.4/bin/psql'
alias pg_restore13='/usr/local/Cellar/postgresql@13/13.4/bin/pg_restore'

# Add in key bindings
# bind -x '"\ef":"say \"Its now control W.\""'
# stty werase undef
# bind "\C-w":forward-word
# bind "\C-h":backward-word
# bind "\C-n":forward-word

export NODE_ENV=development

# Bash Auto Complete
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/bash_setup && test -f "$HEROKU_AC_BASH_SETUP_PATH" && source "$HEROKU_AC_BASH_SETUP_PATH";

# $(flutter bash-completion)
# flutter bash-completion | bash

# Add in All Application to source
if [ "$(uname -s)" == 'Darwin' ]; then
    for d in /Applications/*/Contents/MacOS ; do
        export PATH="$PATH:$d"
    done
fi

for d in "$HOME"/Projects/bin/* ; do
    export PATH="$PATH:$d"
done

#archey
#neofetch
# archey | slowcat 0.1 | lolcat
# banner "Hello World" | slowcat 0.01 | lolcat


export CPATH="$CPATH:/usr/local/lib/"
export CPATH="$CPATH:/usr/local/include/glib-2.0"
export CPATH="$CPATH:/usr/local/include"
export C_INCLUDE_PATH="$C_INCLUDE_PATH:/opt/X11/include"

if [ "$(uname -s)" == 'Darwin' ]; then
    # alias ip='ifconfig | grep "192" | awk '"'"'{print $2}'"'"
    # alias ssh-list='nmap -rn $(ip)/24 -p 22 | grep -B 5 "open"'
    # alias ssh-list-ip='ssh-list | sed -rn '"'"'s/.*([0-9]{3}\.[0-9]+\.[0-9]+\.[0-9]+).*/\1/gp'"'"
    # alias ssh-list-ip-1='ssh-list-ip | head -n 1'
    # alias ssh-pi='ssh pi@$(ssh-list-ip-1)'
    export PATH="$(brew --prefix bison)/bin:$PATH"
    export PATH="$(brew --prefix flex)/bin:$PATH"
    alias ll="ls -G -lh -all"
    export PATH="/usr/local/opt/node@16/bin:$PATH"
fi

if [ "$(uname -s)" != 'Darwin' ]; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    alias open='xdg-open'
    alias open-mime='mimeopen'
    alias ll="ls -G -lh -all --color=auto"
fi

export PATH="$HOME/.local/bin:$PATH"

#export PAGER=less
