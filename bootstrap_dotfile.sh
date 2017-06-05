#!/bin/bash

# To set up centrally managed common $HOME dotfiles in Subversion...
# 1a) Create a directory ~/dotfiles or similar
# 1b) Copy desired common files to ~/dotfiles
# 1c) svn add ~/dotfiles
# 2) cd ~/dotfiles
# 3) Replace $HOME dotfiles with symlinks to versioned files in working copy:
# 4) On login, svn update ~/dotfiles

# After initial setup above, replicate to other machines with:
# 1) svn co dotfile/repo/location ~/dotfiles
# 2)... etc. as above.




# OS specific stuff:
#case $OSTYPE in
#  darwin*)
#	# OSX
#	find $PWD -maxdepth 1 -name ".*" ! -name ".svn" ! -name "." -print \
#	| xargs -0 -I {} basename {} \
#	| xargs -I {}  bash -c \
#    "if [[ ! -L $HOME/'{}' ]]; then  mv -v $HOME/'{}' $HOME/'{}'.old; ln -vs `pwd`/'{}'  $HOME/'{}'; fi"
#	;;
#
#  linux*)
#	find . -maxdepth 1 -name ".*" ! -name ".svn" ! -name "." -printf %f\\n \
#	|xargs -I {} -i bash -c \
#	"if [[ ! -L $HOME/'{}' ]]; then  mv -v $HOME/'{}' $HOME/'{}'.old; ln -vs `pwd`/'{}'  $HOME/'{}'; fi"
#	;;
#esac

IGNORELIST=".eggs .DS_Store .happypack";

function list_contains_item() {
  local list="$1"
  local item="$2"
  # echo $list $item
  if [[ $list =~ (^|[[:space:]])"$item"($|[[:space:]]) ]] ; then
    # yes, list include item
    result=0
  else
    result=1
  fi
  return $result
}


#find all dot files in ~/dotfiles
function updateLinks() {
  list_dotfiles=`find . -maxdepth 1 -name ".?*"`
  for dotfile in $list_dotfiles; do
      dotfile=`basename $dotfile`
      if ! `list_contains_item "$IGNORELIST" "$dotfile"` && [[ ! -L $HOME/$dotfile ]]; then
          # make copy of original dot file
          if [[ -f $HOME/$dotfile ]]; then
              mv -v $HOME/$dotfile $HOME/$dotfile.old
          fi

          # create soft link to repositry dot file.
          ln -vs `pwd`/$dotfile  $HOME/$dotfile
      fi
  done
}


function updateSSH() {
  #.ssh/config
  SSH_CONFIG=ssh_config
  if [[ -e $SSH_CONFIG ]]; then
  	if [[ ! -L $HOME/.ssh/config ]]; then
   		if [[ -e $HOME/.ssh/config ]]; then
              mv -v $HOME/.ssh/config $HOME/.ssh/config.old
          fi
  		ln -vs `pwd`/$SSH_CONFIG  $HOME/.ssh/config
  	fi
  fi
}


updateLinks
