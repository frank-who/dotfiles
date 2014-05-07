# Default prompt
PS1='%n@%m:%~%# '

# ls colors
autoload colors && colors
export LSCOLORS='exfxcxdxbxegedabagacad'
export CLICOLOR=true
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

fpath=($ZSH/zsh/functions $fpath)
autoload -U $ZSH/zsh/functions/*(:t)

# Directories
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

# Color grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt prompt_subst

# Misc
export LC_CTYPE=$LANG
