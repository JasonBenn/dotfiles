# install homebrew
# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

# pyenv, pyenv virtualenv
brew install pyenv pyenv-virtualenv
# add pyenv virtualenv-init to your shell to enable auto-activation of virtualenv
$ echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile

# postgres
brew install postgresql@9.6
pg_ctl start

# nginx
brew install nginx
brew services start nginx

# misc
brew install awscli pv

# bash
brew install bash
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash 
