# http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

CURRENT_BG='NONE'

# Special Powerline characters

() {
  local LC_ALL='' LC_CTYPE='en_US.UTF-8'
  SEGMENT_SEPARATOR=$'\uE0B0'
}

## Begin segment
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

## End segment
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}


# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
  fi
}

prompt_root() {
  prompt_segment black blue "\uF118"
}

## Directory
prompt_dir() {
  local dir
  
  # dir="${dir}%4(c:...:)%3c"
  dir="${PWD/#$HOME/~}"

  prompt_segment 240 blue $dir
}


## Ruby
prompt_ruby() {
  local prompt_text
  
  if (( $+commands[rbenv] )); then
    current_ruby() {
      echo "$(rbenv gemset active 2&>/dev/null | sed -e 's/ global$//')"
    }
    
    if [[ -n $(current_ruby) ]]; then
      prompt_text="$(rbenv version | sed -e 's/ (set.*$//')"@"$(current_ruby)"
    else
      prompt_text="$(rbenv version | sed -e 's/ (set.*$//')"
    fi
    
    prompt_segment 238 red $prompt_text
  fi
}


## Git

prompt_git() {

  local ref dirty mode repo_path sha behind ahead current_branch
  
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    
    ref=$(git symbolic-ref HEAD 2> /dev/null)
    
    current_branch="${ref#refs/heads/}"

    if [[ -n "$(command git rev-list origin/${current_branch}..HEAD 2> /dev/null)" ]]; then
      ahead='\uF431 '
    fi

    if [[ -n "$(command git rev-list HEAD..origin/${current_branch} 2> /dev/null)" ]]; then
      behind='\uF433 '
    fi
    
    if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
      prompt_segment 237 yellow
    else
      prompt_segment 237 green
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi
    
    _sha=$(git rev-parse --short HEAD 2> /dev/null)
    
    if [ -n "$_sha" ]; then
      sha=" \uF417 $_sha "
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '\uF458'
    zstyle ':vcs_info:*' unstagedstr '\uF45A'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    
    echo -n "${ahead}${behind}${current_branch}${vcs_info_msg_0_%%}${mode}${sha}"
  fi
}


## Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment blue black "(`basename $virtualenv_path`)"
  fi
}


## Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  # prompt_status
  prompt_root
  prompt_virtualenv
  # prompt_context
  prompt_dir
  prompt_ruby
  prompt_git
  prompt_end
}

PROMPT=$'\n%{%f%b%k%}$(build_prompt)\n$ '
