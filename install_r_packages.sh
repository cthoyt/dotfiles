#! /usr/bin/env sh

cat $DOTFILES/r_packages.txt | while read -r line 
do
	r -e "install.packages('$line')"
done

r -e "source('https://bioconductor.org/biocLite.R')"

cat $DOTFILES/bioconductor_packages.txt | while read -r line
do
	r -e "biocLite('$line')"
done
