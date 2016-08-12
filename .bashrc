#!/usr/bin/env bash

export EDITOR="/usr/local/bin/mate -w"
export PYTHONPATH="/usr/local/lib/python3:$PYTHONPATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export RDBASE="/usr/local/share/RDKit"
export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"

# customize bash prompt (http://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/)
export PS1="$(tput setaf 5)[\!] $(tput setaf 1)[\A] $(tput setaf 2)[\u@\h:$(tput setaf 3)\w$(tput setaf 2)]$(tput setaf 4)\n\$ $(tput sgr0)"
export PS2="> "

export dotfiles=~/Dropbox/dev/dotfiles

function edit-bashrc {
	mate -w ~/.bashrc
	cp ~/.bashrc $dotfiles/.bashrc
	source ~/.bashrc
	echo "nailed it"
}

function edit-rrc {
	mate -w ~/.Rprofile
	cp ~/.Rprofile $dotfiles/.bashrc
	echo nailed it
}

function save-rcs {
	for i in .bashrc .Rprofile; do
		echo "cp ~/$i $dotfiles/$i"
		cp ~/$i $dotfiles/$i
	done
}

function r-install {
	echo "install.packages('$1')" >> ~/Dropbox/dev/dotfiles/install_packages.R
	r -e "install.packages('$1')"
}

function export-r-packages {
	r -e "write.table(installed.packages(priority='NA'), '$dotfiles/r_packages.csv', sep=',')"
}

function jnbc {
	jupyter nbconvert "$1" --to pdf --template no_code.tplx --output-dir=~/Downloads
}

alias edit-sshconfig='mate ~/.ssh/config'
alias qq='exit'
alias makef='time make -f'
alias cd-jupyter-templates='cd /usr/local/lib/python3.5/site-packages/nbconvert/templates/latex'

function makea {
	# make all make files in a directory
	for i in *.makefile; do
		echo "$(tput setaf 5)make$(tput sgr0) -f $i"
		make -f $i
		echo
	done
}

if [ "$(uname)" = 'Linux' ] ; then
    alias ls='ls --color -F'
	alias la='ls -alh --color'
elif [ "$(uname)" = 'Darwin' ] ; then
    alias ls='ls -FG' #default color + directory flags
	alias la='ls -alh'
elif [[ "$(uname)" == "CYGWIN"* ]] ; then
	alias ls='ls -F --color'
	alias la='ls -alh --color'
fi

alias ..="cd .."
alias ...="cd ../.."
alias cool="echo cool"
alias pyserver="cd ~/Dropbox/dev/$(whoami).github.io; python -m SimpleHTTPServer"
alias tree="tree -C"

alias jn="jupyter notebook --notebook-dir ~/Dropbox/dev/notebooks"
alias jnd="jupyter notebook --notebook-dir ~/dev"

alias showallfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideallfiles='defaults write com.apple.finder AppleShowAllFiles NO;  killall Finder /System/Library/CoreServices/Finder.app'

function update-brew {
	brew update
	brew doctor
	brew upgrade --all
	brew cleanup --force
	brew prune
	brew cask update --all
	brew cask cleanup
}

# TODO evaluate virtualenv
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

function update-python {
	echo "Checking setuptools and pip"
	pip3 install -U setuptools pip wheel
	echo "Checking for outdated packages"
	pip3 list -o | cut -d " " -f 1 | xargs -n 1 pip3 install -U
}

function update-python2 {
	echo "Checking setuptools and pip"
	pip2 install -U setuptools pip wheel
	echo "Checking for outdated packages"
	pip2 list -o | cut -d " " -f 1 | xargs -n 1 pip2 install -U
}

# TODO evaluate rbenv (https://github.com/rbenv/rbenv)

function update-ruby {
	gem update --system
	gem update 
	gem cleanup
}

function update-all {
	echo "$(tput setaf 5)Updating Brew$(tput sgr0)"	
	update-brew
	echo
	echo "$(tput setaf 5)Updating Python 3$(tput sgr0)"
	update-python
	echo
	echo "$(tput setaf 5)Updating Ruby$(tput sgr0)"
	update-ruby
}

function openapp {
	if [ -e "/Users/$(whoami)/Applications/$1.app" ] ; then
		open -a "/Users/$(whoami)/Applications/$1.app"
	elif [ -e "/Applications/$1.app" ] ; then
		open -a "/Applications/$1.app"
	else
		echo "not found"
	fi
}

function gettodos {
	cat $1 | egrep "\[(t|todo|t:)\]"
}

function reinstall-irkernel {
	r -e "install.packages(c('repr', 'pbdZMQ', 'devtools'), repos='http://cran.us.r-project.org')"
	r -e "devtools::install_github('IRkernel/IRdisplay')"
	r -e "devtools::install_github('IRkernel/IRkernel')"
	r -e "IRkernel::installspec()"
}

# startables and stoppables

# postgres (currently running automatically in background)
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost

alias start-postgres='pg_ctl -l $PGDATA/server.log start'
alias stop-postgres='pg_ctl stop -m fast'
alias show-postgres-status='pg_ctl status'
alias restart-postgres='pg_ctl reload'

# mysql (http://stackoverflow.com/questions/11091414/how-to-stop-mysqld)
alias start-mysql="mysql.server start"
alias stop-mysql="mysqladmin -u root shutdown"

# neo4j
alias start-neo4j="neo4j start"
alias stop-neo4j="neo4j stop"

# find
alias find-stoppables="ps aux | egrep 'sql|neo4j' --color"
