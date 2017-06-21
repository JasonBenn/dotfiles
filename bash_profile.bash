# --- Git Utility Functions ---

function grepo {
  user_name="JasonBenn"
  repo_name=$(pwd | xargs basename)
  curl -u "$user_name" https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"}"
  git remote add origin git@github.com:$user_name/$repo_name.git
  echo "Set up remote $repo_name!"
}

function gd {
  git diff
}

function ga {
  git add --all .
}

function gac {
  ga
  local commitmessage
  if [ "" = "$1" ]; then
    echo -n 'Commit message: '
    read commitmessage
    git commit -m "$commitmessage"
  else
    git commit -m "$1"
  fi
}

function gacwip {
  ga
  git commit -m "WIP" --no-verify
}

function gacp {
  gac
  if [ $(git remote show | grep heroku) ]; then
    tput setaf 2; echo 'Deplying to Heroku...'; tput sgr0;
    $(git push heroku master)
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


# --- Path ---

export PATH=""
export PATH="$PATH:/Users/jasonbenn/.rbenv/shims" # rbenv
export PATH="$PATH:/usr/local/heroku/bin"   # heroku
export PATH="$PATH:/Users/jasonbenn/anaconda/bin" # anaconda2 4.0.0
export PATH="$PATH:/usr/local/openresty/nginx/sbin"   # nginx/openresty
export PATH="$PATH:/Users/jasonbenn/code/minerva-tools"   # minerva tools
export PATH="$PATH:node_modules/.bin" # nvm (picasso prereq)


# Slightly reordered version of /etc/paths:

export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/bin"
export PATH="$PATH:/sbin"


# --- Third Party ---

source "/usr/local/etc/bash_completion.d/git-completion.bash"
source "/usr/local/etc/bash_completion.d/git-prompt.sh"
source "/usr/local/etc/bash_completion.d/ssh-completion.bash" # SSH completion from ~/.ssh/config

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # shims, autocompletion

export EDITOR='subl -w'
export NODE_REPL_HISTORY_FILE="/Users/jasonbenn/code/node_repl_history_file.txt"
export NODE_PATH=/usr/local/lib/node_modules

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end


# --- Minerva ---

complete -W "$(echo `ls ~/code/picasso/server/seminar/management/commands/ | sed 's/.py$//' | egrep -v __init__ | egrep -v pyc`;)" server/manage.py


# --- Bash Configuration ---

# Enable regexes in globs!
shopt -s extglob

# Unlimited recorded history, so you can find a command from months ago
export HISTFILESIZE=
export HISTSIZE=

# All previous lines matching the current line are removed from the history list before that line is saved
export HISTCONTROL=ignoredups:erasedups

# Append history as you're entering commands
shopt -s histappend
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"


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


# --- ALIASES ---

alias egrep="egrep --color"
alias draft-wach="cd ~/Dropbox/Draft && wach -o **/*.rtf, textutil -convert txt {}"
alias draft-convert="ls ~/Dropbox/Draft/**/*.rtf | xargs -I LINE textutil -convert txt LINE"
alias ll="ls -laF"
alias gist="gist -c"
alias gs="git status -sb"
alias edit-nginx="subl /usr/local/etc/nginx/nginx.conf"
alias gco="git checkout"
__git_complete gco _git_checkout # Enable autocomplete for gco
alias gbd="git branch --merged | grep -v '\*' | xargs -n 1 git branch -d" # delete local branches whose remotes were merged & deleted
alias gr="git recent" # delete local branches whose remotes were merged & deleted

alias gvenv="cd $VIRTUAL_ENV/lib/python2.7/site-packages/"

alias flashcards="subl /Users/jasonbenn/code/flashcards"

git config --global alias.files-changed "diff-tree --no-commit-id --name-only -r"
PRETTY_LOG="log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lg "${PRETTY_LOG}"
TODAY=$(date -j -f '%a %b %d %T %Z %Y' "`date`" '+%b %d 0:00')
git config --global alias.today "${PRETTY_LOG} --since='${TODAY}'"
git config --global alias.pop "reset HEAD^"

function today() {
  # -E is to enable Posix Extended Regular Expressions
  # -depth 2 AND -type directory AND matching that regex is true only for git directories
  # exec replaces {} with the match data, and must end with a ;, which needs to be escaped from the shell.
  find -E . -depth 2 -type d -regex ".*/\.git" -exec git -C {} today \;
}

function check_for_virtual_env {
  [ -d .git ] || git rev-parse --git-dir &> /dev/null

  if [ $? == 0 ]; then
    local ENV_NAME=`basename \`pwd\``

    if [ "${VIRTUAL_ENV##*/}" != $ENV_NAME ] && [ -e $WORKON_HOME/$ENV_NAME/bin/activate ]; then
      workon $ENV_NAME && export CD_VIRTUAL_ENV=$ENV_NAME
    fi
  elif [ $CD_VIRTUAL_ENV ]; then
    deactivate && unset CD_VIRTUAL_ENV
  fi
}

function cd {
  builtin cd "$@" && check_for_virtual_env
}

check_for_virtual_env > /dev/null
eval `ssh-agent -s` > /dev/null

# Picasso Prequisites
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# export VIRTUAL_ENV_DISABLE_PROMPT="true"
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

export NVM_DIR="/Users/jasonbenn/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
ulimit -n 1024
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# aws setup for fast.ai
source ~/code/fast-ai/setup/aws-alias.sh
