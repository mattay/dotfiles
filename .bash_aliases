#-------------------------------------------------------------
# The 'ls' family
#-------------------------------------------------------------

# Add color to ls based on OS type
case $OSTYPE in
  darwin* )
    # Filetype recognition, Coloured
    alias ls="ls -G"
  ;;
  linux-gnu )
    # natural sort of (version) numbers, Coloured, Date format, dirs first
    # alias ls='ls -v --color=always --time-style=long-iso --group-directories-first' 
    alias ls="ls --color=auto"
  ;;
esac

alias ll="ls -lhA"                        # List format, Human readable file size, show hidden files
alias la='ls -lA'                         # List format, show hidden files
alias lk='ls -lSr'                        # List format, sort by size, biggest last
alias lc='ls -ltcr'                       # List format, sort by and show change time, most recent last
alias lu='ls -ltur'                       # List format, sort by and show access time, most recent last
alias lt='ls -ltr'                        # List format, sort by date, most recent last
alias l="ls -lh"                          # List format, Human readable file size
alias llg='ls --group-directories-first'  # List format,  group directories before files


# always ask:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'	# make parents if required
alias up="cd .."        # change up a directory

# Catch some of my most common typos
alias cd..='cd ..'
alias ls-l='ls -l'

# host-specific settings
case `hostname` in
  
  name)
    ;;
esac
