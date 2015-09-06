#!/usr/bin/env bash

# Credits and Ideas
### see http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/
### see https://gist.github.com/ChristopherA/d48946c72d75c4330374

cd ~

# xcode command line tools
xcode-select --install

# brew and brew-cask (http://brew.sh/ and https://github.com/caskroom/homebrew-cask)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

brew doctor
brew update

# git 
brew install git
brew cask install github-desktop

# R
brew cask install xquartz # R uses XQuartz as a dependency
brew tap homebrew/science
brew install R
brew cask install rstudio
brew cask install r-gui

# PostgreSQL
### TODO: add more setup
brew install postgres
brew cask install postgres

# Python
brew install python3

## virtualenv (http://docs.python-guide.org/en/latest/dev/virtualenvs/)
### pip install virtualenv virtualenvwrapper
### export WORKON_HOME=~/.virtualenvs
### source /usr/local/bin/virtualenvwrapper.sh
### mkvirtualenv venv
### workon venv

## scientific python stack
pip3 install numpy
pip3 install pandas
pip3 install scipy
brew install freetype #used for matplotlib
pip3 install matplotlib
brew install zeromq #used for jupyter
pip3 install jupyter

## jupyter bash kernel
pip3 install bash_kernel
python3 -m bash_kernel.install

## jupyter r kernel
brew install zeromq
R -e "install.packages(c('rzmq','repr','IRkernel','IRdisplay'),repos = c('http://irkernel.github.io/', 'http://cran.us.r-project.org'))
IRkernel::installspec()"
R -e "IRkernel::installspec()"

# rdkit
brew tap rdkit/rdkit
brew install rdkit

# GUI Applications
brew cask install cyberduck
brew cask install caffeine
brew cask install dropbox
brew cask install evernote
brew cask install flux
brew cask install google-chrome
brew cask install google-drive
brew cask install google-photos-backup
brew cask install lastpass
brew cask install shuttle
brew cask install skype
brew cask install transmission
brew cask install textmate
brew cask install vlc
brew cask install vox
brew cask install zotero

# java
brew cask install java
brew cask install eclipse-java

# cleanup
brew update
brew cask update

brew cleanup
brew cask cleanup

# change default screenshot location
defaults write com.apple.screencapture location ~/Pictures/
killall SystemUIServer