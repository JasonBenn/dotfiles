# --- Secrets ---

for file in $( ls $HOME/.secrets ); do 
  export "${file}=`cat $HOME/.secrets/${file}`"
done

# --- Path ---

export PATH=""
export PATH="$PATH:/Users/jasonbenn/.rbenv/shims" # rbenv
export PATH="$PATH:/usr/local/heroku/bin"   # heroku
# export PATH="$PATH:/Users/jasonbenn/code/sourceress/web/node_modules/.bin"  # sourceress node_modules, includes webpack


# Slightly reordered version of /etc/paths:
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/bin"
export PATH="$PATH:/sbin"



# --- Third Party ---

# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # shims, autocompletion
eval "$(pyenv init -)"  # pyenv autocompletion
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

export EDITOR='subl -w'
export NODE_REPL_HISTORY_FILE="/Users/jasonbenn/code/node_repl_history_file.txt"
export NODE_PATH=/usr/local/lib/node_modules

export PGDATA="/usr/local/pgsql/data"

function very_productive_mins_today {
  total_mins=$(curl -s --data "key=${RESCUETIME_API_KEY}&format=json" https://www.rescuetime.com/anapi/data \
    | jq '.rows[] | select(.[5] == 2) | .[1]' \
    | paste -sd+ - | xargs -I{} expr "({})/60" | bc)
  hours=$(expr "${total_mins}/60" | bc)
  mins=$(expr "${total_mins}%60" | bc)
  printf "${hours}:%02d\n" ${mins}
}


# --- BASH CONFIGURATION ---

shopt -s extglob # Enable regexes in globs!

# Unlimited recorded history, so you can find a command from months ago
export HISTFILESIZE=
export HISTSIZE=

export HISTCONTROL=ignoredups:erasedups # All previous lines matching the current line are removed from the history list before that line is saved

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



# --- COMPLETION ---

complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip

# _manage_commands_completion() {
# ls $HOME/code/sourceress/web/main/management/commands/ | grep -v ^__ | sed s/.py//
#   COMPREPLY=( $( compgen -W '-a -d -f -l -t -h --aoption --debug \
#                                --file --log --test --help --' -- $cur ) );;
# }
# complete -F _manage_commands_completion -o default manage.py
# complete -F _python_django_completion -o default $pythons
# complete -F _django_completion -o default django-admin.py manage.py django-admin

source "/usr/local/etc/bash_completion.d/git-completion.bash"
source "/usr/local/etc/bash_completion.d/git-prompt.sh"
source "/usr/local/etc/bash_completion.d/ssh-completion.bash" # SSH completion from ~/.ssh/config
# source "/usr/local/etc/bash_completion.d/django-completion.bash"  # takes too long
__git_complete gco _git_checkout # Enable autocomplete for gco



# --- ALIASES ---

alias egrep="egrep --color"
alias ll="ls -laF"
alias gvenv="cd $VIRTUAL_ENV/lib/python3.6/site-packages/"

alias lw="python ~/code/timelogger/interface.py work"
alias lm="python ~/code/timelogger/interface.py me"
alias lf="python ~/code/timelogger/interface.py friends"
alias tls="python ~/code/timelogger/interface.py sumtag"
alias draft-wach="cd ~/Dropbox/Draft && wach -o **/*.rtf, textutil -convert txt {}"
alias draft-convert="ls ~/Dropbox/Draft/**/*.rtf | xargs -I LINE textutil -convert txt LINE"
alias dlpn="cd ~/code/deep-learning-paper-notes"
alias dli="cd ~/code/deep-learning-implementations"
alias flashcards="cd /Users/jasonbenn/code/flashcards; subl ."

alias ssh-tunnel-dl="ssh -N -f -L localhost:8889:localhost:8889 jbenn@76.103.90.78 -p 55; open http://localhost:8889"

function cd {
  builtin cd $1

  script_name="$HOME/.cd-scripts/`pwd | xargs basename`"
  if [ -e ${script_name} ]; then 
    source ${script_name}
  fi
}

# --- GIT ALIASES ---

