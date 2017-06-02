# Add color to ls based on OS type
case $OSTYPE in
  darwin* )
    export LS_OPTIONS='-G'
  ;;
  linux-gnu )
    export LS_OPTIONS='--color=auto'
  ;;
esac

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias  l='ls $LS_OPTIONS -lA'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
