#!/bin/bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade


# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`, overwriting the built-in `sed`
brew install gnu-sed --with-default-names


# Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash

brew install bash-completion

brew install homebrew/completions/brew-cask-completion

# Install wget with IRI support
# brew install wget --with-iri

# Install more recent versions of some OS X tools
brew install vim 
brew install nano
brew install grep

# z hopping around folders
brew install z

# run this script when this file changes guy.
# brew install entr

# github util. gotta love `hub fork`, `hub create`, `hub checkout <PRurl>`
brew install gh
brew install hub
brew install git-delta

# mtr - ping & traceroute. best.
# brew install mtr

    # allow mtr to run without sudo
    # mtrlocation=$(brew info mtr | grep Cellar | sed -e 's/ (.*//') #  e.g. `/Users/matt/.homebrew/Cellar/mtr/0.86`
    # sudo chmod 4755 $mtrlocation/sbin/mtr
    # sudo chown root $mtrlocation/sbin/mtr


# Install other useful binaries
# brew install the_silver_searcher
# brew install fzf
brew install yarn
brew install git
brew install imagemagick
# brew install node # Installed with nvm in setup-a-new-machine
# brew install pv
# brew install rename
# brew install tree
# brew install zopfli
# brew install ffmpeg --with-libvpx
# brew install antigen

# brew install terminal-notifier

# brew install android-platform-tools
# brew install pidcat   # colored logcat guy

# brew install ncdu # find where your diskspace went

# Remove outdated versions from the cellar
brew cleanup
