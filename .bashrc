#
# A tweaked out bash script that adds a bunch of useful functionality.
#
# NOTE: ~ expansion doesn't work here, for partially unclear reasons

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Color setup
if [ "$TERM" != "dumb" ] ; then
	NOCOLOR=$(tput sgr0)
	BLACK=$(tput setaf 0)
	RED=$(tput setaf 1)
	GREEN=$(tput setaf 2)
	YELLOW=$(tput setaf 3)
	BLUE=$(tput setaf 4)
	MAGENTA=$(tput setaf 5)
	CYAN=$(tput setaf 6)
	WHITE=$(tput setaf 7)
	BOLD=$(tput bold)
	UNDERLINE=$(tput smul)
	BLINK=$(tput blink)
	REVERSE=$(tput rev)
fi

colortest() {
	echo -e "${NOCOLOR}COLOR_NC (No color)"
	echo -e "${NOCOLOR}${BLACK}BLACK\t${BOLD}BLACK"
	echo -e "${NOCOLOR}${RED}RED\t${BOLD}RED"
	echo -e "${NOCOLOR}${GREEN}GREEN\t${BOLD}GREEN"
	echo -e "${NOCOLOR}${YELLOW}YELLOW\t${BOLD}YELLOW"
	echo -e "${NOCOLOR}${BLUE}BLUE\t${BOLD}BLUE"
	echo -e "${NOCOLOR}${MAGENTA}MAGENTA\t${BOLD}MAGENTA"
	echo -e "${NOCOLOR}${CYAN}CYAN\t${BOLD}CYAN"
	echo -e "${NOCOLOR}${WHITE}WHITE\t${BOLD}WHITE"
}

alias cd..='cd ..'
alias ..='cd ..'
alias ls='ls -alh'
alias k='kubectl'

alias gl='git log --oneline --graph --all --decorate'
alias gp='git pull'
alias gc='git commit'
alias gpu='git push'
alias ga='git add -p'
alias gs='git status'
alias retire='aws autoscaling set-instance-health --health-status Unhealthy --instance-id'

# Resize our window oppourtunistically
shopt -s checkwinsize

# Tweak our history settings
shopt -s histappend
alias h='history|grep'

# Set readline vars
set completion-ignore-case on

# Now to pimp out our prompt
export LSCOLORS=dxexbxbxcxbxbxfx

git_color(){
  git diff --quiet --ignore-submodules HEAD 2>/dev/null && echo "$GREEN" || echo "$RED"
}

git_branch(){
  git symbolic-ref --short HEAD 2>/dev/null | sed -E "s/(.+)/[\1]/"
}

PS1="\u@\h \[$BOLD$BLUE\](\w)\[$NOCOLOR\]\[\$(git_color)\]\$(git_branch)\[$NOCOLOR\] \n\$(echo -e '\xf0\x9f\x8d\xba') \\$ "

# Prompt command updates our terminal window title
PROMPT_COMMAND='echo -ne "\033]0; [${USER}@${HOSTNAME} ${PWD/$HOME/~}]\007"'

# Arcanist for create code reviews on Phabricator
export PATH=$PATH:~/workspace/dev_scripts/arcanist/bin
alias :q='exit'
alias kiali='kubectl port-forward -n istio-system $(kubectl get po -l app=kiali -n istio-system -o json | jq '.items[0].metadata.name' -r) 20001'
alias grafana='kubectl port-forward -n istio-system $(kubectl get po -l app=grafana -n istio-system -o json | jq '.items[0].metadata.name' -r) 3000'
alias jaeger='kubectl port-forward -n istio-system $(kubectl get po -l app=jaeger -n istio-system -o json | jq '.items[0].metadata.name' -r) 16686'


export EDITOR=vim
export PATH=$PATH:/usr/local/share/npm/bin/
export NODE_PATH='/usr/local/lib/node'
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node:/usr/local/lib/node:/usr/local/lib/node
#Add all ssh keys
while read k; do ssh-add ~/.ssh/$k >/dev/null 2>&1; done < <(ls -als | grep "\-r.\-\-\-\-\-\-\-" | rev | cut -f 1 -d ' ' | rev)

function knife2(){
  knife $@ --config ~/.chef/knife2.rb
}

function kcontext(){
  if [ -z "${1}" ] || [ -z "${2}" ]; then
    echo "Usage: kcontext <project> <namespace> # e.g. kcontext tulip-develop bill"
    return 1
  fi

  gcloud config set project ${1}
  clusters=$(gcloud container clusters list --format json)
  count=$(echo ${clusters} | jq -r 'length')
  index=0
  if [ 1 -eq ${count} ]; then
    echo "Defaulting to cluster: $(echo ${clusters} | jq '.[0].name')"
  else
    cluster_names=($(echo ${clusters} | jq -r '.[].name'))
    echo "Which cluster?"
    for cluster in ${!cluster_names[@]}; do
     echo "[${cluster}] - ${cluster_names[$cluster]}"
    done
    read -p "[0]: " index
  fi

  index=${index:-0}

  region=$(echo ${clusters} | jq .[$index].'location' -r)
  cluster=$(echo ${clusters} | jq .[$index].'name' -r)
  gcloud container clusters get-credentials ${cluster} --region ${region} --project ${1}
  context="${1}-${2}"

  kubectl config set-context ${context} --cluster=gke_${1}_${region}_${cluster} --namespace=${2} --user=gke_${1}_${region}_${cluster}
  kubectl config use-context ${context}
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
