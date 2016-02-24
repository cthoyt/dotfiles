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
	cp ~/.bashrc ~/Dropbox/dev/dotfiles/.bashrc
	source ~/.bashrc
	echo "nailed it"
}
alias edit-sshconfig='mate  ~/.ssh/config'
alias qq='exit'

if [ "$(uname)" = 'Linux' ] ; then
    alias ls='ls --color -F'
elif [ "$(uname)" = 'Darwin' ] ; then
    alias ls='ls -FG' #default color + directory flags
fi

alias la='ls -alh'
alias ..="cd .."
alias ...="cd ../.."
alias cool="echo cool"
alias pyserver="cd ~/Dropbox/dev/$(whoami).github.io; python -m SimpleHTTPServer"
alias jn="jupyter notebook --notebook-dir ~/Dropbox/dev/notebooks"

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

#TODO evaluate virtualenv
#export WORKON_HOME=~/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

function update-python {
	echo "Checking setuptools and pip"
	pip3 install -U setuptools pip
	echo "Checking for outdated packages"
	pip3 list -o | cut -d " " -f 1 | xargs -n1 pip3 install -U
}

#TODO evaluate rbenv (https://github.com/rbenv/rbenv)

function update-ruby {
	gem update --system
	gem update 
	gem cleanup
}

function openapp {
	if [ -f "/Users/$(whoami)/Applications/$1" ] ; then
		open -a "/Users/$(whoami)/Applications/$1"
	elif [ -f "/Applications/$1" ] ; then
		open -a "/Applications/$1"
	else
		echo "not found"
	fi
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
