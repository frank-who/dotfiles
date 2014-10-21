# Movement
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

# Listing
alias cl='clear'
alias l='ls -lh'
alias la='ls -Alh'
alias lh='ls -Alt | head'

# cp/mv/rm/kill
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias k9='kill -9'
alias ka9='killall -9'

# zsh stuff
alias reload!='. ~/.zshrc'

# Git
alias gs='git st'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gd='git df'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gbr='git branch -r'
alias gsm='git submodule'
alias gsma='git submodule add'
alias gsmi='git submodule init'
alias gsmu='git submodule update'
alias gsh='git stash'
alias gsp='git stash pop'
alias gu='git update-index --assume-unchanged'
alias gnou='git update-index --no-assume-unchanged'
alias gulist="git ls-files -v|grep '^h'"

# Ruby / Rails
alias be='bundle exec'
alias migrate='rake db:migrate db:test:clone'
alias rake='noglob rake'
alias rc='rails c'
alias rdl='tail -f log/development.log'
alias rg='rails g'
alias rspec='rspec --color --format doc'
alias rst='touch tmp/restart.txt'

# OSX
alias flushdnscache='dscacheutil -flushcache'
alias rmdsstores='sudo find ~/ -name .DS_Store -exec rm {} \;'
alias updatedb='sudo /usr/libexec/locate.updatedb'

# Misc
alias e='subl -n .'
alias mvi='mvim'
alias nginxr='nginx -s reload'
alias nginxs='nginx -s stop'
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias powrst='touch ~/.pow/restart.txt'
alias pow-install='curl get.pow.cx | sh'
alias pow-remove='curl get.pow.cx/uninstall.sh | sh'
alias tlf='tail -f'
alias tlfd='tail -f log/development'
alias redisstart='redis-server /usr/local/etc/redis.conf'
alias annotate='bundle exec annotate --exclude tests,fixtures,factories --position after'

# Make sudo understand aliases
alias sudo='sudo '
