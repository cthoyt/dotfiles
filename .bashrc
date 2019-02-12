#!/usr/bin/env bash

# Preparing path and pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:~/.local/bin:$PATH

# Locale options
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Customize bash prompt (http://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/)
export PS1="\[$(tput setaf 5)\][\!]\[$(tput setaf 1)\] [\A]\[$(tput setaf 2)\] [\u@\h:\[$(tput setaf 3)\]\w\[$(tput setaf 2)\]]\[$(tput setaf 4)\]\n\$ \[$(tput sgr0)\]"
export PS2="> "

# Misc options
export EDITOR="/usr/local/bin/mate -w"
export PYTHONPATH="/usr/local/lib/python3:$PYTHONPATH"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Locations
export RDBASE=/usr/local/share/RDKit
export DEV=~/dev
export DOTFILES=~/dev/dotfiles
export NOTEBOOKS=~/notebooks
export WEBSITE=~/dev/cthoyt.github.io

# Set up secret environment variables
[ -f ~/.bash_secrets ] && source ~/.bash_secrets

# Set up Java
if [ -f /usr/libexec/java_home ]; then
	export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"
	export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF8"
	export CLASSPATH="/Users/cthoyt/dev/jars/reach-82631d-biores-e9ee36.jar:$CLASSPATH"
fi

# Get virtualenv ready
export VIRTUALENVWRAPPER_PYTHON="$(which python3)"
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# Get pyenv ready
if command -v pyenv 1>/dev/null 2>&1; then
	 eval "$(pyenv init -)"
fi

# Get rbenv ready
[ -x "$(command -v rbenv)" ] && eval "$(rbenv init -)"

# Get RVM ready
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# Set up colorful ls
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

###########
# ALIASES #
###########

alias edit-sshconfig='$EDITOR ~/.ssh/config'
alias qq='exit'
alias cd-jupyter-templates='cd /usr/local/lib/python3.5/site-packages/nbconvert/templates/latex'
alias resource="source ~/.bash_profile"
alias reboot-router='ruby $DOTFILES/reboot_router.rb'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cool="echo cool"
alias pyserver="cd $WEBSITE; python -m SimpleHTTPServer"
alias tree="tree -C"

alias jnn="python3 -m jupyter notebook --notebook-dir $NOTEBOOKS"
alias jnd="python3 -m jupyter notebook --notebook-dir $DEV"

alias showallfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideallfiles='defaults write com.apple.finder AppleShowAllFiles NO;  killall Finder /System/Library/CoreServices/Finder.app'

alias pybelweb="python3 -m pybel_tools web"

##################
# MISC FUNCTIONS #
##################

function pbc {
	pybel compile *.bel
}

function pybeltestwipe {
	mysql -u root -e "drop database if exists pybeltest;CREATE DATABASE pybeltest DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
}

# Gets the branch at the argument's path
function gb {
	x=$(pwd)
	cd ~/dev/$1
	echo $(git symbolic-ref HEAD --short)
	cd $x
	unset x
}

# Reads the symlink of a program
# Example: rsl python3 outputs
function rsl {
	greadlink -f $(which $1)
}

function whichdo {
	$1 $(which $2)
}

# Outputs the first couple lines of a given wrapper. Useful for checking out python commands
# Example: which tox
function hw {
	head $(which $1)
}


function jnbc {
	jupyter nbconvert "$1" --to pdf --template custom/no_code.tplx --output-dir=~/Downloads
}

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

##########################
# NOTIFICATION FUNCTIONS #
##########################

function notify {
	res=$?
	if [ "$res" = "0" ]; then
		echo "$(tput setaf 2)Notifying IFTTT$(tput sgr0)"
	else
		echo "$(tput setaf 1)Notifying IFTTT$(tput sgr0)"
	fi
	curl -X POST -H "Content-Type: application/json" -d "{\"value1\":\"$*\",\"value2\":\"$res\"}" "https://maker.ifttt.com/trigger/script_done/with/key/$IFTTT_KEY" > /dev/null 2>&1
}

function notify_xargs {	
	name=$1
	shift
	echo "$@" | sh
	res=$?
	curl -X POST -H "Content-Type: application/json" -d "{\"value1\":\"$name\",\"value2\":\"$res\"}" "https://maker.ifttt.com/trigger/script_done/with/key/$IFTTT_KEY" > /dev/null 2>&1
}

###########################
# CONFIGURATION FUNCTIONS #
###########################

# Edit .bashrc
function ebrc {
	$EDITOR ~/.bashrc
	cp ~/.bashrc $DOTFILES/
	source ~/.bashrc
	echo "nailed it"
}

# Edit .Rprofile
function errc {
	$EDITOR ~/.Rprofile
	cp ~/.Rprofile $DOTFILES/
	echo "nailed it"
}


# Editing
# http://matplotlib.org/users/customizing.html#customizing-with-matplotlibrc-files
function save_rcs {
	for i in ~/.profile ~/.bashrc ~/.Rprofile ~/.bash_profile ~/.gemrc ~/.gitignore_global ~/.gitconfig; do
		cp $i $DOTFILES/
	done
	
	cp ~/.matplotlib/matplotlibrc $DOTFILES/matplotlibrc
	
	cp -r ~/.jupyter/ $DOTFILES/jupyter/
	cp -r ~/.ipython/ $DOTFILES/ipython/
	cp -r /usr/local/lib/python3.6/site-packages/nbconvert/templates/latex/custom/ $DOTFILES/latex_templates/
}

# The repopulate function should do the opposite of save-rcs
function repopulate_rcs {
	for i in .profile .bashrc .Rprofile .bash_profile .gemrc .gitignore_global .gitconfig; do
		cp $DOTFILES/$i ~/
	done
	
	cp $DOTFILES/matplotlibrc ~/.matplotlib/matplotlibrc
	
	cp -r $DOTFILES/jupyter/ ~/.jupyter/
	cp -r $DOTFILES/ipython/  ~/.ipython/
	cp -r $DOTFILES/latex_templates/ /usr/local/lib/python3.6/site-packages/nbconvert/templates/latex/custom/ 
}


#####################
# INSTALL FUNCTIONS #
#####################

# Reinstalls the R kernel for Jupyter notebook
function reinstall_irkernel {
	r -e "install.packages(c('repr', 'pbdZMQ', 'devtools'), repos='http://cran.us.r-project.org')"
	r -e "devtools::install_github('IRkernel/IRdisplay')"
	r -e "devtools::install_github('IRkernel/IRkernel')"
	r -e "IRkernel::installspec()"
}

function r_install {
	echo "$1" >> $DOTFILES/r_packages.txt
	r -e "install.packages('$1')"
}

function bioconductor_install {
	echo "$1" >> $DOTFILES/bioconductor_packages.txt
	r -e "source('https://bioconductor.org/biocLite.R')"
	r -e "biocLite('$1')"
}

function install_pipsi {
	curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python3
	pipsi install pipsi
}

####################
# UPDATE FUNCTIONS #
####################

function update_brew {
	brew update
	brew doctor
	brew upgrade
	brew cleanup
}

function update_python3 {
	echo "Checking setuptools, pip, and wheel"
	python3 -m pip install --upgrade setuptools pip wheel
	echo "Checking for outdated packages"
	python3 -m pip list -o --format=columns | cut -d " " -f 1 | tail -n +3 | xargs -n 1 python3 -m pip install -U	
}

function update_ruby {
	head -n 1 $(which gem)
	gem update --system
	gem update 
	gem cleanup
}

alias git_pull_all="find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;"

function update_repos {
	echo "updating repos"
	d=$(pwd)
	cd $DEV
	
	for sd in $(ls); do
		if [ -d "$sd" ]; then
			cd $sd
			if [ -d "$sd/.git" ]; then
				echo "pulling $sd"
				git pull
			fi
		fi
		cd $DEV
	done
	
	cd $d
	unset d
}

function update_all {
	echo "$(tput setaf 5)Updating Brew$(tput sgr0)"	
	update_brew
	echo
	echo "$(tput setaf 5)Updating python3 packages$(tput sgr0)"
	update_python3
	echo
	echo "$(tput setaf 5)Updating python2 packages$(tput sgr0)"
	update_python
	echo
	echo "$(tput setaf 5)Updating ruby$(tput sgr0)"
	[ -x "$(command -v rbenv)" ] && update_ruby
	echo
	echo "$(tput setaf 5)Pulling git repos$(tput sgr0)"
	update_repos
}

#####################
# CLEANUP FUNCTIONS #
#####################

function cleanse_python3 {
	echo "Deleting all Python 3 packages"
	python3 -m pip list --format=columns | cut -d " " -f 1 | tail -n +3 | grep "^pip\|setuptools\|wheel\|distribute\|certifi\|pipenv$" -v | xargs -n 1 python3 -m pip uninstall -y	
	python3 -m pip install --upgrade pip pipenv
}

function cleanse_venvs {
	echo "Deleting all virtual environments"
	python3 -m pip install --upgrade virtualenv virtualenvwrapper
	rmvirtualenv $(lsvirtualenv -b)
}

function cleanse_python2 {
	echo "Deleting all Python 2 packages"
	python2 -m pip list --format=columns | cut -d " " -f 1 | tail -n +3 | grep "^pip\|setuptools\|wheel\|distribute$" -v | xargs -n 1 python2 -m pip uninstall -y	
}


function cleanse_pipsi {
	# pipsi lists in a strange way, so it needs to be parsed. Also, don't uninstall pipsi!
	pipsi list | grep "^\s\sPackage" | cut -d "\"" -f 2 | grep "^pipsi$" -v | xargs -n 1 pipsi uninstall --yes	
}

function uninstall_pipsi {
	cleanse_pipsi
	pipsi uninstall pipsi --yes
}

function cleanse_docker {
	docker stop $(docker ps -aq)
	docker_rm_containers
	docker_rm_volumes
	docker rmi $(docker images -q)
}

function docker_rm_containers {
	docker rm $(docker ps -aq)
}

function docker_rm_volumes {
	docker volume rm $(docker volume ls -q)
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

function grepall {
	grep -I -rn $1 . --color=auto
}
#############################
# STARTABLES AND STOPPABLES #
#############################

# postgres (currently running automatically in background)
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost

# alias start-postgres='pg_ctl -l $PGDATA/server.log start'
alias start-postgres='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias stop-postgres='pg_ctl stop -m fast'
alias show-postgres-status='pg_ctl status'
alias restart-postgres='pg_ctl reload'

# mysql (http://stackoverflow.com/questions/11091414/how-to-stop-mysqld)
alias start-mysql="mysql.server start"
alias stop-mysql="mysqladmin -u root shutdown"

# neo4j
alias start-neo4j="neo4j start"
alias stop-neo4j="neo4j stop"

# redis message broker
alias start-redis="redis-server"
alias stop-redis="redis-cli shutdown"

# rabbitmq message broker
alias start-rabbitmq="rabbitmq-server"

# find
alias find-stoppables="ps aux | egrep 'sql|neo4j' --color"
