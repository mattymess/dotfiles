# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1


##############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home/
mkdir -p ~/migration/Library/"Application Support"/
mkdir -p ~/migration/Library/Preferences/
mkdir -p ~/migration/Library/Application Support/
mkdir -p ~/migration/rootLibrary/Preferences/SystemConfiguration/

cd ~/migration

# what is worth reinstalling?
brew leaves                > brew-list.txt    # all top-level brew installs
brew list --cask           > cask-list.txt
npm list -g --depth=0      > npm-g-list.txt
yarn global list --depth=0 > yarn-g-list.txt

# then compare brew-list to what's in `brew.sh`
#   comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

# backup some dotfiles likely not under source control
cp -Rp \
    ~/.bash_history \
    ~/.extra ~/.extra.fish \
    ~/.gitconfig.local \
    ~/.gnupg \
    ~/.hyper.js   \
    ~/.hyper-plugins   \
    ~/.nano \
    ~/.nanorc \
    ~/.netrc \
    ~/.p10k.zsh  \
    ~/.ssh \
    ~/.z   \
        ~/migration/home

cp -Rp ~/Documents ~/migration

cp -Rp /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/migration/rootLibrary/Preferences/SystemConfiguration/ # wifi

# cp -Rp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration/Library/Preferences/

cp -Rp ~/Library/Services ~/migration/Library/ # automator stuff
cp -Rp ~/Library/Fonts ~/migration/Library/ # all those fonts you've installed

# editor settings & plugins

cp -Rp ~/Library/Application\ Support/Code\ -\ Insider* ~/migration/Library/"Application Support"

# also consider...
# random git branches you never pushed anywhere?
# git untracked files (or local gitignored stuff). stuff you never added, but probably want..


# OneTab history pages, because chrome tabs are valuable.

# usage logs you've been keeping.

# iTerm settings.
  # Prefs, General, Use settings from Folder

# Finder settings and TotalFinder settings
#   Not sure how to do this yet. Really want to.

# Timestats chrome extension stats
#   chrome-extension://ejifodhjoeeenihgfpjijjmpomaphmah/options.html#_options
# 	gotta export into JSON through devtools:
#     copy(JSON.stringify(localStorage))
#     pbpaste > timestats-canary.json.txt

# software licenses.
#   sublimetext's is in its Application Support folder

# maybe ~/Pictures and such
cp -Rp ~/Pictures ~/migration

### end of old machine backup
##############################################################################################################



##############################################################################################################
### XCode Command Line Tools
#      thx https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi
###
##############################################################################################################

##############################################################################################################
### pip
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH

##############################################################################################################
### oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### zsh-syntax-highlighting plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

### zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

##############################################################################################################
### nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install node

##############################################################################################################
### homebrew!

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install all the things
./brew.sh
./brew-cask.sh

### end of homebrew
##############################################################################################################




##############################################################################################################
### install of common things
###

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)


# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli

# install better nanorc config
# https://github.com/scopatz/nanorc
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

# github.com/rupa/z   - oh how i love you
git clone https://github.com/rupa/z.git ~/code/z
# consider reusing your current .z file if possible. it's painful to rebuild :)
# z is hooked up in .bash_profile

# my magic photobooth symlink -> dropbox. I love it.
# 	 + first move Photo Booth folder out of Pictures
# 	 + then start Photo Booth. It'll ask where to put the library.
# 	 + put it in Dropbox/public
# 	* Now… you can record photobooth videos quickly and they upload to dropbox DURING RECORDING
# 	* then you grab public URL and send off your video message in a heartbeat.


# for the c alias (syntax highlighted cat)
sudo easy_install Pygments

# change to bash 4 (installed by homebrew)
BASHPATH=$(brew --prefix)/bin/bash
#sudo echo $BASHPATH >> /etc/shells
sudo bash -c 'echo $(brew --prefix)/bin/bash >> /etc/shells'
chsh -s $BASHPATH # will set for current user only.
echo $BASH_VERSION # should be 4.x not the old 3.2.X
# Later, confirm iterm settings aren't conflicting.


# iterm with more margin! http://hackr.it/articles/prettier-gutter-in-iterm-2/
#   (admittedly not as easy to maintain)


# setting up the sublime symlink
# ln -sf "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl


###
##############################################################################################################

# also this unrelated thing
git config user.email "messinger.matt@gmail.com"


##############################################################################################################
### remaining configuration
###

# go read mathias, paulmillr, gf3, alraa's dotfiles to see what's worth stealing.

# prezto and antigen communties also have great stuff
#   github.com/sorin-ionescu/prezto/blob/master/modules/utility/init.zsh

# set up osx defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
sh .osx

# setup and run Rescuetime!

###
##############################################################################################################


# Tell system when Xcode utilities live:
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

# Set "opendiff" as the default mergetool globally:
git config --global merge.tool opendiff


##############################################################################################################
### symlinks to link dotfiles into ~/
###

#   move git credentials into ~/.gitconfig.local    	http://stackoverflow.com/a/13615531/89484
#   now .gitconfig can be shared across all machines and only the .local changes

# symlink it up!
./symlink-setup.sh

# if getting bash errors
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash

# add manual symlink for .ssh/config and probably .config/fish

###
##############################################################################################################
