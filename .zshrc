# Startup --------------------------------------------------------------- {{{

echo "<<< take a step back >>>" | lolcat

# }}}

# History {{{
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
# }}}

# Environment Variables {{{

# Vault
export VAULT_ADDR='https://vault.keplergrp.com:8200/'

# Python Virtual Env
export PIPENV_VENV_IN_PROJECT='yes'

export VISUAL=nvim
export EDITOR="nvim"
# }}}

# Colors --------------------------------------------------------------- {{{

LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

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

unset color_prompt force_color_prompt


# }}}

# Keybindings ---------------------------------------------------------- {{{
bindkey -v
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

# }}}

# Aliases ---------------------------------------------------------- {{{

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# cd Aliases
alias code='cd ~/Development/code/'
alias scripts='cd ~/Development/scripts/'
alias kipcreate='cd ~/Development/code/KIP-Create-API/create_api'
alias kipplaybook='cd ~/Development/code/KIP-Create-API/playbook_api'

alias chrome='google-chrome-stable'

alias vim='nvim'

# Add "alert" for long running commands.  Use like so: sleep 10; alert
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

#  }}}

# Functions ---------------------------------------------------------- {{{

# Check if it's raining in NYC
raining() {
  local raining="$(curl -s wttr.in/nyc | grep -c Rain )"
  if [[ $raining = 0 ]]; then
    echo "No rain coming down!"
  else
    echo "Looks like rain :("
  fi
}

git_color() {
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

git_branch() {
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

# }}}

# Completion :) ---------------------------------------------------------- {{{

zmodload zsh/complist
autoload -Uz compinit
compinit

# }}}

# Prompt  ---------------------------------------------------------- {{{

autoload -U colors zsh/terminfo
colors

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

PROMPT=${(j::Q)${(Z:Cn:):-$'
  %F{cyan}[%f
  %(!.%F{red}%n%f.%F{green}%n%f)
  %F{cyan}@%f
  %F{green}%M%f
  %F{cyan}][%f
  %F{blue}%~%f
  %F{cyan}]%f
  %(!.%F{red}%#%f.%F{green}%#%f)
  " "
'}}


# PS1_DIR="\[$BOLD\]\[$COLOR_BLUE\]\u@\h \[$BOLD\]\[$COLOR_PURPLE\][\w] "
# PS1_GIT="\[\$(git_color)\]\[$BOLD\]\$(git_branch)\[$BOLD\]\[$COLOR_RESET\]"
# PS1_END="\n\[$COLOR_GRAY_TEXT_BACKGROUND\]\t\[$COLOR_RED $BOLD\]♥ \[$COLOR_BLUE\]// \[$COLOR_RESET\]"

# }}}

# Path  ---------------------------------------------------------- {{{

# pyenv
export PATH="/home/leaheinhorn/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Python
export PATH=$HOME/bin:$PATH:/opt/python/bin

# Ruby
# Add RVM to PATH for scripting.
export PATH="$PATH:$HOME/.rvm/bin"

# Neovim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDK / Java
export SDKMAN_DIR="/home/leaheinhorn/.sdkman"
[[ -s "/home/leaheinhorn/.sdkman/bin/sdkman-init.sh" ]] && source "/home/leaheinhorn/.sdkman/bin/sdkman-init.sh"

# }}}
