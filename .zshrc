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

plugins=(fzf aliases colored-man-pages extract safe-paste sudo zsh-autosuggestions colorize zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)


############################ Binds #################################

bindkey "^a" beginning-of-line
bindkey "^e" end-of-line


############################ ALIASES #################################

#pacman
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias spsyyu='sudo pacman -Syyu'
alias spr='sudo pacman -R'
alias sprns='sudo pacman -Rns'
alias spruns='sudo pacman -Runs'
alias spcc='sudo pacman -Rns $(pacman -Qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias mirror="sudo cachyos-rate-mirrors"

#paru
alias paruscc='paru -Scc' # remove unused cache
alias parus='paru -S'
alias paruss='paru -Ss'
alias parusyyu='paru -Syyu'

#eza
alias ls='eza --color=always --group-directories-first' # better ls
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -al --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing

#git
alias gitc='git clone'

#aliases
alias snvim='sudo nvim'
alias clock='tty-clock -c -C7 -b -t -n'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias weather='curl https://wttr.in/As%20Salt\?format=3'
alias music='bash ~/.config/hypr/scripts/spotify-update.sh'
alias shizuku='adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh'
alias vdl='yt-dlp'
alias img2txt='ascii-image-converter'
alias vim='nvim'
alias nano='nvim'
alias grep='rg'
alias prop='hyprprop'
alias cp='cp -i'
alias c+x='chmod +x'
alias manga='mangal'
alias anime='jerry'
alias storage='dua i'
alias termdown='termdown -f roman'
alias png='bash ~/.config/hypr/scripts/png.sh'
alias update='paru -Syyu && flatpak update '
alias 25='bash ~/.config/hypr/scripts/25.sh'
alias dngl='z videos/dangool && yt-dlp'
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"

#waydroid
alias wayon='waydroid show-full-ui '
alias wayoff='waydroid session stop'
alias waypatch='git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py'


############################# FUNCTIONS ##########################################

# ARCHIVE EXTRACT
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
# git push all
gitup() {
  git add -A
  git commit -m "$1"
  git push
}

# github new repo
gitnew() {
  git init
  sleep 5
  git add .
  git commit -m "create $1 repo"
  gh repo create $1 --public
  sleep 3
  git branch -M main
  git remote add origin https://github.com/Hy4ri/$1.git
  git push -u origin main
}

# Update dotfiles

dup() {
  cd $HOME/Documents/Projects/dots/
  git add -A
  git commit -m "$1"
  git push
}

############################## LAUNCH #############################

#Zoxide
eval "$(zoxide init zsh)"
#ff
fastfetch --logo arch_small --logo-color-2 red --logo-color-1 red --color-keys red

