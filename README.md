# dotfiles

`public_setup.sh` is a script I've been working on that I can run on a clean install of Mac OS X to set up my favorite command line and GUI tools.

## Contents

| File | Description |
| --- | --- |
| `public_setup.sh` | automatically downloads everything and puts it all in the right place and sets up everything | 
| `.bash_profile` | sources `.bashrc` because I don't know the difference between interactive and non-interactive consoles |
| `.bashrc` | has stuff to make my bash cool |
| `osx.sh` | has stuff to set all of my OSX settings |
| `.gitconfig` | stuff |
| `.gitignore` | stuff not to include in cthoyt/dotfiles |
| `.gitignore_global` | stuff to not include anywhere | 
| `.cron` | cron jobs I want to always have |
| `eclipse_cleanup.xml` | my eclipse java code cleanup settings | 
| `eclipse_formatter.xml` | my eclipse java code formatter settings | 

## Make It Happen

### 1. Do this

- just run (maybe as sudo) `curl -L https://raw.github.com/cthoyt/dotfiles/master/setup.sh | sh`

### 2. Something about SSH Keys

- [Generate new SSH key](https://help.github.com/articles/generating-ssh-keys/)
- [Generate an access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)

### 3. Profit

- yeah.

## Credits

Thanks to everyone who inspired me, and from whom I shamelessly stole ideas.

- @mdo [mdo/config](https://github.com/mdo/config)
