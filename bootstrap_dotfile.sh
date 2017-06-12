#!/bin/bash

# TODO Update docs

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



IGNORELIST=".git .DS_Store .happypack";

# @pram1 = list
# @pram2 = item
function list_contains_item() {
  local list="$1"
  local item="$2"
  # Pattern match 'item' in 'list'
  if [[ $list =~ (^|[[:space:]])"$item"($|[[:space:]]) ]] ; then
    result=0
  else
    result=1
  fi
  return $result
}


# Find all dot files in ~/dotfiles
function updateLinks() {
  list_dotfiles=`find . -maxdepth 1 -name ".?*"`
  for dotfile in $list_dotfiles; do
      dotfile=`basename $dotfile`
      # Ignore linking certain files
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
