# install work ssh_configs...
# sudo ln -sf /Users/jasonbenn/code/dotfiles/ssh_config.oregon /Users/jasonbenn/.ssh/config && rm ~/.ssh/known_hosts
# sudo ln -sf /Users/jasonbenn/code/dotfiles/ssh_config.norcal /Users/jasonbenn/.ssh/config && rm ~/.ssh/known_hosts

# use work_bash_profile
# ln -sf /Users/jasonbenn/code/dotfiles/work_bash_profile.bash /Users/jasonbenn/.bash_profile

# use home_bash_profile
# ln -sf /Users/jasonbenn/code/dotfiles/home_bash_profile.bash /Users/jasonbenn/.bash_profile

# install sublime settings and keymap
sudo ln -sf /Users/jasonbenn/code/dotfiles/sublime_settings /Users/jasonbenn/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
sudo ln -sf /Users/jasonbenn/code/dotfiles/sublime_keymap /Users/jasonbenn/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap

# install work config on ssh'd machine
# scp /Users/jasonbenn/code/dotfiles/work_bash_profile.bash jason@all001-dev.srv.clinkle.com:/home/jason/.bashrc

# install ~/.gemrc
ln -sf /Users/jasonbenn/code/dotfiles/gemrc /Users/jasonbenn/.gemrc
