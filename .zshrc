export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export MANPAGER="nvim +Man!"
export TERM="foot"
export TERMINAL="foot"
export helper="paru"
export PATH="$HOME/.local/bin:$PATH"
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export FZF_BASE=/usr/share/fzf
export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget

HISTSIZE=100000
SAVEHIST=100000

############################ Plugins #################################

source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle fzf
antigen bundle safe-paste
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme nanotech

antigen apply

############################ ALIASES #################################

#nix
alias nxup='nh os switch -u ~/Documents/Projects/dots/nix'
alias nxbld='nh os switch ~/Documents/Projects/dots/nix'
alias nxcln='sudo nix-collect-garbage --delete-older-than 1d'
alias nxup='sudo nixos-rebuild switch --flake ~/Documents/Projects/dots/nix'
alias nxtry='nix-shell -p'

#pacman
alias sps='sudo pacman -S'
alias spss='sudo pacman -Ss'
alias spfzf="pacman -Sl | awk '{print \$2 (\$4==\"\" ? \"\" : \" *\")}' | fzf --multi --preview 'pacman -Si {1}' --reverse | xargs -ro sudo pacman -S"
alias spsyyu='sudo pacman -Syyu'
alias spr='sudo pacman -R'
alias sprns='sudo pacman -Rns'
alias spruns='sudo pacman -Runs'
alias spcc='sudo pacman -Rns $(pacman -Qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias mirror='sudo cachyos-rate-mirrors'

#paru
alias paruss="paru -Sl | awk '{print \$2 (\$4==\"\" ? \"\" : \" *\")}' | fzf --multi --preview 'paru -Si {1}' --reverse | xargs -ro paru -S"
alias paruscc='paru -Scc' # remove unused cache
alias parus='paru -S'
alias parusyyu='paru -Syyu'

#eza
alias ls='eza --color=always --group-directories-first --icons' # better ls
alias l='eza -al --color=always --group-directories-first --icons --git'  # long format
alias lt='eza -aT --level=2 --color=always --group-directories-first --icons --git' # tree listing

#git
alias gitc='git clone'

#tmux
alias tmuxa='tmux attach'

#Python
alias p='python'
alias pvenv='python -m venv venv'
alias sopy='source venv/bin/activate'

#Files
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'

#cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

#ZSH
alias sz='. "$HOME/.zshrc"'
alias zrc='${EDITOR} ~/.zshrc'

#Nvim
alias snvim='sudoedit'
alias nano='nvim'
alias nivm='nvim'
alias vim='nvim'
alias lvim='NVIM_APPNAME=lnvim nvim'
alias avim='NVIM_APPNAME=avim nvim'

#waydroid
alias wayon='waydroid show-full-ui '
alias wayoff='waydroid session stop'
alias waypatch='git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py'

#Scripts
alias music='bash ~/.config/hypr/scripts/music.sh'
alias png='bash ~/.config/hypr/scripts/png.sh'
alias 25='bash ~/.config/hypr/scripts/25.sh'
alias xx='bash ~/Documents/xx.sh'

#Random
alias clock='termdown -z -Z " %I : %M " -f banner3'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias weather='curl https://wttr.in/As%20Salt\?format=3'
alias shizuku='adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh'
alias vdl='yt-dlp'
alias odl='yt-dlp -t mp3'
alias img2txt='ascii-image-converter'
alias prop='hyprprop'
alias cp='cp -i'
alias c+x='chmod +x'
alias storage='dua i'
alias termdown='termdown -f roman'
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias rsync='rsync -rPavh'
alias bios='sudo systemctl reboot --firmware-setup'
alias h='Hyprland'

############################# VI Mode ##########################################

bindkey -v 
export KEYTIMEOUT=1 
export VI_MODE_SET_CURSOR=true 

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[2 q'
  else
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select

zle-line-init() {
  zle -K viins 
  echo -ne '\e[5 q'
}
zle -N zle-line-init
echo -ne '\e[5 q' 

# Yank to the system clipboard
function vi-yank-xclip {
  zle vi-yank
  echo "$CUTBUFFER" | wl-copy
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Press 'v' in normal mode to launch Nvim with current line
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

############################# FUNCTIONS ##########################################

# ARCHIVE EXTRACT
extract () {
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
        *)           echo "'$1' cannot be extracted via extract()" ;;
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

# Update dotfiles
dup() {
  cd $HOME/Documents/Projects/dots/
  git add -A
  git commit -m "$1"
  git push
}

# Dangool
dngl() {
  cd $HOME/Videos/dangool/
  yt-dlp "$1"
  cd $HOME
}

# Update pkgs
up() {
  nh os switch -u ~/Documents/Projects/dots/nix
  flatpak update 
}

#Warp
warp() {
  sudo -v || return 1
  sudo warp-svc >/dev/null 2>&1 &
  disown
}

############################## LAUNCH ###############################

#ff
fastfetch --logo NixOS_small --logo-color-2 red --logo-color-1 red --color-keys red

#Zoxide
autoload -Uz add-zsh-hook
load_zoxide_late() {
  eval "$(zoxide init zsh)"
}
add-zsh-hook precmd load_zoxide_late

export PATH=$PATH:/home/m57/.spicetify
