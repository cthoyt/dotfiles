
# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#install postgres
brew install postgres

# install git
brew install git

# install python and pip
brew install python
easy_install pip

# install virtualenv
# see: http://docs.python-guide.org/en/latest/dev/virtualenvs/
pip install virtualenv virtualenvwrapper

# install web stack
pip install psycopg2 sqlalchemy pillow flask flask-restless django

# install scipy stack
pip install numpy scipy pandas matplotlib

# install ipython
pip install pyzmq jinja2 image tornado ipython

#install rdkit
brew install rdkit

