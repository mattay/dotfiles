# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# Source bash configs if they can be found.
[ -f ~/.bash_colours ]      && . ~/.bash_colours
[ -f ~/.bash_functions ]    && . ~/.bash_functions
[ -f ~/.bash_aliases ]      && . ~/.bash_aliases


##############################################################
#               User Environment
##############################################################
export EDITOR=vim
export CLICOLOR=1;
export TERM=xterm-256color
export EMAIL=matthew.anderson

# OS specific stuff:
case $OSTYPE in
  # If running on an OSX box (my laptop)
  darwin*)
    #export LS_COLORS=Gxfxcxdxcxegedabagacad
    #export PATH="/usr/local/Cellar/perl/5.20.2/bin:$PATH"  
	;;
esac

# # #
# #     host-specific settings
#
# Default host colour - Should be hidious
HOSTCOLOUR=$On_IRed

case `hostname` in
  
  #My laptops  
  [Mm]atthews*)
    HOSTCOLOUR=$BWhite
    ;;
  # Desktop at TRI
  bioinform*)
    HOSTCOLOUR=$BWhite

    #mount_Tdrive
    #export PBSHOME=/media/TRI-T-DRIVE-manderson/uq/uqdi/HPC/PBSHOME/manderson
    #export UQCCG_HOME=~
    #export UQCCG_ILLUMINA_PIPELINE=${UQCCG_HOME}/Development/UQCCG_Production/illumina_pipeline/master
    #export UQCCG_TEMPLATES=${UQCCG_HOME}/Development/UQCCG_Libraries/templates
    # CPAN
    #export PERL_MB_OPT="--install_base \"/home/manderson/perl5\"";
    #export PERL_MM_OPT="INSTALL_BASE=/home/manderson/perl5";		
    #export VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper.sh"
    ;;


  # DI Cluster
  di-cluster* | di-ccn[0-9][0-9]*)
    HOSTCOLOUR=$BBlue
    umask 0002

    # UQCCG_HISEQ
    #if [[ -d /mnt/HISEQ && ! $UQCCG_HISEQ ]]; then
    #  export UQCCG_HISEQ=/mnt/HISEQ
    #fi

    # Add pbs applications to environment variable PATH
    #export PATH=$PATH:/opt/pbs/default/bin:/opt/pbs/default/sbin
    #export PATH=$PATH:/usr/local/PBSHOME
		# Add pbs docs to environment variable MANPATH
    #export MANPATH=$MANPATH:/opt/pbs/default/man
    ;;


  # TRI Cluster
  trident* )
    HOSTCOLOUR=$BYellow
    ;;


  # DI LIMS
  di-lims* )
	HOSTCOLOUR=$BRed
	;;

  # DI MySql
  di-mysql* )
	HOSTCOLOUR=$BRed
	;;


  # UQ Cluster
  barrine* | b[0-9][0-9][ab][0-9][0-9])
    HOSTCOLOUR=$BYellow
    #umask 0002
    ;;

esac


# Set command prompt - date, time, user @ host, working dir
PS1="[\d \t \u@\[$HOSTCOLOUR\]\h\[$Colour_Off\]:\W ] $ "


# Libraries
#export PYTHONPATH=$UQCCG_DEV/UQCCG_Libraries/python
#export   PERL5LIB=$UQCCG_DEV/UQCCG_Libraries/perl

# # #
# #     Python Virtual Environments
#
