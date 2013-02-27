if (( $+commands[git] )); then
  git="$commands[git]"
else
  git='/usr/bin/git'
fi

git_branch() {
  RQUERY=$(git symbolic-ref HEAD 2> /dev/null) || return
  SQUERY=$(git status 2> /dev/null | tail -n 1)
  BRANCH="${RQUERY#refs/heads/}"
  if [[ $SQUERY == '' ]]; then
    echo
  else
    if [[ $SQUERY =~ ^nothing ]]; then
      echo " on %{$fg_bold[green]%}${BRANCH}%{$reset_color%}" # Clean
    else
      echo " on %{$fg_bold[red]%}${BRANCH}%{$reset_color%}" # Eeeew
    fi
  fi
}

git_status() {
  QUERY=$(git status --porcelain -b 2> /dev/null)
  MARK=''

  if $(echo "$QUERY" | grep '^?? ' &> /dev/null); then
    MARK="%{$fg_bold[green]%}•%{$reset_color%}" # Untracked
  fi

  echo $MARK
}

git_need_push() {
  QUERY=$(git cherry -v @{upstream} 2> /dev/null)
  if [[ $QUERY == '' ]]; then
    echo ' '
  else
    echo "%{$fg_bold[magenta]%}•%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] )); then
    echo "%{$fg[yellow]%}‹$(rbenv version | awk '{print $1}')›%{$reset_color%} "
  else
    echo ''
  fi
}

directory_name() {
  echo "%{$fg_bold[blue]%}${PWD/#$HOME/~}%{$reset_color%}"
}

user_name() {
  echo "%{$fg_bold[yellow]%}%n%{$reset_color%}"
}

host_name() {
 echo "%{$fg_bold[yellow]%}%m%{$reset_color%}"
}

export PROMPT=$'\n$(directory_name)$(git_branch)$(git_status)$(git_need_push)$(ruby_version)\n$ '
#export RPROMPT='$(ruby_version)'

precmd() {
  #title "zsh" "%m" "%55<...<%~"
}

