export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zdharma/fast-syntax-highlighting", as:plugin, defer:2
zplug "zsh-users/zsh-autosuggestions", as:plugin, defer:2
zplug load

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
