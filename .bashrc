#!/usr/bin/env bash

export PATH=~/.local/bin:/usr/local/sbin:$PATH

export DEV=~/dev
export DOTFILES=~/dev/dotfiles
export NOTEBOOKS=~/dev/notebooks
export WEBSITE=~/dev/cthoyt.github.io
export BANANA_BASE=~/dev/banana
export BUG_FREE_EUREKA_BASE=~/dev/bug-free-eureka
export AETIONOMY_BASE=~/dev/aetionomy
export PYBEL_BASE=~/dev/pybel
export PYBEL_TOOLS_BASE=~/dev/pybel-tools
export PYBEL_RESOURCES_BASE=~/dev/pybel-resources
export BMS_BASE=~/dev/bms
export NEUROMMSIG_BASE=~/dev/neurommsig
export PYBEL2CX_BASE=~/dev/pybel2cx
export OWNCLOUD_BASE=~/ownCloud

export EDITOR="/usr/local/bin/mate -w"
export PYTHONPATH="/usr/local/lib/python3:$PYTHONPATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export RDBASE="/usr/local/share/RDKit"

# postgres (currently running automatically in background)
export PGDATA='/usr/local/var/postgres'
export PGHOST=localhost

if [ -f /usr/libexec/java_home ]; then
	export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"
	export CLASSPATH=$DEV/jars/*:$CLASSPATH
fi

# customize bash prompt (http://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/)
export PS1="$(tput setaf 5)[\!] $(tput setaf 1)[\A] $(tput setaf 2)[\u@\h:$(tput setaf 3)\w$(tput setaf 2)]$(tput setaf 4)\n\$ $(tput sgr0)"
export PS2="> "

[ -f ~/.bash_secrets ] && source ~/.bash_secrets

# Get virtualenv ready
export VIRTUALENVWRAPPER_PYTHON="$(which python3)"
[ -f /usr/local/bin/virtualenvwrapper.sh ] && source /usr/local/bin/virtualenvwrapper.sh

# Get rbenv ready
[ -x "$(command -v rbenv)" ] && eval "$(rbenv init -)"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# Get RVM ready
# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Import aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

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

# Editing
# http://matplotlib.org/users/customizing.html#customizing-with-matplotlibrc-files

function save_rcs {
	for i in ~/.profile ~/.bashrc ~/.bash_profile ~/.bash_aliases ~/.Rprofile ~/.gemrc ~/.gitignore_global ~/.gitconfig; do
		cp $i $DOTFILES/
	done
	
	cp ~/.matplotlib/matplotlibrc $DOTFILES/matplotlibrc
	
	cp -r ~/.jupyter/ $DOTFILES/jupyter/
	cp -r ~/.ipython/ $DOTFILES/ipython/
	cp -r /usr/local/lib/python3.6/site-packages/nbconvert/templates/latex/custom/ $DOTFILES/latex_templates/
}

# The repopulate function should do the opposite of save-rcs
function repopulate_rcs {
	for i in .profile .bashrc .bash_profile .bash_aliases .Rprofile .gemrc .gitignore_global .gitconfig; do
		cp $DOTFILES/$i ~/
	done
	
	cp $DOTFILES/matplotlibrc ~/.matplotlib/matplotlibrc
	
	cp -r $DOTFILES/jupyter/ ~/.jupyter/
	cp -r $DOTFILES/ipython/  ~/.ipython/
	cp -r $DOTFILES/latex_templates/ /usr/local/lib/python3.6/site-packages/nbconvert/templates/latex/custom/ 
}

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

function r_install {
	echo "$1" >> $DOTFILES/r_packages.txt
	r -e "install.packages('$1')"
}

function bioconductor_install {
	echo "$1" >> $DOTFILES/bioconductor_packages.txt
	r -e "source('https://bioconductor.org/biocLite.R')"
	r -e "biocLite('$1')"
}

function jnbc {
	jupyter nbconvert "$1" --to pdf --template custom/no_code.tplx --output-dir=~/Downloads
}

alias edit-sshconfig='$EDITOR ~/.ssh/config'
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


alias cool="echo cool"
alias pyserver="cd $WEBSITE; python3 -m SimpleHTTPServer"
alias tree="tree -C"

alias jnn="jupyter notebook --notebook-dir $NOTEBOOKS"
alias jnd="jupyter notebook --notebook-dir $DEV"
alias pybelweb="pybel-web run -vv"

alias showallfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideallfiles='defaults write com.apple.finder AppleShowAllFiles NO;  killall Finder /System/Library/CoreServices/Finder.app'

function update_brew {
	brew update
	brew doctor
	brew upgrade
	brew cleanup
	brew cask cleanup
	brew prune
}

function update_python3 {
	echo "Checking setuptools, pip, and wheel"
	python3 -m pip install -U setuptools pip wheel
	echo "Checking for outdated packages"
	python3 -m pip list -o --format=columns | cut -d " " -f 1 | tail -n +3 | xargs -n 1 python3 -m pip install -U	
}

function cleansing_python3 {
	echo "Deleting all packages"
	python3 -m pip list --format=columns | cut -d " " -f 1 | tail -n +3 | grep "^pip\|setuptools\|wheel\|distribute$" -v | xargs -n 1 python3 -m pip uninstall -y	
}

function update_ruby {
	head -n 1 $(which gem)
	gem update --system
	gem update 
	gem cleanup
}

function update_repos {
	d=$(pwd)
	
	cd $DEV
	
	for sd in $(ls); do
		cd $sd
		echo updating $(pwd)
		git pull
		cd $DEV
	done
	
	#cd $PYBEL_RESOURCES_BASE; git pull
	#cd $BMS_BASE; git pull
	#cd $PYBEL_BASE; git pull
	#cd $PYBEL_TOOLS_BASE; git pull
	#cd $d
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
	update_python2
	echo
	echo "$(tput setaf 5)Updating ruby$(tput sgr0)"
	[ -x "$(command -v rbenv)" ] && update_ruby
	echo
	echo "$(tput setaf 5)Pulling git repos$(tput sgr0)"
	update_repos
}

alias u="update_all"

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

# Reinstalls the R kernel for Jupyter notebook
function reinstall_irkernel {
	r -e "install.packages(c('repr', 'pbdZMQ', 'devtools'), repos='http://cran.us.r-project.org')"
	r -e "devtools::install_github('IRkernel/IRdisplay')"
	r -e "devtools::install_github('IRkernel/IRkernel')"
	r -e "IRkernel::installspec()"
}

function grepall {
	grep -I -rn $1 . --color=auto
}

# startables and stoppables

# find
alias find_stoppables="ps aux | egrep 'sql|neo4j' --color"

#alias start-postgres='pg_ctl -l $PGDATA/server.log start'
alias start_postgres='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias stop_postgres='pg_ctl stop -m fast'
alias show_postgres-status='pg_ctl status'
alias restart_postgres='pg_ctl reload'

# mysql (http://stackoverflow.com/questions/11091414/how-to-stop-mysqld)
alias start_mysql="mysql.server start"
alias stop_mysql="mysqladmin -u root shutdown"

# neo4j
alias start_neo4j="neo4j start"
alias stop_neo4j="neo4j stop"

# redis message broker
alias start_redis="redis-server"
alias stop_redis="redis-cli shutdown"


alias git_pull_all="find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;"

# rabbitmq message broker
alias start_rabbitmq="rabbitmq-server"

# Docker aliases
function docker_container_rm {
	docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
}

function docker_nuke {
	docker_container_rm
	docker volume rm $(docker volume ls -q)
	docker rmi $(docker images ls -aq)
}
