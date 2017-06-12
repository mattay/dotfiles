# ~/.bashrc: executed by bash(1) for non-login shells.

# Source bash configs if they can be found.
[ -f ~/.bash_colours ]      && . ~/.bash_colours
[ -f ~/.bash_functions ]    && . ~/.bash_functions
[ -f ~/.bash_aliases ]      && . ~/.bash_aliases


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#               User Environment
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export EDITOR=vim
export CLICOLOR=1;
export TERM=xterm-256color
export EMAIL=matthew.anderson


# umask 022
# OS specific stuff:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
case $OSTYPE in
  # If running on an MacOS X
  darwin*)
    #export LS_COLORS=Gxfxcxdxcxegedabagacad
    #export PATH="/usr/local/Cellar/perl/5.20.2/bin:$PATH"
    ;;
esac


# Host-specific settings
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Default host colour - Should be hidious
HOSTCOLOUR=$On_IRed

case `hostname` in
  #My laptops
  [Mm]atthews*)
    HOSTCOLOUR=$BWhite
    ;;

esac


# Set PS1 prompt
PROMPT_COMMAND=prompter
