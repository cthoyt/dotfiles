#!/usr/bin/env bash

# Credits and Ideas
# * see http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/
# * see https://gist.github.com/ChristopherA/d48946c72d75c4330374
# * see https://github.com/mathiasbynens/dotfiles

cd ~

curl -O https://raw.githubusercontent.com/cthoyt/dotfiles/master/.bashrc
curl -O https://raw.githubusercontent.com/cthoyt/dotfiles/master/.bash_profile

resource .bash_profile

# xcode command line tools
xcode-select --install

# brew and brew-cask (http://brew.sh/ and https://github.com/caskroom/homebrew-cask)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask
brew install gcc # dependency for numpy and scipy 

brew doctor
brew update

# mate
brew cask install textmate

# git 
brew install git
brew cask install github-desktop
curl -O https://raw.githubusercontent.com/cthoyt/dotfiles/master/.gitconfig
git config --global user.name "Charlie Hoyt"
git config --global user.email "cthoyt@gmail.com"
git config --global core.excludesfile "~/.gitignore"
git config --global core.excludesfile "~/.ipynb_checkpoints"
git config --global core.editor "mate -wl1"

# R
brew cask install xquartz # dependency for r
brew tap homebrew/science
brew install R
brew cask install rstudio

# postgres
brew cask install postgres
brew install postgres
brew cask install pgadmin3

# python
brew install python3

## virtualenv (http://docs.python-guide.org/en/latest/dev/virtualenvs/)
### TODO: reinvestigate using virtualenv. necessary?
### pip install virtualenv virtualenvwrapper
### export WORKON_HOME=~/.virtualenvs
### source /usr/local/bin/virtualenvwrapper.sh
### mkvirtualenv venv
### workon venv

## scientific python stack
pip3 install numpy
pip3 install pandas
pip3 install scipy
brew install freetype # dependency for matplotlib 
pip3 install matplotlib
brew install zeromq # dependency for jupyter
pip3 install jupyter

## jupyter bash kernel
pip3 install bash_kernel
python3 -m bash_kernel.install

## jupyter r kernel
R -e "install.packages(c('rzmq','repr','IRkernel','IRdisplay'),repos = c('http://irkernel.github.io/', 'http://cran.us.r-project.org'))
IRkernel::installspec()"
R -e "IRkernel::installspec()"

# GUI Applications
brew cask install appcleaner
brew cask install caffeine
brew cask install dropbox
brew cask install evernote
brew cask install filezilla
brew cask install flux
brew cask install google-chrome
brew cask install google-drive
brew cask install google-photos-backup
brew cask install istat-menu
brew cask install lastpass
brew cask install perian
brew cask install shuttle
brew cask install skype
brew cask install transmission
brew cask install vlc
brew cask install vox
brew cask install vox-preference-pane
brew cask install zotero

# java
brew cask install java
brew cask install eclipse-java

# cleanup
brew update
brew cask update
brew cleanup
brew cask cleanup

# Random

## change default screenshot location
defaults write com.apple.screencapture location ~/Pictures/; killall SystemUIServer

### TODO: set cronjob to brew update and brew cask update
### * 13 * * * brew 

# Extra
#brew install pymol
#pip3 install ipymol
#pip3 install biopython

# rdkit
#brew tap rdkit/rdkit
#brew install rdkit
