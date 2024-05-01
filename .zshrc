export ZSH="$HOME/.oh-my-zsh"
export BROWSER="vivaldi"
export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export PATH=$PATH:/home/m57/.spicetify

ZSH_THEME="nanotech"

plugins=(git archlinux zsh-autosuggestions colorize zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

#pacman
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias spsyyu='sudo pacman -Syyu'
alias spr='sudo pacman -R'
alias sprns='sudo pacman -Rns'
alias sprs='sudo pacman -Rs'
alias sprdd='sudo pacman -Rdd'
alias spqo='sudo pacman -Qo'
alias spsii='sudo pacman -Sii'

#aliases
alias snvim='sudo nvim'
alias parupdate='paru -Syyu'
alias parus='paru -S'
alias clock='tty-clock -c -C7 -b -t -n'
alias paruclean='paru -Sc' # remove unused cache
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'

#Weather in As-Salt
alias weather='curl https://wttr.in/As%20Salt\?format=3'

#update spicetify
alias spicetifyupdate='spicetify update && spicetify restore backup apply'

#ARCHIVE EXTRACT
ex ()
{
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1   ;;
        *.tar.gz)    tar xzf $1   ;;
        *.bz2)       bunzip2 $1   ;;
        *.rar)       unrar x $1   ;;
        *.gz)        gunzip $1    ;;
        *.tar)       tar xf $1    ;;
        *.tbz2)      tar xjf $1   ;;
        *.tgz)       tar xzf $1   ;;
        *.zip)       unzip $1     ;;
        *.Z)         uncompress $1;;
        *.7z)        7za e x $1   ;;
        *.deb)       ar x $1      ;;
        *.tar.xz)    tar xf $1    ;;
        *.tar.zst)   unzstd $1    ;;
        *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

eval "$(zoxide init zsh)"
neofetch
