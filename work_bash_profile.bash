# --- ALIASES ---

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias gs='git status'
alias ls='ls -G'
function cd()
{
 builtin cd "$*" && ls -la
}
# alias edit-nginx="subl /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/sites-enabled/web"


# --- PATH ---

PATH=$PATH:/usr/local/mysql/bin           # mysql
PATH=$PATH:/var/lib/mongodb               # mongodb
PATH=$PATH:/Users/jasonbenn/arcanist/bin  # arcanist

# --- THIRD PARTY ---

source /Users/jasoncbenn/code/dotfiles/git-completion.bash
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


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
