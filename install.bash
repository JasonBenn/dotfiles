# install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash


# pip
curl -O https://bootstrap.pypa.io/get-pip.py
sudo chown -R `whoami` /Library/Python/2.7/
python get-pip.py
pip install --ignore-installed six
pip install virtualenv virtualenvwrapper

# minerva-keytool
git clone https://github.com/minervaproject/minerva-keytool
cd minerva-keytool/
mkvirtualenv minerva-keytool
python setup.py sdist bdist_wheel
brew install git-crypt lastpass-cli
lpass login jasoncbenn@gmail.com

# mysql
brew install mysql
mysql.server start

# nginx
brew install nginx
sudo nginx
bash ~/code/picasso/scripts/configure-nginx

# m2crypto
brew install openssl
export LDFLAGS="-L$(brew --prefix openssl)/lib"
export CFLAGS="-I$(brew --prefix openssl)/include"
export SWIG_FEATURES="-cpperraswarn -includeall -I$(brew --prefix openssl)/include"
pip install m2crypto

# misc
brew install redis awscli pv mycli
# Update line in /Users/jasonbenn/.virtualenvs/picasso/lib/python2.7/site-packages/django/db/backends/mysql/client.py to 'mycli' to use.