alias gist="gist -c"
alias gs="git status -sb"
alias edit-nginx="subl /usr/local/etc/nginx/nginx.conf"
alias gco="git checkout"
# alias gbd="git branch --merged | grep -v '\*' | egrep -v 'master|development' | xargs -n 1 git branch -d" # delete local branches whose remotes were merged & deleted
alias gr="git recent" # delete local branches whose remotes were merged & deleted
alias go="git open"  # open this branch on Github

PRETTY_LOG="log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.lg "${PRETTY_LOG}"
TODAY=$(date -j -f '%a %b %d %T %Z %Y' "`date`" '+%b %d 0:00')
git config --global alias.today "${PRETTY_LOG} --since='${TODAY}'"
git config --global alias.pop "reset HEAD^"
git config --global alias.s "stash"
git config --global alias.sp "stash pop"

alias gb="git for-each-ref --sort='-committerdate:iso8601' --format=' %(committerdate:iso8601)%09%(refname)' refs/heads"
function gbd {
  git branch -D $1
  git push --delete origin $1
}
# Not working yet...
# complete -F __git_heads gbd
# __git_complete gbd __git_heads


function grepo {
  user_name="JasonBenn"
  repo_name=$(pwd | xargs basename)
  curl -u "$user_name" https://api.github.com/user/repos -d "{\"name\":\"$repo_name\"}"
  echo "Set up remote $repo_name!"
  git init
  git commit --allow-empty -m "First commit."
  git remote add origin git@github.com:$user_name/$repo_name.git
  git push --set-upstream origin master
}

function gd {
  git diff --color=always | less -r
}

function gpr {
  git pull --rebase --autostash
}

function gp {
  if [ $(git remote show | grep heroku) ]; then
    $(git push heroku master)
  fi

  git push

  echo git log --pretty="format:⚙️ %h [$(very_productive_mins_today)]: %s" -n1
  # echo "Posting to RescueTime..."
  # date_today=$(date +"%Y-%m-%d")
  # curl --data "key=$RESCUETIME_API_KEY&highlight_date=${date_today}&description=$(pbpaste)" https://www.rescuetime.com/anapi/highlights_post
}

function cplg {
  echo -e "$(git log --pretty="format:⚙️ %s" -n${1})" | gtac | pbcopy
  echo -e "$(git log --pretty="format:⚙️ %s" -n${1})" | gtac
}

function ga {
  git add --all .
}

function gc {
  echo 'Commit message: '
  read -e commitmessage
  git commit -m "$commitmessage"
}

function gacwip {
  ga
  git commit -m "WIP" --no-verify
}

function gac {
  ga
  gc
}

function gcp {
  gc
  gp
}

function gacp {
  ga
  gcp
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
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

gsync () {
  # Syncs a local directory to a remote directory, then watches for changes
  # Usage:
  #
  #   $ gsync 35.203.128.177 ${HOME}/Workspace/unrestricted-advex
  #
  ip=${1:-${default_ip}}
  local_dir=${2:-"${HOME}/Workspace/unrestricted-advex"}
  remote_dir=${3:-"/home/tom/code/attn"}
  echo $remote_dir
  echo $local_dir
  echo $ip
  username='jasonbenn'

  _gsync_once () {
    # Rsync all files using gzip compression and not following links
    rsync -azP --no-links \
      -e "ssh -i $HOME/.ssh/google_compute_engine -oStrictHostKeyChecking=no" \
      --exclude 'tmp/' \
      --exclude 'data/' \
      $local_dir $username@$ip:$remote_dir
  }

  # Sync once, then sync every time there is a change in local_dir
  _gsync_once
  fswatch -o $local_dir | while read f; do
      _gsync_once
   done
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jasonbenn/code/google-cloud-sdk/path.bash.inc' ]; then . '/Users/jasonbenn/code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jasonbenn/code/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/jasonbenn/code/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/usr/local/override-bin:$PATH"

alias clippings_to_roam="PYENV_VERSION=clippings_to_roam python ~/code/clippings_to_roam/parse.py"
