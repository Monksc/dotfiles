ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"
source $HOME/Projects/dotfiles/zsh-git-prompt/zshrc.sh
PROMPT="%B%m%~%b"'$(git_super_status)'$'\n'"%# "
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# Add environment variable COCOS_X_ROOT for cocos2d-x
export COCOS_X_ROOT="/Users/cameronmonks/Projects/CocosProj"
export PATH=$COCOS_X_ROOT:$PATH

# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x
export COCOS_CONSOLE_ROOT="/Users/cameronmonks/Projects/CocosProj/cocos2d-x/tools/cocos2d-console/bin"
export PATH=$COCOS_CONSOLE_ROOT:$PATH

# Add environment variable COCOS_TEMPLATES_ROOT for cocos2d-x
export COCOS_TEMPLATES_ROOT="/Users/cameronmonks/Projects/CocosProj/cocos2d-x/templates"
export PATH=$COCOS_TEMPLATES_ROOT:$PATH

# Add environment variable ANDROID_SDK_ROOT for cocos2d-x
export ANDROID_SDK_ROOT="/usr/local/Caskroom/android-sdk/4333796"
export PATH=$ANDROID_SDK_ROOT:$PATH
export PATH=$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Add $HOME/.bin to Path
export PATH=$PATH:$HOME/.bin

# Add $HOME/.gem to Path
export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin/

