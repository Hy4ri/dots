export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export PATH=$PATH:/home/m57/.spicetify
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export FZF_BASE=/usr/share/fzf


DISABLE_MAGIC_FUNCTIONS="true"
COMPLETION_WAITING_DOTS="true"

ZSH_THEME="nanotech"

plugins=(git fzf aliases colored-man-pages extract safe-paste sudo zsh-autosuggestions colorize zsh-syntax-highlighting )
source $ZSH/oh-my-zsh.sh

#pacman
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias spsyyu='sudo pacman -Syyu'
alias spr='sudo pacman -R'
alias sprns='sudo pacman -Rns'
alias spruns='sudo pacman -Runs'

#paru
alias parusc='paru -Sc' # remove unused cache
alias parus='paru -S'
alias paruss='paru -Ss'
alias parusyyu='paru -Syyu'

#eza
alias ls='eza --color=always --group-directories-first' # better ls
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -al --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing

#aliases
alias snvim='sudo nvim'
alias clock='tty-clock -c -C7 -b -t -n'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias weather='curl https://wttr.in/As%20Salt\?format=3'
alias music='bash ~/.config/hypr/UserScripts/spotify-update.sh'
alias shizuku='adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh'
alias 2x='upscayl'
alias vdl='yt-dlp'
alias fm='yazi'
alias img2txt='ascii-image-converter'
alias cd='z'
alias vim='nvim'
alias nano='nvim'
alias grep='rg'
alias prop='hyprprop'
alias cat='bat'
alias cp='cp -i'
alias c+x='chmod +x'
alias manga='mangal'
alias anime='jerry'
alias storage='dua i'
alias termdown='termdown -f roman'
alias sway='sway --unsupported-gpu'

#waydroid
alias wayon='waydroid show-full-ui '
alias wayoff='waydroid session stop'
alias waypatch='git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py'


##FUNCTIONS
#ARCHIVE EXTRACT
extract ()
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
#git
gitup() {
  git add -A
  git commit -m "$1"
  git push
}

#Zoxide
eval "$(zoxide init zsh)"
#fzf
source <(fzf --zsh)
#ff
fastfetch --logo arch_small --color-keys red --logo-color-1 red --logo-color-2 red
