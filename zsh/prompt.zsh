# http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
# https://github.com/ryanoasis/nerd-fonts#glyph-sets

CURRENT_BG='NONE'

GIT_PROMPT_BRANCH="\uF418"
GIT_PROMPT_AHEAD="%{%F{magenta}%}\uF431NUM "  # up-arrow
GIT_PROMPT_BEHIND="%{%F{magenta}%}\uF433NUM " # down arrow
GIT_PROMPT_MERGING="%{%F{magenta}%}\uF419 "
GIT_PROMPT_UNTRACKED="%{%F{green}%}\uF458 "   # plus
GIT_PROMPT_MODIFIED="%{%F{blue}%}\uF45A "     # circle
GIT_PROMPT_STAGED="%{%F{green}%}\uF42E "      # tick
GIT_PROMPT_COMMIT="%{%F{blue}%}\uF417 SHA "
GIT_PROMPT_DIRTY="%{%F{red}%}"
GIT_PROMPT_CLEAN="%{%F{green}%}"

SEGMENT_SEPARATOR=$'\uE0B0'

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


## Directory
prompt_dir() {
  local DIR
  DIR="${PWD/#$HOME/~}"

  prompt_segment 239 blue $DIR
}


## Ruby
prompt_python() {
  local prompt_text

  if (( $+commands[pyenv] )); then
    prompt_segment 238 yellow "$(pyenv version-name | sed -e 's/ (set.*$//')"
  fi
}


## Python
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

    prompt_segment 238 red "$prompt_text"
  fi
}


## Git Branch
parse_git_branch() {
  git symbolic-ref HEAD 2> /dev/null
}

## Git State
parse_git_state() {

  local GIT_STATE=''

  local SHA="$(git rev-parse --short=7 HEAD 2> /dev/null)"
  if [ -n "$SHA" ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_COMMIT//SHA/$SHA}
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
  fi

  if ! git diff --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
  fi

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
  fi

  if [[ -n $GIT_STATE ]]; then
    echo "$GIT_STATE"
  fi

}


## Git
git_prompt_string() {
  local git_where="$(parse_git_branch)"
  local state

  if [[ -n $(git status --porcelain --ignore-submodules) ]]; then
    state="%{%F{red}%}"
  else
    state="%{%F{green}%}"
  fi

  [ -n "$git_where" ] && echo "${state}$GIT_PROMPT_BRANCH ${state}${git_where#(refs/heads/|tags/)} $(parse_git_state)"
}

prompt_git() {
  if git tag > /dev/null 2>&1; then
    setopt promptsubst
    prompt_segment 237 white "$(git_prompt_string)"
  fi
}


## Status
prompt_status() {
  local symbols
  symbols=()
  if [[ $RETVAL -ne 0 ]]; then
    symbols+=red
  else
    symbols+=241
  fi
  # [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡" # - am I root
  # [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙" # are there background jobs?

  [[ -n "$symbols" ]] && prompt_segment $symbols default " %F{black}%T"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_dir
  if [[ -a ./Gemfile ]]; then
    prompt_ruby
  fi
  if [[ -a ./manage.py ]]; then
    prompt_python
  fi
  prompt_git
  prompt_end
}

PROMPT=$'\n%{%f%b%k%}$(build_prompt)\n$ '
