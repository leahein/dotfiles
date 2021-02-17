# Source files --------------------------------------------------------------- {{{

source ~/.sensitive

# }}}

# Startup --------------------------------------------------------------- {{{

echo "In progress for today:"
curl "https://api.clubhouse.io/api/v3/search/stories?query=epic:70384%20is:started%20\!is:archived%20owner:leaheinhorn&page_size=10&token=${CLUBHOUSE_TOKEN}" &>/dev/null | jq ".data[] | .name" | cowsay -f tux

# }}}

# Plugins :) ---------------------------------------------------------- {{{

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "paulirish/git-open", as:plugin
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug load
# }}}

# Options --------------------------------------------------------------- {{{

setopt AUTOCD

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

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


# man
export MANWIDTH=79
export MANPAGER="nvim -c 'set ft=man' -"

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
bindkey '^P' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^N' down-line-or-search
bindkey '^[[C' forward-char
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward

# }}}

# Aliases ---------------------------------------------------------- {{{

alias c='clear'

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
alias rocket='cd ~/Development/code/KIP-Rocket'

alias chrome='google-chrome-stable'

# Alias programs to its superior alternative
alias vim='nvim'
alias cat='bat'

# Add "alert" for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias for activating a virtual environment
alias va='source .venv/bin/activate'

# Alias for copy / paste from terminal
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Docker Aliases
# Clean docker dangling images
function drmi_old() {
  while true; do
   read yn\?"Do you wish to remove docker images older than $(date +'%Y-%m-%dT%H:%M:%S' --date='-'$1' days')?"
   case $yn in
     [Yy]* ) break;;
     [Nn]* ) return;;
     * ) echo "Please answer yes or no.";;
   esac
  done
  docker image prune -a --filter "until=$(date +'%Y-%m-%dT%H:%M:%S' --date='-'$1' days')"
}

alias docker-clean='docker rmi --force $(docker images -a --filter=dangling=true)'
alias docker-stop='docker stop $(docker ps -a -q)'
alias dc='USERID=$(id -u) docker-compose'

# VPN
alias aws-vpn='nmcli c up aws'
alias aws-vpnd='nmcli c down aws'

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

# }}}

# Syntax Highlighting :) ------------------------------------------------- {{{

ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=039,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=039,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=039

# }}}

# Prompt  ---------------------------------------------------------- {{{

zstyle :prompt:pure:path color 039
zstyle :prompt:pure:git:branch color 208
zstyle :prompt:pure:git:dirty color 255

zstyle :prompt:pure:prompt:success color 161

PURE_PROMPT_SYMBOL=//


function precmd() { vcs_info }

# }}}

# Completion :) ---------------------------------------------------------- {{{

zmodload zsh/complist

# Add ASDF completion
fpath=(${ASDF_DIR}/completions $fpath)
fpath=(~/.zsh/completion $fpath)

# initialise completions
autoload -Uz compinit
compinit

# }}}

# Direnv  ---------------------------------------------------------- {{{

eval "$(direnv hook zsh)"

# }}}

# Path  ---------------------------------------------------------- {{{

# Python
export PATH=$HOME/bin:$PATH:/opt/python/bin


# Neovim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ASDF
. $HOME/.asdf/asdf.sh

export PATH="$HOME/.asdf/installs/poetry/1.0.0/bin:$PATH"

# }}}
