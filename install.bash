# use work_bash_profile
# ln -sf /Users/jasoncbenn/code/dotfiles/work_bash_profile.bash /Users/jasoncbenn/.bash_profile

# use home_bash_profile
# ln -sf /Users/jasoncbenn/code/dotfiles/home_bash_profile.bash /Users/jasoncbenn/.bash_profile

# install sublime settings and keymap
sudo ln -sf /Users/jasoncbenn/code/dotfiles/sublime_settings /Users/jasoncbenn/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
sudo ln -sf /Users/jasoncbenn/code/dotfiles/sublime_keymap /Users/jasoncbenn/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap

# install work ssh_config
sudo ln -sf /Users/jasoncbenn/code/dotfiles/ssh_config /Users/jasoncbenn/.ssh/config

# install ~/.gemrc
ln -sf /Users/jasoncbenn/code/dotfiles/gemrc /Users/jasoncbenn/.gemrc
