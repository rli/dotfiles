# Source Prezto.
# Font: SF Mono Regular (Powerline patcher and/or Nerd Fonts Patch)
# iTerm colors: material-design-colors
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export VISUAL=vim
export EDITOR="$VISUAL"
export TERM="xterm-256color"
# Customize to your needs...
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time load time)
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="000"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="black"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="red"
POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
#POWERLEVEL9K_DIR_HOME_BACKGROUND="001"
#POWERLEVEL9K_DIR_HOME_FOREGROUND="000"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="001"
#POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="000"
#POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\uE0B0'
#POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\uE0B2'

function hidehiddenfiles(){
    defaults write com.apple.finder AppleShowAllFiles -bool NO
    killall Finder
}
function showhiddenfiles(){
    defaults write com.apple.finder AppleShowAllFiles -bool YES
    killall Finder
}

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias use_conda='source ~/miniconda3/bin/activate'
# integrations
# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# paths
export GOPATH=$HOME/go
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# extra
for file in ~/.extra; do
    [ -r "$file" ] && source "$file"
done
unset file
