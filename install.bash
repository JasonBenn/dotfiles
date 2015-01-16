# install work ssh_configs...
# sudo ln -sf /Users/jasoncbenn/code/dotfiles/ssh_config.oregon /Users/jasoncbenn/.ssh/config && rm ~/.ssh/known_hosts
# sudo ln -sf /Users/jasoncbenn/code/dotfiles/ssh_config.norcal /Users/jasoncbenn/.ssh/config && rm ~/.ssh/known_hosts

# use work_bash_profile
# ln -sf /Users/jasoncbenn/code/dotfiles/work_bash_profile.bash /Users/jasoncbenn/.bash_profile

# use home_bash_profile
# ln -sf /Users/jasoncbenn/code/dotfiles/home_bash_profile.bash /Users/jasoncbenn/.bash_profile

# install sublime settings and keymap
sudo ln -sf /Users/jasoncbenn/code/dotfiles/sublime_settings /Users/jasoncbenn/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
sudo ln -sf /Users/jasoncbenn/code/dotfiles/sublime_keymap /Users/jasoncbenn/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap

# install work config on ssh'd machine
# scp /Users/jasoncbenn/code/dotfiles/work_bash_profile.bash jason@all001-dev.srv.clinkle.com:/home/jason/.bashrc

# install ~/.gemrc
ln -sf /Users/jasoncbenn/code/dotfiles/gemrc /Users/jasoncbenn/.gemrc
