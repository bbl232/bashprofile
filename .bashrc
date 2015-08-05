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
alias ls='ls -alhG'

alias gl='git log --oneline --graph --all --decorate'
alias gp='git pull'
alias gc='git commit'
alias gpu='git push'
alias ga='git add -p'
alias gs='git status'

# Resize our window oppourtunistically
shopt -s checkwinsize

# Tweak our history settings
shopt -s histappend
alias h='history|grep'

# Set readline vars
set completion-ignore-case on

# Now to pimp out our prompt
export LSCOLORS=dxexbxbxcxbxbxfx
PS1=$'\u@\h \[$BOLD$BLUE\](\w)\[$NOCOLOR\] \xf0\x9f\x8d\xba \\$ '

# Prompt command updates our terminal window title
PROMPT_COMMAND='echo -ne "\033]0; [${USER}@${HOSTNAME} ${PWD/$HOME/~}]\007"'

# Arcanist for create code reviews on Phabricator
export PATH=$PATH:~/workspace/dev_scripts/arcanist/bin
alias cr='arc diff --preview'

export EDITOR=vim
export PATH=$PATH:/usr/local/share/npm/bin/
export NODE_PATH='/usr/local/lib/node'
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node
export NODE_PATH=/usr/local/lib/node:/usr/local/lib/node:/usr/local/lib/node:/usr/local/lib/node
