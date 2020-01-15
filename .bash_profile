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

function clone () {
  if [ -z $2 ]; then
    pushd ~/workspace
  else
    pushd $2
  fi
 git clone git@git.internal.tulip.io:$1.git
  popd
}

function clone-profile () {
  if [ -z $2 ]; then
    if [ ! -d ~/workspace/profiles/$1 ]; then
      mkdir ~/workspace/profiles/$1
    fi
    pushd ~/workspace/profiles/$1
  else
    pushd $2
  fi
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/infra_base_0.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/infra_config_1.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/infra_service_2.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/app_config_3.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/app_service_4.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/pause_5.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/freeze_6.git
 git clone git@git.internal.tulip.io:ops/gcp/modules/tulip-develop/$1/delete_7.git
  popd
}

function viscr() {
  if [ -z $1 ]; then
    file="$HOME/Documents/ScrumNotes/$(date +%Y/%m-%B.txt)"
  else
    file="$HOME/Documents/ScrumNotes/$(date -v$1 +%Y/%m-%B.txt)"
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
export PATH="/usr/local/opt/qt/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bill/Applications/google-cloud-sdk/path.bash.inc' ]; then . '/Users/bill/Applications/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bill/Applications/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/bill/Applications/google-cloud-sdk/completion.bash.inc'; fi

