#!/usr/bin/env bash

export EDITOR="/usr/local/bin/mate -w"
export PYTHONPATH="/usr/local/lib/python3:$PYTHONPATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export RDBASE="/usr/local/share/RDKit"
export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"
# export SCHRODINGER='/opt/schrodinger/suites2015-2'

# customize bash prompt (http://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/)
export PS1="$(tput setaf 5)[\!] $(tput setaf 1)[\A] $(tput setaf 2)[\u@\h:$(tput setaf 3)\w$(tput setaf 2)]$(tput setaf 4)\n\$ $(tput sgr0)"
export PS2="> "

alias edit-bashrc='mate -w ~/.bashrc; source ~/.bashrc; cp ~/.bashrc ~/dev/dotfiles/.bashrc; echo "nailed it"'
alias edit-sshconfig='mate  ~/.ssh/config'
alias qq='exit'

if [ "$(uname)" = 'Linux' ] ; then
    alias ls='ls --color -F'
elif [ "$(uname)" = 'Darwin' ] ; then
    alias ls='ls -FG' #default color + directory flags
fi

alias la='ls -al'
alias ..="cd .."
alias ...="cd ../.."
alias cool="echo cool"
alias pyserver="cd ~/dev/$(whoami).github.io; python -m SimpleHTTPServer"
alias jn="cd ~/dev/notebooks; jupyter notebook"

alias showallfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideallfiles='defaults write com.apple.finder AppleShowAllFiles NO;  killall Finder /System/Library/CoreServices/Finder.app'

#TODO evaluate virtualenv
#export WORKON_HOME=~/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

function update-python {
	pip3 install -U setuptools pip
	pip3 freeze --local | grep -v '^\-e'  | cut -d = -f 1 | xargs -n1 pip3 install -U
}

function update-brew {
	brew update
	brew doctor
	brew upgrade --all
	brew cleanup --force
	brew prune
	brew cask update --all
	brew cask cleanup
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
