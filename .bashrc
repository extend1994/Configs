# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -s "/usr/share/bash-completion/bash_completion" ]; then
    source "/usr/share/bash-completion/bash_completion"
  elif [ -s "/etc/bash_completion" ]; then
    source "/etc/bash_completion"
  elif [ -s "/usr/local/share/bash-completion/bash_completion" ]; then
    source "/usr/local/share/bash-completion/bash_completion"
  elif [ -s "/usr/local/etc/bash_completion" ]; then
    source "/usr/local/etc/bash_completion"
  elif [ -s "/usr/local/etc/bash_completion" ]; then
    source "/usr/local/etc/bash_completion"
  fi
fi

# unalias before myown alias
unalias -a

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# only show closest n directories' full name
PROMPT_DIRTRIM=5

export PATH="~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# set default charset and language
locale=en_US.UTF-8
export LANG=$locale
export LANGUAGE=$locale
export LC_ALL=$locale

# set default editor as vim
export EDITOR=vim

# GPG passphrase input workaround
export GPG_TTY=$(tty)

# some setting which depends on OS
os=$(uname)
if [ "$os" = "FreeBSD" ] || [ "$os" = "Darwin" ];then
  datetime='date +%m/%d@%H:%M:%S'
  alias ls='\ls -F'
  alias free='\freecolor -tm'
  export CLICOLOR='yes'
  export LSCOLORS='gxfxcxdxbxegedabagacad'
else
  datetime='date +%m/%d@%H:%M:%S'
  alias ls='\ls -F --color=auto'
  alias free='\free -h'
  export LS_COLORS='rs=0:di=01;36:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=36;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.iso=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
fi

if [ -e ~/.bash_history ]; then
  # network-related commands or tools which need auto completion
  complete -W "$(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //')" ssh
  complete -W "$(grep '^sftp ' ~/.bash_history | sort -u | sed 's/^sftp //')" sftp
  complete -W "$(grep '^ping ' ~/.bash_history | sort -u | sed 's/^ping //')" ping
  complete -W "$(grep '^dig ' ~/.bash_history | sort -u | sed 's/^dig //')" dig
  complete -W "$(grep '^telnet ' ~/.bash_history | sort -u | sed 's/^telnet //')" telnet
  complete -W "$(grep '^mosh ' ~/.bash_history | sort -u | sed 's/^mosh //')" mosh
  complete -W "$(grep '^xfreerdp ' ~/.bash_history | sort -u | sed 's/^xfreerdp //')" xfreerdp
fi

# git auto completion
if [ -e ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

function repeat() {
  i=$1
  shift
  for n in $(seq "$i")
  do
      $@
  done
}

function man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;36m' \
  man "$@"
}

function returncode() {
  returncode=$?
  if [ $returncode != 0 ]; then
    echo "[$($datetime) $returncode]"
  else
    echo ""
  fi
}

function parse_git_branch() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ ! "${BRANCH}" == "" ]
  then
    STAT=$(parse_git_dirty)
    echo "(${BRANCH}${STAT})"
  else
    echo "()"
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=$(git status 2>&1 | tee)
  dirty=$(echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?")
  untracked=$(echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?")
  ahead=$(echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?")
  newfile=$(echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?")
  renamed=$(echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?")
  deleted=$(echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?")
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

function enable-prompt-color() {
  #\h is localhost machine name
  if [[ ${EUID} == 0 ]] ; then #root
    PS1='${debian_chroot:+($debian_chroot)}\[\e[1;91m\]\h\[\e[1;96m\] '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\e[1;38;5;208m\]\u \[\e[0;37m\]at \[\e[1;38;5;33m\]\h '
    #with bg
    #PS1='${debian_chroot:+($debian_chroot)}\[\e[0;30;44m\]\u\[\e[0;34;102m\]\[\e[30;102m\] \w \[\e[92;103m\]\[\e[30;103m\]$(parse_git_branch)\[\e[93;40m\] \[\e[01;31m\]$(returncode)\[\e[0;37m\]'
  fi
  PS1+='\[\e[0;37m\]in \[\e[1;38;5;34m\]\w '
  PS1+='\[\e[1;38;5;220m\]$(parse_git_branch) '
  PS1+='\[\e[0;37m\]now \[\e[1;38;5;6m\]\t'
  PS1+='\n>\[\e[00m\] \[\e[01;31m\]$(returncode)\[\e[0;37m\]'
}

function disable-prompt-color() {
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u@\h \W \$ $(returncode)'
    else
        PS1='\u@\h \w \$ $(returncode)'
    fi
}

enable-prompt-color

if [ -r ~/.colorEcho ]; then
  source ~/.colorEcho
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
