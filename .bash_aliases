alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cat=batcat                                            # Fancier cat
alias rttlog='systemctl --user restart rttlog'              # RTTlogger service

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

