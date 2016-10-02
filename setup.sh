#!/usr/bin/env bash

# Credits and Ideas
# * see http://www.lowindata.com/2013/installing-scientific-python-on-mac-os-x/
# * see https://gist.github.com/ChristopherA/d48946c72d75c4330374
# * see https://github.com/mathiasbynens/dotfiles


GITHUB_FILES="https://raw.githubusercontent.com"
CTH_GITHUB="$GITHUB_FILES/cthoyt/dotfiles/master"

cd ~

# dot files
curl -0L "$CTH_GITHUB/.bashrc" > ~/.bashrc
curl -0L "$CTH_GITHUB/.bash_profile" > ~/.bash_profile

source ~/.bash_profile

# brew (http://brew.sh/)
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew cleanup && brew doctor

# brew taps
brew tap caskroom/cask
brew tap homebrew/science
brew tap rdkit/rdkit

# git 
brew install git
curl -0L "$CTH_GITHUB/.gitconfig" > ~/.gitconfig
curl -0L "$CTH_GITHUB/.gitignore_global" > ~/.gitignore_global
git config --global core.excludesfile '~/.gitignore_global' # http://stackoverflow.com/questions/7335420/global-git-ignore
git config --global core.editor "mate -wl1"
git config --global user.name "Charles Tapley Hoyt"
git config --global user.email "cthoyt@gmail.com"
brew cask install github-desktop

brew install ssh-copy-id

brew install gcc
brew install tree

# brew-cask (https://github.com/caskroom/homebrew-cask)
brew install brew-cask 

# GUI Applications

brew cask install appcleaner caffeine dropbox evernote filezilla flux  
brew cask install google-photos-backup music-manager google-chrome google-drive
brew cask install istat-menu perian shuttle skype transmission vlc vox 
brew cask install vox-preference-pane mendeley-desktop
brew cask install textmate slack owncloud

# Quicklook Plugins

brew cask install jupyter-notebook-ql qlstephen quicklook-csv quicklook-json

# bash (http://johndjameson.com/blog/updating-your-shell-with-homebrew/)
brew install bash
sudo -s
echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash

# r
brew cask install xquartz # xquartz: r dependency
brew install R

# postgres 
# https://www.codefellows.org/blog/three-battle-tested-ways-to-install-postgresql#macosx
# http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/
# upgrading: https://kkob.us/2016/01/09/homebrew-and-postgresql-9-5/
brew install postgres
initdb /usr/local/var/postgres

# automatically start database on system start
mkdir -p ~/Library/LaunchAgents
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

createdb $(whoami)
brew cask install pgadmin3
psql postgres -c 'CREATE EXTENSION "adminpack";'

# python
brew install python3

# virtual environment (http://docs.python-guide.org/en/latest/dev/virtualenvs/)
pip3 install virtualenv virtualenvwrapper
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
# mkvirtualenv "$(whoami)_env"
# workon "$(whoami)_env"

## scientific python stack
brew install freetype # freetype: matplotlib dependency 
brew install zeromq # zeromq: jupyter dependency
pip3 install psycopg2 numpy pandas scipy matplotlib jupyter

## jupyter bash kernel (https://github.com/takluyver/bash_kernel)
pip3 install bash_kernel
python3 -m bash_kernel.install

## jupyter r kernel (http://irkernel.github.io/)
# see .bashrc for implementation. This needs to be run each time R is updated...
reinstall-irkernel

brew install inkscape # for jupyter notebook irkernel to latex 

# enable widgets (https://github.com/ipython/ipywidgets)
jupyter nbextension enable --py widgetsnbextension

# Science Extras
# brew install pymol
# pip3 install ipymol 
# pip3 install bioconductor

# RDKit (http://www.rdkit.org/docs/Install.html)
brew install rdkit --with-postgresql --with-python3
psql postgres -c 'CREATE EXTENSION "rdkit"'

# java
brew cask install java
brew cask install eclipse-java

# TeX
brew cask install mactex
brew install pandoc

# ruby
brew install ruby
gem install sequel
gem install mechanize

# iruby notebook (https://github.com/SciRuby/iruby#mac)
brew install libtool autoconf automake autogen
gem install rbczmq
gem install iruby

# node.js (maybe one day) (http://shapeshed.com/setting-up-nodejs-and-npm-on-mac-osx/)
# brew install node

# MonetDB (https://www.monetdb.org/Documentation/UserGuide/Tutorial)
# brew install monetdb --with-java --with-ruby

# Neo4J
brew install neo4j

# MySQL
brew install mysql
mysql_install_db --verbose --user="$(whoami)" --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

update-brew

# cron
#curl -0L "$CTH_GITHUB/.cron"
#crontab ~/.cron

unset GITHUB_FILES
unset CTH_GITHUB
