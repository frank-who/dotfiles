# Movement
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias cl='clear'
alias cp='cp -iv'
alias l='ls -lh'
alias la='ls -Alh'
alias lh='ls -Alt | head'
alias mv='mv -iv'
alias rm='rm -iv'

# zsh
alias reload!='. ~/.zshrc'

# Git
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcnm='git commit -n -m'
alias gco='git checkout'
alias gdf='git diff --color | diff-so-fancy'
alias gl='git lg'
alias gpl='git pull --prune'
alias gps='git push origin HEAD'
alias gs='git status -sb'
alias gst='git stash'
alias gstp='git stash pop'

gcma()   { git commit -m "add: $*"; }      # add
gcmr()   { git commit -m "remove: $*"; }   # remove
gcmc()   { git commit -m "chore: $*"; }    # chore
gcmf()   { git commit -m "fix: $*"; }      # fix
gcmhf()  { git commit -m "hotfix: $*"; }   # hotfix
gcmrl()  { git commit -m "release: $*"; }  # release
gcmrf()  { git commit -m "refactor: $*"; } # refactor
gcmw()   { git commit -m "wip: $*"; }      # wip
gcms()   { git commit -m "stash: $(date +%Y-%m-%d--%H:%M)"; } #stash
gcnms()  { git commit -n -m "stash: $(date +%Y-%m-%d--%H:%M)"; } #stash

# Ruby / Rails
alias be='bundle exec'
alias migrate='rake db:migrate db:test:clone'
alias opencov='open coverage/index.html'
alias powrst='touch ~/.pow/restart.txt'
alias rake='noglob rake'
alias rce="EDITOR='atom --wait' rails credentials:edit"
alias rspec='rspec --color --format doc'
alias rst='touch tmp/restart.txt'
alias tlf='tail -f'
alias tlfd='tail -f log/development.log'
alias tlfp='tail -f log/production.log'
alias tlft='tail -f log/test.log'

# OSX
alias flushdnscache='dscacheutil -flushcache'
alias rmdsstores='sudo find ~/ -name .DS_Store -exec rm {} \;'
alias updatedb='sudo /usr/libexec/locate.updatedb'

# Misc
alias bb='brew bundle'
alias e='atom .'
alias ctags="`brew --prefix`/bin/ctags"
alias cca="codeclimate analyze"

# Make sudo understand aliases
alias sudo='sudo '
