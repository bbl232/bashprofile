# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

function well (){
 if [[ ! -z $2 ]]; then
  ssh $1.well.$2
 else
  ssh $1.well.prod
 fi
}

function fando () {
 if [[ ! -z $2 ]]; then
  ssh $1.frankandoak.$2
 else
  ssh $1.frankandoak.prod
 fi
}

function tru () {
 if [[ ! -z $2 ]]; then
  ssh $1.toysrus.$2
 else
  ssh $1.toysrus.prod
 fi
}

function tulip () {
 if [[ ! -z $2 ]]; then
  ssh $1.tulip.$2
 else
  ssh $1.tulip.prod
 fi
}

function mlse () {
 if [[ ! -z $2 ]]; then
  ssh $1.mlse.$2
 else
  ssh $1.mlse.prod
 fi
}

function mk () {
 if [[ ! -z $2 ]]; then
  ssh $1.michaelkors.$2
 else
  ssh $1.michaelkors.prod
 fi
}

function gs () {
 if [[ ! -z $2 ]]; then
  ssh $1.gamestop.$2
 else
  ssh $1.gamestop.prod
 fi
}

function clone () {
 pushd ~/workspace
 git clone tulipadmin@internal.well.prod:git/$1.git
 popd
}

# User specific environment (stuff that will get passed on to subshells)

export PATH=$HOME/.bin:~/.gem/ruby/1.8/bin:$PATH
export MANPATH=/usr/local/man:$MANPATH

unset USERNAME
export CLICOLOR

export HISTCONTROL=erasedups
export HISTSIZE=10000

export GREP_OPTIONS="-I --color --exclude=*.svn-base"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export SCALA_HOME=/usr/local/share/scala-2.9.2
export PATH=$PATH:$SCALA_HOME/bin
export PATH=$PATH:/Users/matt/android/android-sdk-macosx/tools:/Users/matt/android/android-sdk-macosx/platform-tools
