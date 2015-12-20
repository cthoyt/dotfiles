#!/usr/bin/env bash

# Credits and Ideas
# * see http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/
# * see https://gist.github.com/ChristopherA/d48946c72d75c4330374
# * see https://github.com/mathiasbynens/dotfiles

cd ~

# dot files
curl -0 https://raw.github.com/cthoyt/dotfiles/master/.bashrc
curl -0 https://raw.github.com/cthoyt/dotfiles/master/.bash_profile

source .bash_profile

# xcode command line tools
xcode-select --install

# brew http://brew.sh/
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew cleanup && brew doctor

brew install gcc

# brew taps
brew tap caskroom/cask
brew tap homebrew/science
brew tap rdkit/rdkit

# brew-cask  https://github.com/caskroom/homebrew-cask
brew install brew-cask 

# GUI Applications
brew cask install appcleaner caffeine dropbox evernote filezilla flux google-chrome google-drive google-photos-backup istat-menu perian shuttle skype transmission vlc vox vox-preference-pane zotero

# bash
# credit: http://johndjameson.com/blog/updating-your-shell-with-homebrew/
brew install bash
sudo -s
echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash

# mate
brew cask install textmate
### TODO link mate and fix export in .bash_profile
### ln -s /Applications/TextMate.app/Contents/Resources/mate ~/bin/mate

# git 
brew install git
curl -0 https://raw.github.com/cthoyt/dotfiles/master/.gitconfig # TODO is this the right thing to do?
curl -0 https://raw.github.com/cthoyt/dotfiles/master/.gitignore
brew cask install github-desktop
git config --global user.name "Charles Tapley Hoyt"
git config --global user.email "cthoyt@gmail.com"
git config --global core.editor "mate -wl1"

# r
brew cask install xquartz # xquartz: r dependency
brew install R
brew cask install rstudio

# postgres (https://www.codefellows.org/blog/three-battle-tested-ways-to-install-postgresql#macosx, http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/)
brew install postgres
initdb /usr/local/var/postgres # NECESSARY?
mkdir -p ~/Library/LaunchAgents
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
createdb $(whoami)
brew cask install pgadmin3
psql postgres -c 'CREATE EXTENSION "adminpack";'

# python
brew install python3

# Virtual Environment (http://docs.python-guide.org/en/latest/dev/virtualenvs/)
# pip3 install virtualenv virtualenvwrapper
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
# mkvirtualenv "$(whoami)_env"
# workon "$(whoami)_env"

## scientific python stack
brew install freetype # freetype: matplotlib dependency 
brew install zeromq # zeromq: jupyter dependency
pip3 install psycopg2 numpy pandas scipy matplotlib jupyter bash_kernel

## jupyter bash kernel
python3 -m bash_kernel.install

## jupyter r kernel
R -e "install.packages(c('rzmq','repr','IRkernel','IRdisplay'),repos = c('http://irkernel.github.io/', 'http://cran.us.r-project.org'))
IRkernel::installspec()"
R -e "IRkernel::installspec()"

# Science Extras
brew install pymol
pip3 install ipymol bioconductor
brew install rdkit

# java
brew cask install java
brew cask install eclipse-java

# ruby
brew install ruby

brew doctor && brew update && brew cleanup && brew cask update && brew cask cleanup

# cron
curl -L https://raw.github.com/cthoyt/dotfiles/master/.cron >> ~/.cron
crontab ~/.cron
