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
alias gps='git push'
alias gd='git df'
alias gco='git checkout'
alias gb='git branch'
alias gsp='git stash pop'
alias gu='git update-index --assume-unchanged'
alias gnou='git update-index --no-assume-unchanged'
alias gulist="git ls-files -v|grep '^h'"
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
gcma()  { git commit -m "add: $*"; }      # add
gcmr()  { git commit -m "remove: $*"; }   # remove
gcmc()  { git commit -m "chore: $*"; }    # chore
gcmf()  { git commit -m "fix: $*"; }      # fix
gcmhf() { git commit -m "hotfix: $*"; }   # hotfix
gcmrl() { git commit -m "release: $*"; }  # release
gcmrf() { git commit -m "refactor: $*"; } # refactor
gcmw()  { git commit -m "wip: $*"; }      # wip

# Ruby / Rails
alias be='bundle exec'
alias migrate='rake db:migrate db:test:clone'
alias rake='noglob rake'
alias rc='rails c'
alias rg='rails g'
alias rspec='rspec --color --format doc'
alias rst='touch tmp/restart.txt'
alias rs='bundle exec rails s -b 0.0.0.0'
alias annotate='bundle exec annotate --exclude tests,fixtures,factories --position after'

# OSX
alias flushdnscache='dscacheutil -flushcache'
alias rmdsstores='sudo find ~/ -name .DS_Store -exec rm {} \;'
alias updatedb='sudo /usr/libexec/locate.updatedb'

# Misc
alias e='atom .'
alias nginxr='nginx -s reload'
alias nginxs='nginx -s stop'
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias powrst='touch ~/.pow/restart.txt'
alias pow-install='curl get.pow.cx | sh'
alias pow-remove='curl get.pow.cx/uninstall.sh | sh'
alias tlf='tail -f'
alias tlfd='tail -f log/development.log'
alias redisstart='redis-server /usr/local/etc/redis.conf'
alias sidekiqstart='bundle exec sidekiq -C config/sidekiq.yml'

# Make sudo understand aliases
alias sudo='sudo '
