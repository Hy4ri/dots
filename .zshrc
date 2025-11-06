export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export MANPAGER="nvim +Man!"
export TERM="foot"
export TERMINAL="foot"
export helper="paru"
export less_termcap_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export less_termcap_me="$(tput sgr0 2> /dev/null)"
export fzf_default_opts="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export fzf_ctrl_r_opts="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget
# export path=$path:/home/m57/.spicetify

HISTSIZE=100000
SAVEHIST=100000


############################ aliases #################################

#nix
alias nxbld='nh os switch ~/Documents/Projects/dots/nix'
alias nxbldns='nh os build ~/Documents/Projects/dots/nix'
alias nxcln='sudo nix-collect-garbage --delete-older-than 1d'
alias nxup='sudo nixos-rebuild switch --flake ~/Documents/Projects/dots/nix'

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

#python
alias p='python'
alias pvenv='python -m venv venv'
alias sopy='source venv/bin/activate'

#files
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'

#cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

#zsh
alias sz='. "$HOME/.zshrc"'
alias zrc='${EDITOR} ~/.zshrc'

#nvim
alias snvim='sudoedit'
alias nano='nvim'
alias nivm='nvim'
alias vim='nvim'
alias lvim='NVIM_APPNAME=lvim nvim'
alias avim='NVIM_APPNAME=avim nvim'

#waydroid
alias wayon='waydroid show-full-ui '
alias wayoff='waydroid session stop'
alias waypatch='git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py'

#scripts
alias music='bash ~/.config/hypr/scripts/music.sh'
alias png='bash ~/.config/hypr/scripts/png.sh'
alias 25='bash ~/.config/hypr/scripts/25.sh'
alias xx='bash ~/Documents/xx.sh'

#random
alias clock='termdown -z -Z " %I : %M " -f banner3'
alias battery='Upower -i /org/freedesktop/Upower/devices/battery_BAT0'
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

############################# functions ##########################################

# Extract
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

#Compress
compress() {
  tar -czf "${1%/}.tar.gz" "${1%/}"; 
}

# Git push all
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

# dangool
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

# Warp
warp() {
  sudo -v || return 1
  sudo warp-svc >/dev/null 2>&1 &
  disown
}

# nix pkgs temp install
nxtry() {
  nix shell nixpkgs#"$1"
}

############################# vi mode ##########################################

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

############################## Prompt ###############################

parse_git_dirty() {
  [[ -n $(git status -s 2> /dev/null) ]] && echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
}

PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='%F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

############################ plugins #################################

PLUGINS_DIR="$HOME/.zsh/plugins"

autoload -U compinit
compinit

eval "$(zoxide init zsh)"

source "$PLUGINS_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$PLUGINS_DIR/fzf-tab/fzf-tab.plugin.zsh"
source "$PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

############################## launch ###############################

#ff
fastfetch --logo nixos_small --logo-color-2 red --logo-color-1 red --color-keys red

