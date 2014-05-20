# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 " (%s)") $ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.bashed/dircolors-solarized/dircolors.ansi-dark && eval "$(dircolors -b ~/.bashed/dircolors-solarized/dircolors.ansi-dark)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

shopt -s cdspell

# # PATH=$PATH:/opt/lampp/bin:/opt/vagrant/bin:/home/tiger/.bin:/home/tiger/.todo:.cabal-sandbox/bin
# # source /etc/bash_completion.d/password-store
#  
# # ### Added by the Heroku Toolbelt
# # export PATH="/usr/local/heroku/bin:$PATH"
# # 


# # [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
# # 
# # source /usr/share/ruby-rvm/gems/ruby-1.9.2-p180/bin/tmuxinator_completion
# # 
# # eval $(dircolors -b  $HOME/.dir_colors)
# # 
# # export LD_LIBRARY_PATH=/usr/local/lib

if [ -f ~/.completions/git-completion.bash ] && ! shopt -oq posix; then
    . ~/.completions/git-completion.bash
		__git_complete g __git_main
fi

export EDITOR='vim'
set -o vi


# For tmux
if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
	TERM=screen-256color-bce	
fi


# Scripts and local apps
export PATH=$HOME/.bin:$PATH


# Cabal
export PATH=$HOME/.cabal/bin:$PATH


# Virtualenvwrapper
WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh


# Rvm
if [ -f $HOME/.rvm/scripts/rvm ]; then
	source $HOME/.rvm/scripts/rvm
fi


# Nvm
if [ -f $HOME/.nvm/nvm.sh ]; then
	source $HOME/.nvm/nvm.sh
fi


# Git Prompt 
GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bashed/bash-git-prompt/gitprompt.sh
