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

function edit-bashrc {
	mate -w ~/.bashrc
	cp ~/.bashrc $DOTFILES/
	source ~/.bashrc
	echo "nailed it"
}

function edit-rrc {
	mate -w ~/.Rprofile
	cp ~/.Rprofile $DOTFILES/
	echo nailed it
}

function save-rcs {
	for i in ~/.bashrc ~/.Rprofile ~/.bash_profile; do
		echo "cp $i $DOTFILES/"
		cp $i $DOTFILES/
	done
	
	cp ~/.jupyter/jupyter_notebook_config.py $DOTFILES/jupyter/
	cp -r /usr/local/lib/python3.5/site-packages/nbconvert/templates/latex/custom/ $DOTFILES/latex_templates/
}

function notify {
	res=$?
	if [ "$res" = "0" ]; then
		echo "$(tput 2)Notifying IFTTT$(tput sgr0)"
	else
		echo "Notifying IFTTT"
	fi
	curl -X POST -H "Content-Type: application/json" -d "{\"value1\":\"$*\",\"value2\":\"$res\"}" "https://maker.ifttt.com/trigger/script_done/with/key/$IFTTT_KEY" > /dev/null 2>&1
}

function notify-xargs {	
	name=$1
	shift
	echo "$@" | sh
	res=$?
	curl -X POST -H "Content-Type: application/json" -d "{\"value1\":\"$name\",\"value2\":\"$res\"}" "https://maker.ifttt.com/trigger/script_done/with/key/$IFTTT_KEY" > /dev/null 2>&1
}

function r-install {
	echo "$1" >> $DOTFILES/r_packages.txt
	r -e "install.packages('$1')"
}

function bioconductor-install {
	echo "$1" >> $DOTFILES/bioconductor_packages.txt
	r -e "source('https://bioconductor.org/biocLite.R')"
	r -e "biocLite('$1')"
}

function jnbc {
	jupyter nbconvert "$1" --to pdf --template no_code.tplx --output-dir=~/Downloads
}

alias edit-sshconfig='mate ~/.ssh/config'
alias qq='exit'
alias cd-jupyter-templates='cd /usr/local/lib/python3.5/site-packages/nbconvert/templates/latex'
alias resource="source ~/.bash_profile"
alias reboot-router='ruby $DOTFILES/reboot_router.rb'

function makef {
	time make -f "$*"
	notify "make done"
}

function makea {
	# make all make files in a directory
	for i in *.makefile; do
		echo "$(tput setaf 5)make$(tput sgr0) -f $i"
		make -f $i
		notify "done making $i"
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
alias pyserver="cd $WEBSITE; python -m SimpleHTTPServer"
alias tree="tree -C"

alias jnn="jupyter notebook --notebook-dir $NOTEBOOKS"
alias jnd="jupyter notebook --notebook-dir $DEV"

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
	echo "Checking setuptools, pip, and wheel"
	pip3 install -U setuptools pip wheel
	echo "Checking for outdated packages"
	pip3 list -o | cut -d " " -f 1 | xargs -n 1 pip3 install -U
}

function update-python2 {
	echo "Checking setuptools, pip, and wheel"
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
