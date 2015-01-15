# --- ALIASES ---

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias gs='git status'
alias ll='ls -laF'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
alias edit-nginx="subl /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/sites-enabled/web"
function cd() {
  builtin cd "$*" && ll
}

# --- PATH ---

PATH=$PATH:/usr/local/mysql/bin           # mysql
PATH=$PATH:/var/lib/mongodb               # mongodb
PATH=$PATH:/Users/jasonbenn/arcanist/bin  # arcanist


# --- UTILITY FUNCTIONS ---

function cd-fixture() {
  echo "In member..."
  builtin cd /Users/jasoncbenn/code/clinkle-web/member && bundle exec rake fixture:stop
  echo "In support..."
  builtin cd /Users/jasoncbenn/code/clinkle-web/support && bundle exec rake fixture:stop
  echo "In treatsapp..."
  builtin cd /Users/jasoncbenn/code/clinkle-web/treatsapp && bundle exec rake fixture:stop
  echo "In $*..."
  builtin cd "/Users/jasoncbenn/code/clinkle-web/$*" && bundle exec rake fixture:start
}

function deploy() {
  tier=$1
  current_branch="$(git rev-parse --abbrev-ref HEAD)"
  git checkout develop
  git pull --rebase
  git checkout release/$tier
  git reset --hard develop
  git push # will fail if force push is necessary
  git checkout $current_branch
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
  git push
}

# --- THIRD PARTY ---

source /Users/jasoncbenn/code/dotfiles/git-completion.bash
source ~/.profile


# --- APPEARANCE ---

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

# color of files displayed by the ls command
export LSCOLORS=ExFxCxDxBxegedabagacad

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

PS1='\[${c_cyan}\]\W\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]: '
