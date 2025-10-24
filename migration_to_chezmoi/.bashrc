# Bash config; Not much to see here

export EDITOR=vim
export VISUAL=vim
export TERM="xterm-256color"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# Recommended: ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

if [ "$color_prompt" = yes ]; then
    # cwd above promt character, here I use λ instead of $
    export PS1="\[\033[01;34m\]\w/\[\033[32m\]\[\033[00m\]\[\033[35m\]\$(parse_git_branch)\[\033[00m\]\nλ "
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

############################# Aliaseses ################################
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

############################# KEEP HISRTORY #############################

HISTCONTROL=ignoredups:erasedups
HISTSIZE=50000
HISTFILESIZE=50000

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cdspell
shopt -s cmdhist
shopt -s expand_aliases
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

[ -f "/usr/share/bash-completion/completions/fzf" ] && source "/usr/share/bash-completion/completions/fzf"
[ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ] && source "/usr/share/doc/fzf/examples/key-bindings.bash"

################################# PATHS #################################

if [ -d "$HOME/.bin" ] ;
then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
then PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/personal/bin" ] ;
then PATH="$HOME/personal/bin:$PATH"
fi

if [ -d "/usr/local/go/bin" ] ;
then PATH="/usr/local/go/bin:$PATH"
fi

############################ Lazy SSH #################################
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval $(ssh-agent)
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

############################ dev shit ###################################
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

. "$HOME/.cargo/env"

# fnm
FNM_PATH="/home/$USER/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# ghcup
[ -r "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
