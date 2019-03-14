# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#######################################################################
# Startup
#######################################################################
# Bashrc Quotes
# Dependencies: Figlet, Lolcat, jq
# cat quotes.json | jq ".[$(((RANDOM % 38 )+1))]" | lolcat

echo "<<< take a step back >>>" | lolcat


#######################################################################
# General Configurations
#######################################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History Configurations
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# Turn off freezing the terminal with Ctrl S
stty -ixon

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Tab auto-completion
bind TAB:menu-complete
# Tab auto-completion to go back
bind '"\e[Z": menu-complete-backward'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/mint-fortune ]; then
     /usr/bin/mint-fortune
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability;
# turned off by default
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h \w\a\]$PS1"
    ;;
*)
    ;;
esac

##############################################################################
# Aliases
##############################################################################

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias for activating a virtual environment
alias va='source venv/bin/activate'

# Alias for copy / paste from terminal
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Alias  VPN
alias kvpn='sudo openvpn \
    --config ~/openvpn/leaheinhorn.conf \
    --up /etc/openvpn/update-resolv-conf \
    --down /etc/openvpn/update-resolv-conf \
    --script-security 2'

# Docker Aliases
# Clean docker dangling images
alias docker-clean='docker rmi --force $(docker images -a --filter=dangling=true)'
alias docker-stop='docker stop $(docker ps -a -q)'

# CD Aliases
alias code='cd ~/Development/code/'
alias scripts='cd ~/Development/scripts/'
alias kipcreate='cd ~/Development/code/KIP-Create-API/create_api'
alias kipgql='cd ~/Development/code/KIP-Create-API/graphql_api'

alias chrome='google-chrome-stable'

alias vim='nvim'

# Check if it's raining in NYC
function raining {
  local raining="$(curl -s wttr.in/nyc | grep -c Rain )"
  if [[ $raining = 0 ]]; then
    echo "No rain coming down!"
  else
    echo "Looks like rain :("
  fi
}

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

######################################################################
# Environment Variables
######################################################################

# Vault
export VAULT_ADDR='https://vault.keplergrp.com:8200/'

# Python Virtual Env
export PIPENV_VENV_IN_PROJECT='yes'

export VISUAL=vim
export EDITOR="$VISUAL"

######################################################################
# Variables
######################################################################

# Colors
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_PURPLE="\033[1;35m"
COLOR_ORANGE="\033[38;5;202m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"
COLOR_GRAY_TEXT_BACKGROUND="\033[37;44m"
BOLD="$(tput bold)"

######################################################################
# Git branching
######################################################################

function git_color {
  local git_status="$(git status 2> /dev/null)"
  local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  local git_commit="$(git --no-pager diff --stat origin/${branch} 2>/dev/null)"
  if [[ ! $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo -e $COLOR_YELLOW
  elif [[ $git_status =~ "nothing to commit" ]] && \
    [[ ! -n $git_commit ]]; then
  echo -e $COLOR_GREEN
else
  echo -e $COLOR_ORANGE
fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch) "
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit) "
  fi
}

######################################################################
# Profile
######################################################################

# pyenv
export PATH="/home/leaheinhorn/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


PS1_DIR="\[$BOLD\]\[$COLOR_BLUE\]\u@\h \[$BOLD\]\[$COLOR_PURPLE\][\w] "
PS1_GIT="\[\$(git_color)\]\[$BOLD\]\$(git_branch)\[$BOLD\]\[$COLOR_RESET\]"
PS1_END="\n\[$COLOR_GRAY_TEXT_BACKGROUND\]\t\[$COLOR_RED $BOLD\]♥ \[$COLOR_BLUE\]// \[$COLOR_RESET\]"
PS1="${PS1_DIR}${PS1_GIT}${PS1_END}"


# Python
export PATH=$HOME/bin:$PATH:/opt/python/bin

# Ruby
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Neovim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDK / Java
export SDKMAN_DIR="/home/leaheinhorn/.sdkman"
[[ -s "/home/leaheinhorn/.sdkman/bin/sdkman-init.sh" ]] && source "/home/leaheinhorn/.sdkman/bin/sdkman-init.sh"
