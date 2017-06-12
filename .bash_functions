
# stylings for bash prompts
# -- Uses .bash_colours
STYLE_RESET=$Colour_Off

STYLE_HOST=$BWhite
STYLE_BRANCH=$On_Green

# Set of functions for Showing Git statuses
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Shows which git branch you are in.
function _get_git_branch(){
    git_branch_name=`git symbolic-ref -q HEAD --short 2>/dev/null`
    if [[ -n $git_branch_name ]]; then
      echo " ${STYLE_BRANCH} $git_branch_name ${STYLE_RESET}"
    fi
}

# TODO clean up for my own use
_show_git_status() {
  # Get the current git branch and colorize to indicate branch state
  # branch_name+ indicates there are stash(es)
  # branch_name? indicates there are untracked files
  # branch_name! indicates your branches have diverged
  local unknown untracked stash clean ahead behind staged dirty diverged
  unknown='0;34'      # blue
  untracked='0;32'    # green
  stash='0;32'        # green
  clean='0;32'        # green
  ahead='0;33'        # yellow
  behind='0;33'       # yellow
  staged='0;96'       # cyan
  dirty='0;31'        # red
  diverged='0;31'     # red

  if [[ $TERM = *256color ]]; then
    unknown='38;5;20'     # dark blue
    untracked='38;5;76'   # mid lime-green
    stash='38;5;76'       # mid lime-green
    clean='38;5;82'       # brighter green
    ahead='38;5;226'      # bright yellow
    behind='38;5;142'     # darker yellow-orange
    staged='38;5;214'     # orangey yellow
    dirty='38;5;202'      # orange
    diverged='38;5;196'   # red
  fi

  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    if [[ "$branch" == 'HEAD' ]]; then
      branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi
    git_status=$(git status 2> /dev/null)
    # If nothing changes the color, we can spot unhandled cases.
    color=$unknown
    if [[ $git_status =~ 'Untracked files' ]]; then
      color=$untracked
      branch="${branch}?"
    fi
    if git stash show &>/dev/null; then
      color=$stash
      branch="${branch}+"
    fi
    if [[ $git_status =~ 'working directory clean' ]]; then
      color=$clean
    fi
    if [[ $git_status =~ 'Your branch is ahead' ]]; then
      color=$ahead
      branch="${branch}>"
    fi
    if [[ $git_status =~ 'Your branch is behind' ]]; then
      color=$behind
      branch="${branch}<"
    fi
    if [[ $git_status =~ 'Changes to be committed' ]]; then
      color=$staged
    fi
    if [[ $git_status =~ 'Changed but not updated' ||
          $git_status =~ 'Changes not staged'      ||
          $git_status =~ 'Unmerged paths' ]]; then
      color=$dirty
    fi
    if [[ $git_status =~ 'Your branch'.+diverged ]]; then
      color=$diverged
      branch="${branch}!"
    fi
    echo -n "\[\033[${color}m\]${branch}\[\033[0m\]"
  fi
  return 0
}



function prompter () {
  PS1="\d \t" # Date, time
  #PS1+="\u@${STYLE_HOST}\h${STYLE_RESET}" # user, @, Host name
  PS1+="$(_get_git_branch)" # Highlight Git branch if in a repository
  PS1+=" \W $ "  # Working Directory
}
