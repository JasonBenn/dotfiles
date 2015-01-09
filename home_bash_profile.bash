# --- UTILITY FUNCTIONS ---

function draft(){
  cp -r /Users/jasonbenn/code/bootstrap-drafter $1
  cd $1
  open draft.html
  subl .
  bundle exec guard
}

function gac { 
  git add --all .
  local commitmessage
  if [ "" = "$1" ]; then 
    echo -n 'Commit message: '
    commitmessage="$(ruby -e "puts gets")"
    git commit -m "$commitmessage"
  else
    git commit -m "$1"
  fi
}


# --- ALIASES ---

alias gs="git status"
alias edit-nginx="subl /usr/local/etc/nginx/nginx.conf"
alias gco="git checkout"


# --- PATH ---

export HOMEBREW_PATH="/usr/local/bin:/usr/local/sbin"
export PATH="~/bin:$HOMEBREW_PATH:/usr/bin:/usr/sbin:/bin:/sbin:/Users/jasonbenn/.rbenv/versions/"
export PATH="/Users/jasonbenn/.rbenv/versions/2.0.0-p195/bin:/usr/local/share/npm/bin:/usr/local/share/npm/lib/node_modules:$PATH"
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export EDITOR='subl -w'

# --- THIRD PARTY ---

source "/usr/local/etc/bash_completion.d/git-completion.bash"
source "/usr/local/etc/bash_completion.d/git-prompt.sh"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


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
