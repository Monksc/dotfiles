#export PS1="\u:\w\n$ "
#export PS1="\u@\h\w $ "
#alias valgrind="/Users/cameronmonks/RPI/RPI/Year1/Semester1/DataStructures/valgrind-patched-mac-10-13/vg-in-place"
#export PATH="$PATH:/Users/cameronmonks/.flutterd/bin"
#export JAVA_HOME='/Library/Java/JavaVirtualMachines/openjdk-14.0.1.jdk/Contents/Home'
#export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/'
#export PATH=$PATH:$JAVA_HOME/bin
#export PATH_TO_FX="/Library/Java/Libraries/javafx-sdk-11.0.2/lib"

#export ANDROID_HOME="/Users/cameronmonks/Library/Android/"
#alias newjava="/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java"
#export PATH="$PATH:$ANDROID_HOME"
#export GOROOT="/Users/cameronmonks/Projects/go"
#export GOPATH="/Users/cameronmonks/Projects/go"
#export PATH="$PATH:$GOPATH/bin"
#export PATH="$PATH:/Users/cameronmonks/.bin"
#export PATH="$PATH:./"


# For Seliunium
#alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
#export PATH="$PATH:/Users/cameronmonks/Projects/socialmedia"

# Dotnet
#export PATH=$HOME/.dotnet/tools:$PATH

alias t="set -o ignoreeof"
alias ll="ls -G -lh -all"
alias c="gcc -g -Wall -Werror -Wvla -fsanitize=address"

echo "Welcome Cameron!"

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
#export COCOS_CONSOLE_ROOT=/Users/cameronmonks/Projects/cocos/cocos2d-x-4.0/tools/cocos2d-console/bin
#export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_X_ROOT for cocos2d-x
#export COCOS_X_ROOT=/Users/cameronmonks/Projects/cocos
#export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
#export COCOS_TEMPLATES_ROOT=/Users/cameronmonks/Projects/cocos/cocos2d-x-4.0/templates
#export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
#export ANDROID_SDK_ROOT="/usr/local/Caskroom/android-sdk/4333796"
#export NDK_ROOT="/usr/local/Caskroom/android-sdk/4333796/ndk/21.3.6528147"
#export PATH=$ANDROID_SDK_ROOT:$PATH
#export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

#export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/usr/local/opt/llvm/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/libffi/lib"
#export CPPFLAGS="-I/usr/local/opt/libffi/include"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"


# Folders
export RPI="/Users/cameronmonks/RPI"
export PROJ="/Users/cameronmonks/Projects"

export PYENV_VERSION="3.7.9"
# Changing python versions
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
