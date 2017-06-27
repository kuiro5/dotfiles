export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
   . "/usr/local/opt/nvm/nvm.sh"

# Git
git_current_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}

ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gcb='git checkout -b'
alias gcam='git commit -a -m'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gf='git fetch'
alias gm='git merge'
alias glg='git log --stat'
alias gst='git status'
alias gsta='git stash save'

# Personal Navigation
alias vimrc="vim ~/.vimrc"
alias bp="vim ~/.bash_profile"
alias sf="bash ./stop_foreman.sh"
alias fs="nf start"
alias sos="sf && fs"
alias rc="./script/console"
alias core="bundle exec unicorn_rails -p 3000"
alias sc="./script/console"
alias next="brunch watch --server"
alias gobman="cd ~/Desktop/code/tout-burning-man"
alias gonext="cd ~/Desktop/code/tout-next"
alias gocore="cd ~/Desktop/code/tout"
alias code="cd ~/Desktop/code"
alias goui="cd ~/Desktop/code/ui-components"
alias gotable="cd ~/Desktop/code/tout-table"
alias obman="atom ~/Desktop/code/tout-burning-man"
alias onext="atom ~/Desktop/code/tout-next"
alias ocore="atom ~/Desktop/code/tout"
alias otout="atom ~/Desktop/code"
alias oui="atom ~/Desktop/code/ui-components"
alias nrd="npm run dev"
alias dstg="bash ~/Desktop/scripts/deploy-staging.sh"
alias sstg="bash ~/Desktop/scripts/ssh-staging.sh"
alias gbl="git for-each-ref --sort='-authordate:iso8601' --format=' %(authordate:iso8601)%09%(refname)' refs/heads"
alias gap="git add -p"
alias gbpurge="git branch --merged | grep -v "\*" | xargs -n 1 git branch -d"
alias atomic="atom ~/Desktop/code/tout-burning-man && atom ~/Desktop/Toutapp/tout-next && atom ~/Desktop/Toutapp/tout"
alias gt="gulp test"

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ ! $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}

PS1="\[$COLOR_WHITE\]\n[\W]"          # basename of pwd
PS1+="\[\$(git_color)\]"        # colors git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
export PS1

function tab_title {
  echo -n -e "\033]0;${PWD##*/}\007"
}

PROMPT_COMMAND="tab_title ; $PROMPT_COMMAND"
