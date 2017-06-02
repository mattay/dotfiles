# Add color to ls based on OS type
case $OSTYPE in
  darwin* )
    alias ls="ls -G"
  ;;
  linux-gnu )
    alias ls="ls --color=always"
  ;;
esac

alias ll="ls -lA"
alias l="ll "
