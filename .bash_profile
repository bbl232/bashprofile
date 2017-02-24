# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

_ops()
{
  if [ $COMP_CWORD -eq 1 ]; then
    COMPREPLY=( $(compgen -W "$(ops __COMPLETE| grep '#' | awk '{print $1}')" -- "${COMP_WORDS[${COMP_CWORD}]}") )
  else
    COMPREPLY=()
  fi
}
complete -o default -F _ops ops

function s (){
 if [[ ! -z $3 ]]; then
    ssh $2.$1.$3
 else
  ssh $2.$1.prod
 fi
}

function inbox () {
  if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "Usage: inbox 'title' 'description'"
    return
  fi

  file=$(mktemp)

  echo "
  {
    \"title\": \"${1}\",
    \"description\": \"${2}\",
    \"projectPHIDs\": [\"PHID-PROJ-gurqssurklz6ohb3weex\"],
    \"priority\": 50
  }" > ${file}
  cat ${file} | arc call-conduit maniphest.createtask && rm ${file}
}

function clone () {
  pushd ~/workspace
  if [ -z $2 ]; then
     git clone tulipadmin@internal.well.prod:git/$1.git
  else
     git clone $2@internal.well.prod:git/$1.git
  fi
  popd
}

function viscr() {
  if [ -z $1 ]; then
    file="$HOME/Documents/ScrumNotes/$(date +%Y/%m-%B/%d.md)"
  else
    file="$HOME/Documents/ScrumNotes/$(date -v$1 +%Y/%m-%B/%d.md)"
  fi
  if [ ! -d $(dirname $file) ]; then
    mkdir -p $(dirname $file)
  fi
  vim $file
}

LESS_PATH=`which less`
function less() {
  if [[ -d $1 ]]; then
      ls $1
  elif [[ -f $1 ]]; then
      $LESS_PATH $1
  fi
}

# User specific environment (stuff that will get passed on to subshells)

export PATH=~/.rbenv/shims:$HOME/.bin:~/.gem/ruby/1.8/bin:$PATH
export MANPATH=/usr/local/man:$MANPATH

unset USERNAME
export CLICOLOR

export HISTCONTROL=erasedups
export HISTSIZE=10000

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export SCALA_HOME=/usr/local/share/scala-2.9.2
export PATH=$PATH:$SCALA_HOME/bin
