#!/bin/bash

# To set up centrally managed common $HOME dotfiles in Subversion...
# 1a) Create a directory ~/dotfiles or similar
# 1b) Copy desired common files to ~/dotfiles
# 1c) svn add ~/dotfiles
# 2) cd ~/dotfiles
# 3) Replace $HOME dotfiles with symlinks to versioned files in working copy:


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

#find all dot files in ~/dotfiles
dot_files=`find . -maxdepth 1 -name "dot.*"`
for dot in $dot_files; do 
    non_dot=`basename $dot`; 
    dot=${non_dot/dot/};
    if [[ ! -L $HOME/$dot ]]; then
        # make copy of original dot file
        if [[ -f $HOME/$dot ]]; then
            mv -v $HOME/$dot $HOME/$dot.old;
        fi
        # create soft link to repositry dot file.
        ln -vs `pwd`/$non_dot  $HOME/$dot;
    fi
done

# 4) On login, svn update ~/dotfiles

# After initial setup above, replicate to other machines with:
# 1) svn co dotfile/repo/location ~/dotfiles
# 2)... etc. as above.


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


