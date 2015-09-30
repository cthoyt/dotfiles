alias edit-bashrc='mate -w ~/.bashrc; source ~/.bashrc; echo "nailed it"'
alias edit-sshconfig='mate  ~/.ssh/config'
alias qq='exit'

alias la='ls -alFG'
alias ..="cd .."
alias ...="cd ../.."
alias cool="echo cool"
alias pyserver="python -m SimpleHTTPServer"
alias jn="cd ~/dev; jupyter notebook"

alias update-python="pip3 freeze --local | grep -v '^\-e'  | cut -d = -f 1 | xargs -n1 pip3 install -U"
alias update-brew="brew update && brew cleanup && brew cask update && brew cask cleanup"

#list:
if [ "$(uname)" = 'Linux' ] ; then
    alias ls='ls --color -F'
elif [ "$(uname)" = 'Darwin' ] ; then
    alias ls='ls -FG' #default color + directory flags
fi

alias showallfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideallfiles='defaults write com.apple.finder AppleShowAllFiles NO;  killall Finder /System/Library/CoreServices/Finder.app'

#export WORKON_HOME=~/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

export PS1="$(tput setaf 1)[\!] $(tput setaf 2)[\u@\h:$(tput setaf 3)\w$(tput setaf 2)]$(tput setaf 4)\n$ $(tput sgr0)"
export PS2="> "

