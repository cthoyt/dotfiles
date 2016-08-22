# dotfiles

`setup.sh` is a script I've been working on that I can run on a clean install of Mac OS X to set up my favorite command line and GUI tools.

## Contents

| Script | Description |
| --- | --- |
| `setup.sh` | automatically downloads everything and puts it all in the right place and sets up everything | 
| `osx.sh` | has stuff to set all of my OSX settings |


| Dotfile | Description | 
| --- | --- |
| `.bash_profile` | sources `.bashrc` because I don't know the [difference](http://stackoverflow.com/questions/415403/whats-the-difference-between-bashrc-bash-profile-and-environment) between interactive and non-interactive consoles |
| `.bashrc` | has stuff to make my bash cool |
| `.gitconfig` | stuff |
| `.gitignore` | stuff not to include in cthoyt/dotfiles |
| `.gitignore_global` | stuff to not include anywhere | 
| `.cron` | cron jobs I want to always have |
| `eclipse_cleanup.xml` | my eclipse java code cleanup settings | 
| `eclipse_formatter.xml` | my eclipse java code formatter settings | 

## Make It Happen

### 1. Download and Run `setup.sh`

- `curl -0L https://raw.github.com/cthoyt/dotfiles/master/setup.sh | sh`
- no `virtualenv` yet

### 2. Something about SSH Keys

- [Generate new SSH key](https://help.github.com/articles/generating-ssh-keys/)
- [Generate an access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)

- add stuff to ~/.ssh/config 

example:
```
Host github-username
	Hostname ssh.github.com
	IdentityFile ~/.ssh/my_private_rsa
	IdentitiesOnly yes
	User git
```

### 3. Install Licensed Software

#### PyCharm

- Log in at https://account.jetbrains.com/login
- Download Activation Key for PyCharm

#### iStat Menus

### 4. Eclipse

#### Maven
http://stackoverflow.com/questions/8620127/maven-in-eclipse-step-by-step-installation

## todo

- Add R package installation to `setup.sh`

## Credits

Thanks to everyone who inspired me, and from whom I shamelessly stole ideas.

| Name | Source | 
| --- | --- | 
| @mdo |  [mdo/config](https://github.com/mdo/config) |
| @mathiasbynes | [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) |
| @CristpherA | [ChristopherA/MacOSXYosementDevelopmentInstall.md](https://gist.github.com/ChristopherA/d48946c72d75c4330374) |
| @mjperrone | [mjperrone/dot_files](https://github.com/mjperrone/dot_files)
