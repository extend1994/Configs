
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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#append command history instead of overwrite
shopt -s histappend

#unalias all the alias(es) before set anything
unalias -a

#don't save duplicates records and lines started with space in bash history
HISTCONTROL=ignoreboth

#expand the history size
HISTFILESIZE=2000
HISTSIZE=1000

PROMPT_DIRTRIM=5

export PATH="~/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

#set default charset and language
locale=en_US.UTF-8
export LANG=$locale
export LANGUAGE=$locale
export LC_ALL=$locale

#set default editor
export EDITOR=vim

#GPG passphrase input workaround
export GPG_TTY=`tty`

#tmux color issue
alias tmux='\tmux -2'

# some setting which depends on OS
os=`uname`
if [ $os = "FreeBSD" ] || [ $os = "Darwin" ];then
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

###alias###

#ls
alias l='ls -C'
alias ll='ls -lh'
alias la='ls -A'
alias lal='ls -lha'

#grep
alias grep='\grep --color=auto'
alias fgrep='\fgrep --color=auto'
alias egrep='\egrep --color=auto'

#network tool
alias p='ping'
alias n='nslookup'
alias d='dig'
alias t='mtr'
alias ssh='ssh -v'

#cd
alias cd..='\cd ..'
alias cd...='\cd ../..'
alias ..="\cd .."
alias ...="\cd ../.."
alias ....="\cd ../../.."
alias .....="\cd ../../../.."

#other alias
alias c='clear'
alias sudo='\sudo -E'
alias less='\less -R'
alias du='\du -h'
alias df='\df -hT'
alias wgetncc='wget --no-check-certificate'
alias last='\last | less'
alias tree='\tree -C'
alias optipng='\optipng -o7 -zm1-9 -preserve'
alais rm='rm -i'
# For cdnjs env
alias mini='~/repos/web-minify-helper/minify.sh'
alias vsp='vim ~/repos/cdnjs/.git/info/sparse-checkout'

###alias###


if [ -e ~/.bash_history ]; then
# network-related commands or tools which need auto completion
    complete -W "$(echo $(grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //'))" ssh
    complete -W "$(echo $(grep '^sftp ' ~/.bash_history | sort -u | sed 's/^sftp //'))" sftp
    complete -W "$(echo $(grep '^ping ' ~/.bash_history | sort -u | sed 's/^ping //'))" ping
    complete -W "$(echo $(grep '^dig ' ~/.bash_history | sort -u | sed 's/^dig //'))" dig
    complete -W "$(echo $(grep '^telnet ' ~/.bash_history | sort -u | sed 's/^telnet //'))" telnet
    complete -W "$(echo $(grep '^mosh ' ~/.bash_history | sort -u | sed 's/^mosh //'))" mosh
    complete -W "$(echo $(grep '^xfreerdp ' ~/.bash_history | sort -u | sed 's/^xfreerdp //'))" xfreerdp
fi

#git auto completion
if [ -e ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

function repeat()
{
    i=$1
    shift
    for n in $(seq $i)
    do
        $@
    done
}

function man()
{
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;36m' \
    man "$@"
}

function returncode
{
    returncode=$?
    if [ $returncode != 0 ]; then
        echo "[$($datetime) $returncode]"
    else
        echo ""
    fi
}


function enable-prompt-color()
{
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;36m\] \w\[\033[33m\]$(parse_git_branch) \[\033[01;36m\]\$\[\033[00m\] \[\033[01;31m\]$(returncode)\[\033[0;37m\]'
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;36m\] \w\[\033[33m\]$(parse_git_branch) \[\033[01;36m\]\$\[\033[00m\] \[\033[01;31m\]$(returncode)\[\033[0;37m\]'
    fi
}

function disable-prompt-color()
{
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u@\h \W \$ $(returncode)'
    else
        PS1='\u@\h \w \$ $(returncode)'
    fi
}

parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

enable-prompt-color

# automatically enable bash-completion in interactive shells
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

if [ -r ~/.colorEcho ]; then
    source ~/.colorEcho
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_NODEJS_ORG_MIRROR=http://ftp.yzu.edu.tw/nodejs.org-dist
