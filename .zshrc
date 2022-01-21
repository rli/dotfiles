# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
setopt globdots
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'

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

# extra
for file in ~/.extra; do
    [ -r "$file" ] && source "$file"
done
unset file

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
