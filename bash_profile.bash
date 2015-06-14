# --- UTILITY FUNCTIONS ---

function draft(){
  cp -r /Users/jasonbenn/code/bootstrap-drafter $1
  cd $1
  open draft.html
  subl .
  bundle exec guard
}

function grepo {
  user_name="JasonBenn"
  repo_name=$(pwd | xargs basename)
  curl -u "$user_name" https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"}"
  git remote add origin git@github.com:$user_name/$repo_name.git
  echo "Set up remote $repo_name!"
}

function gd {
  git diff --stat --summary
}

function ga {
  git add --all .
}

function gac { 
  ga
  local commitmessage
  if [ "" = "$1" ]; then 
    echo -n 'Commit message: '
    commitmessage="$(ruby -e "puts gets")"
    git commit -m "$commitmessage"
  else
    git commit -m "$1"
  fi
}

function gacp { 
  gac
  if [ $(git remote show | grep heroku) ]; then
    tput setaf 2; echo 'Deplying to Heroku...'; tput sgr0;
    if [ !$(git push heroku master) ]; then
      say "Deploy error."
    fi
  fi
  tput setaf 2; echo 'Pushing to Git...'; tput sgr0;
  git push
}

function gamend {
  ga
  echo -n 'Commit message: '
  commitmessage="$(ruby -e "puts gets")"
  if [ "" = "$commitmessage" ]; then
    git commit --amend --no-edit
  else
    git commit --amend -m "$commitmessage"
  fi
}

function gamendp {
  gamend
  git push
}

function gamendpf {
  gamend
  git push -f
}

# --- ALIASES ---

alias draft-wach="cd ~/Dropbox/Draft && wach -o **/*.rtf, textutil -convert txt {}"
alias draft-convert="ls ~/Dropbox/Draft/**/*.rtf | xargs -I LINE textutil -convert txt LINE"
alias ll="ls -laF"
alias gs="git status -sb"
alias edit-nginx="subl /usr/local/etc/nginx/nginx.conf"
alias gco="git checkout"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.files-changed "diff-tree --no-commit-id --name-only -r"



# --- PATH ---

# OLD PATH:
# /Users/jasonbenn/.rbenv/shims
# /usr/local/heroku/bin
# /Users/jasonbenn/.rbenv/versions/2.0.0-p195/bin
# /usr/local/share/npm/bin
# /usr/local/share/npm/lib/node_modules
# ~/bin
# /usr/local/bin
# /usr/local/sbin
# /usr/bin
# /usr/sbin
# /bin
# /sbin
# /Users/jasonbenn/.rbenv/versions/

# EXPERIMENTAL PATH:
export PATH="/Users/jasonbenn/.rbenv/shims" # rbenv
export PATH="$PATH:/usr/local/heroku/bin"   # heroku 

# slightly reordered version of /etc/paths:
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/bin"
export PATH="$PATH:/sbin"

# MAYBE NOT NEEDED:
# /Users/jasonbenn/.rbenv/versions/



# --- THIRD PARTY ---

source "/usr/local/etc/bash_completion.d/git-completion.bash"
source "/usr/local/etc/bash_completion.d/git-prompt.sh"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export EDITOR='subl -w'
export NODE_PATH=/usr/local/lib/node_modules


# --- PS1 ---

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
    return 0
  fi
  echo -e " $gitver"
}

branch_color ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
  if git diff --quiet 2>/dev/null >&2
  then
    color="${c_green}"
  else
    color="${c_red}"
    fi
  else
    return 0
  fi
  echo -ne "$color"
}

PS1='\W\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]: '
