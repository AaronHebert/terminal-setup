export EDITOR="atom --wait"
#export BUNDLER_EDITOR="subl"
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="bureau"
ZSH_THEME="bullet-train"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby rails)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/opt/postgresql@9.6/bin:/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/elasticsearch@2.4/bin"
#export PATH="$PATH:/Users/ahebert/.rvm/gems/ruby-2.0.0-p247@homeroom/bin:/Users/ahebert/.rvm/gems/ruby-2.0.0-p247@global/bin:/Users/ahebert/.rvm/rubies/ruby-2.0.0-p247/bin:/Users/ahebert/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

CRUNCH_DIR_="$CRUNCH_DIR_COLOR%~\$(git_prompt_info) "
CRUNCH_PROMPT="$CRUNCH_BRACKET_COLOR➭ "

# START theme prompt override
CRUNCH_BRACKET_COLOR="%{$fg[white]%}"
CRUNCH_DIR_COLOR="%{$fg[cyan]%}"
CRUNCH_GIT_BRANCH_COLOR="%{$fg[green]%}"
CRUNCH_GIT_CLEAN_COLOR="%{$fg[green]%}"
CRUNCH_GIT_DIRTY_COLOR="%{$fg[red]%}"

#PROMPT="$CRUNCH_DIR_$CRUNCH_PROMPT%{$reset_color%}"
# END theme prompt override

# custom stuff
alias chrome-sso='open -a "google chrome.app" --args --disable-web-security'

# deis
alias deis-dev="DEIS_PROFILE=~/.deis/dev.json deis"
alias deis-prod="DEIS_PROFILE=~/.deis/prod.json deis"
alias deis-lt="DEIS_PROFILE=~/.deis/lt.json deis"

# efapps
alias efapps-dev="DEIS_PROFILE=dev efapps"
alias efapps-prod="DEIS_PROFILE=prod efapps"
alias efapps-lt="DEIS_PROFILE=lt efapps"

# rage
alias fuck-adminifi="kill -9 $(lsof -i :3001 | awk '{print $2}'); echo '(┛ò__ó)┛彡 ᴉɟᴉuᴉɯpɐ'"

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# make ls display colors, reinforce with CLICOLOR and LSCOLORS
export CLICOLOR=1

# LSCOLORS order: DIR, SYM_LINK, SOCKET, PIPE, EXE, BLOCK_SP
# CHAR_SP, EXE_SUID, EXE_GUID, DIR_STICKY, DIR_WO_STICKY
# a = black, b = red, c = green, d = brown, e = blue,
# f = magenta g = cyan, h = light gray, x = default
# lowercase is bold
export LSCOLORS=gxex

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# iTerm2 window/tab color commands
#   Requires iTerm2 >= Build 1.0.0.20110804
#   http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "production|ec2-.*compute-1" ]]; then
            tab-color 255 0 0
        else
            tab-color 0 255 0
        fi
    fi
    ssh $*
}
compdef _ssh color-ssh=ssh
alias ssh=color-ssh

######## CUSTOM FUNCTIONS

# function battlenet() {
#   if [[ "$1" = "on" ]] then
#     COMMAND="sudo ipfw del 1 deny tcp from any to any 1119"
#     eval $COMMAND
#     echo $fg[green] "Battle.net port 1119 enabled!"
#   fi
#
#   if [[ "$1" = "off" ]] then
#     COMMAND="sudo ipfw add 1 deny tcp from any to any 1119"
#     eval $COMMAND
#     echo $fg[red] "Battle.net port 1119 disabled!"
#   fi
# }

function reset_trap {
  trap - INT
}

function bundle_v() {
  BUNDLEVERSION=$(tail -n -1 Gemfile.lock | tr -d '[:space:]')
  echo "---Running bundler with version ${BUNDLEVERSION} from Gemfile.lock---"
  bundler _"${BUNDLEVERSION}"_ "$@"
  echo "---Ran bundler with version ${BUNDLEVERSION}---"
}

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# ARCHEY
archey --color
