# Startup --------------------------------------------------------------- {{{

shuf -n 1 ~/dev-tips.txt | cowsay -f tux

# }}}

# Source files --------------------------------------------------------------- {{{

source ~/.sensitive

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
alias kipgql='cd ~/Development/code/KIP-Create-API/graphql_api'

alias chrome='google-chrome-stable'

alias vim='nvim'
alias cat='bat'

# Add "alert" for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias for activating a virtual environment
alias va='source venv/bin/activate'

# Alias for copy / paste from terminal
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Docker Aliases
# Clean docker dangling images
alias docker-clean='docker rmi --force $(docker images -a --filter=dangling=true)'
alias docker-stop='docker stop $(docker ps -a -q)'

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

# Completion :) ---------------------------------------------------------- {{{

zmodload zsh/complist
autoload -Uz compinit
compinit

# }}}

# Plugins :) ---------------------------------------------------------- {{{

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "paulirish/git-open", as:plugin

zplug load
# }}}

# Scripts ---------------------------------------------------------- {{{

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# }}}

# Prompt  ---------------------------------------------------------- {{{

autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr '%B%F{yellow}'
zstyle ':vcs_info:*' unstagedstr '%B%F{red}'
zstyle ':vcs_info:*' check-for-changes true


zstyle ':vcs_info:*' actionformats \
  '%F{magenta}[%F{green}%b%F{yellow}|%F{red}%a%F{magenta}]%f '
zstyle ':vcs_info:*' formats \
  '%F{cyan}[%F{green}%b%m%F{cyan}] %F{green}%c%F{yellow}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-color git-st git-untracked git-unpushed
zstyle ':vcs_info:*' enable git

function +vi-git-color() {
  local git_status="$(git status 2> /dev/null)"
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  local git_commit="$(git --no-pager diff --stat origin/${branch} 2>/dev/null)"
  if [[ $git_status == "" ]]; then
    hook_com[branch]="%B%F{cyan}${hook_com[branch]}"
  elif [[ ! $git_status =~ "working tree clean" ]]; then
    hook_com[branch]="%B%F{red}${hook_com[branch]}"
  elif [[ $git_status =~ "Your branch is ahead of 'origin/$branch'" ]] || \
    [[ -n $git_commit ]]; then
    hook_com[branch]="%B%F{yellow}${hook_com[branch]}"
  elif [[ $git_status =~ "nothing to commit" ]] && \
    [[ ! -n $git_commit ]]; then
    hook_com[branch]="%B%F{green}${hook_com[branch]}"
  else
    hook_com[branch]="%B%F{orange}${hook_com[branch]}"
  fi
}

# Show untracked files
function +vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --others --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ||
  [[ $(git status 2> /dev/null) == *"Untracked files"* ]]; then
    hook_com[unstaged]+='%B%F{red}'
  fi
}

# Show unpushed commits
function +vi-git-unpushed() {
  local git_status="$(git status 2> /dev/null)"
  local branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
  local git_diff_origin="$(git --no-pager diff --stat origin/${branch} 2>/dev/null)"
  local git_unpushed_commit="$(git log --branches --not --remotes 2>/dev/null)"
  if [[ -n $git_unpushed_commit ]]; then
    hook_com[unstaged]+='%B%F{yellow}'
  elif [[ $git_status =~ "working tree clean" ]]; then
    if [[ -n $git_diff_origin ]] || \
      [[ $git_status =~ "Your branch is ahead of 'origin/$branch'" ]]; then
      hook_com[unstaged]+='%B%F{yellow}'
    else
      # do nothing
    fi
  else
    # do nothing
  fi
}

# Show remote ref name and number of commits ahead-of or behind
function +vi-git-st() {
  local ahead behind remote
  local -a gitstatus

  # Are we on a remote-tracking branch?
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
    --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  if [[ -n ${remote} ]] ; then
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    (( $ahead )) && gitstatus+=( "${c3}+${ahead}${c2}" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
    (( $behind )) && gitstatus+=( "${c4}-${behind}${c2}" )

    hook_com[branch]="${hook_com[branch]} [${(j:/:)gitstatus}]"
  fi
}

function precmd() { vcs_info }

# enable functions to operate in PS1
setopt PROMPT_SUBST

PS1=${(j::Q)${(Z:Cn:):-$'
  %F{cyan}[%f
  %(!.%F{red}%n%f.%F{blue}%n%f)
  %F{cyan}@%f
  %F{blue}%M%f
  %F{cyan}][%f
  %F{blue}%~%f
  %F{cyan}]%f
  \$vcs_info_msg_0_
  "\n"
  %F{white}%K{blue}%*%k%f
  " "
  %F{red}♥ %f
  " "
  %B %F{blue}//%f %b
  " "
'}}


# }}}

# Path  ---------------------------------------------------------- {{{

# Python
export PATH=$HOME/bin:$PATH:/opt/python/bin


# Neovim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# SDK / Java
export SDKMAN_DIR="/home/leah/.sdkman"
[[ -s "/home/leah/.sdkman/bin/sdkman-init.sh" ]] && source "/home/leah/.sdkman/bin/sdkman-init.sh"

# }}}
