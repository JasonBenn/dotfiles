# use bash_profile
ln -sf /Users/jasonbenn/code/dotfiles/bash_profile.bash /Users/jasonbenn/.bash_profile

# install sublime settings and keymap (symlinks don't work)
cp ~/code/dotfiles/sublime_settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
cp ~/code/dotfiles/sublime_keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Default\ \(OSX\).sublime-keymap

# install ~/.gemrc
# ln -sf /Users/jasonbenn/code/dotfiles/gemrc /Users/jasonbenn/.gemrc
