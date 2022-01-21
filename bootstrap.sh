#!/bin/zsh
# zsh should be available on OSX >= 10.12. change to bash and symlink
#     zprezto manually if this is not the case

# see https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# or https://github.com/atomantic/dotfiles/blob/master/install.sh
# for more tweaks

ABSPATH=$(cd "$(dirname "$0")"; pwd)

# get a sudo token
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# disable guest login
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Finder
# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -bool true
# Set theme to dark
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
# Open home directory by default
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# List view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true
# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# disable .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# dock size
defaults write com.apple.dock tilesize -int 36
killall Dock

# Spotlight
# Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some file types from being indexed
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null

# misc
# verbose boot
sudo nvram boot-args="-v"
# disable screenshot shadows
defaults write com.apple.screencapture disable-shadow -bool true
# HiDPI modes
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# typing sanity
# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# disable accent on key hold
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# security
# require password immediately
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 0

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew analytics off

# apps
brew install zsh
brew install git
brew install python3
brew install openssh
brew install rbenv

# setup zsh
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
# remove stock configs
rm ~/.zshrc ~/.zpreztorc
# symlink
ln -s $ABSPATH/.zprestorc /Users/$USER/.zpreztorc
ln -s $ABSPATH/.zshrc /Users/$USER/.zshrc
ln -s $ABSPATH/.p10k.zsh /Users/$USER/.p10k.zsh
# set shell to new zsh
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh

# set global gitignore
git config --global core.excludesfile $ABSPATH/gitignore_global

# patch fonts (prefer a precompiled font; repo is ~1 GiB)
# SFMono: /System/Applications/Utilities/Terminal.app/Contents/Resources/Fonts
# git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git

# manual
# set hostname via System Preferences → Sharing
# install uBlock Origin on browsers
# enable night shift

# can brew cask install these
# iterm
# dropbox
# keepassxc
# chrome
# vlc
# spectacle
# spotify
# slack
# vscode
# tunnelblick
# rdesktop
