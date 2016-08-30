#!/usr/bin/env bash

export DEV=~/dev
export BANANA_BASE=~/dev/banana
export DOTFILES=~/dev/dotfiles
export NOTEBOOKS=~/dev/notebooks
export WEBSITE=~/dev/cthoyt.github.io

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f ~/.bash_secrets ]; then
	source ~/.bash_secrets
fi
