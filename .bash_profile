export EDITOR="/usr/local/bin/mate -w"
export RDBASE="/usr/local/share/RDKit"
#export SCHRODINGER='/opt/schrodinger/suites2015-2'
export PYTHONPATH="/usr/local/lib/python3:$PYTHONPATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

