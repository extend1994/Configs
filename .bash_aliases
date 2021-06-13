alias l='ls -CF'
alias l.='ls -d .*'
alias ll='ls -lh'
alias la='ls -A'
alias lal='ls -lha'

alias rm='rm -i'
alias rmf='rm -rf'

alias grep='\grep --color=auto'
alias fgrep='\fgrep --color=auto'
alias egrep='\egrep --color=auto'

# network tools
alias p='ping'
alias d='dig'
alias t='mtr'
alias ssh='ssh -v'

alias apt='sudo apt -qq'
alias apt-get='sudo -qq apt-get'
alias apti='sudo apt -qq install'
alias apty='sudo apt -qq install -y'
alias upd='sudo apt -qq update'
alias upg='sudo apt -qq upgrade'
alias updl='apt list --upgradable'
alias list='apt list'

alias cd..='\cd ..'
alias cd...='\cd ../..'
alias ..='\cd ..'
alias ...='\cd ../..'
alias ....='\cd ../../..'
alias .....='\cd ../../../..'
alias .3='\cd ../../..'
alias .4='\cd ../../../..'
alias .5='\cd ../../../../..'

# mix alias
# force tmux to assume the terminal supports 256 colours.
alias tmux='\tmux -2'
# enable to copy terminal standard output
alias copy='xclip -sel clip'
# load user environment variables/settings with sudo permission
alias sudo='\sudo -E'
# enable highlight in less
alias less='\less -R'
# enable color
alias tree='\tree -C'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias svi='sudo vim'
alias du='\du -h'
alias df='\df -hT'
alias wgetncc='wget --no-check-certificate'
alias lnvm='. ~/.nvm/nvm.sh && . ~/.nvm/bash_completion' # load nvm
alias diff='colordiff'
alias preview="fzf --preview 'bat --color \"always\" {}'"
# cdnjs related tools
alias mini='~/repos/web-minify-helper/minify.sh'
alias vsp='vim ~/repos/cdnjs/.git/info/sparse-checkout'
alias grun='~/repos/autoupdate/autoupdate.js run'
alias run='~/repos/cdnjs/auto-update.js run'
alias view='~/repos/Tools/cdnjs/view.sh'
alias vc='~/repos/Tools/cdnjs/versionCompare.sh'
