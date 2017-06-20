DOTFILES=$HOME/code/dotfiles
APP_SUPPORT="$HOME/Library/Application Support"
BASH_COMPLETION="/usr/local/etc/bash_completion.d"


# silence MOTD, "Last login" message
touch ~/.hushlogin

# use bash_profile
ln -sf $DOTFILES/bash_profile.bash /Users/jasonbenn/.bash_profile

# install sublime settings and keymap (symlinks don't work)
cp $DOTFILES/sublime_settings "${APP_SUPPORT}/Sublime Text 3/Packages/User/Preferences.sublime-settings"
cp $DOTFILES/sublime_keymap "${APP_SUPPORT}/Sublime Text 3/Packages/User/Default (OSX).sublime-keymap"
ln -sf /Users/jasonbenn/code/dotfiles/sublime-snippets/* "${APP_SUPPORT}/Sublime Text 3/Packages/User/"

# useful applications
ln -sf /Applications/SourceTree.app/Contents/Resources/stree /usr/local/bin/
ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/
# ln -sf /Users/jasonbenn/code/mop/scripts/mop /usr/local/bin/  # needs virtualenv, somehow.

# install ~/.gemrc
# ln -sf $DOTFILES/gemrc /Users/jasonbenn/.gemrc

# install completion scripts
ln -sf $DOTFILES/git-completion.bash /usr/local/etc/

# pip.conf
mkdir -p $HOME/.pip
ln -sf $DOTFILES/pip.conf "${HOME}/.pip/"

# bash completion scripts
mkdir -p $BASH_COMPLETION
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o $BASH_COMPLETION/git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o $BASH_COMPLETION/git-completion.bash
ln -sf $DOTFILES/ssh-completion.bash $BASH_COMPLETION/ssh-completion.bash

# SSH stuff
mkdir -p $HOME/.ssh
ln -sf /$DOTFILES/ssh_config $HOME/.ssh/config
