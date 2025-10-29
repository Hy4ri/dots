export editor="nvim"
export visual="nvim"
export cscope_editor="nvim"
export manpager="nvim +man!"
export term="foot"
export terminal="foot"
export helper="paru"
export less_termcap_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export less_termcap_me="$(tput sgr0 2> /dev/null)"
export fzf_default_opts="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export fzf_ctrl_r_opts="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget
# export path=$path:/home/m57/.spicetify

histsize=100000
savehist=100000


############################ aliases #################################

#nix
alias nxup='nh os switch -u ~/documents/projects/dots/nix'
alias nxbld='nh os switch ~/documents/projects/dots/nix'
alias nxcln='sudo nix-collect-garbage --delete-older-than 1d'
alias nxup='sudo nixos-rebuild switch --flake ~/documents/projects/dots/nix'

#pacman
alias sps='sudo pacman -s'
alias spss='sudo pacman -ss'
alias spfzf="pacman -sl | awk '{print \$2 (\$4==\"\" ? \"\" : \" *\")}' | fzf --multi --preview 'pacman -si {1}' --reverse | xargs -ro sudo pacman -s"
alias spsyyu='sudo pacman -syyu'
alias spr='sudo pacman -r'
alias sprns='sudo pacman -rns'
alias spruns='sudo pacman -runs'
alias spcc='sudo pacman -rns $(pacman -qtdq)'
alias unlock='sudo rm /var/lib/pacman/db.lck'
alias mirror='sudo cachyos-rate-mirrors'

#paru
alias paruss="paru -sl | awk '{print \$2 (\$4==\"\" ? \"\" : \" *\")}' | fzf --multi --preview 'paru -si {1}' --reverse | xargs -ro paru -s"
alias paruscc='paru -scc' # remove unused cache
alias parus='paru -s'
alias parusyyu='paru -syyu'

#eza
alias ls='eza --color=always --group-directories-first --icons' # better ls
alias l='eza -al --color=always --group-directories-first --icons --git'  # long format
alias lt='eza -at --level=2 --color=always --group-directories-first --icons --git' # tree listing

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
alias rm='rm -iv'
alias mkdir='mkdir -pv'

#cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'

#zsh
alias sz='. "$HOME/.zshrc"'
alias zrc='${editor} ~/.zshrc'

#nvim
alias snvim='sudoedit'
alias nano='nvim'
alias nivm='nvim'
alias vim='nvim'
alias lvim='nvim_appname=lvim nvim'
alias avim='nvim_appname=avim nvim'

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
alias xx='bash ~/documents/xx.sh'

#random
alias clock='termdown -z -z " %i : %m " -f banner3'
alias battery='upower -i /org/freedesktop/upower/devices/battery_bat0'
alias weather='curl https://wttr.in/as%20salt\?format=3'
alias shizuku='adb shell sh /sdcard/android/data/moe.shizuku.privileged.api/start.sh'
alias vdl='yt-dlp'
alias odl='yt-dlp -t mp3'
alias img2txt='ascii-image-converter'
alias prop='hyprprop'
alias cp='cp -i'
alias c+x='chmod +x'
alias storage='dua i'
alias termdown='termdown -f roman'
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias rsync='rsync -rpavh'
alias bios='sudo systemctl reboot --firmware-setup'
alias h='hyprland'

############################# functions ##########################################

# archive extract
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
        *.z)         uncompress $1;;
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
  git add -a
  git commit -m "$1"
  git push
}

# update dotfiles
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

# update pkgs
up() {
  nh os switch -u ~/Documents/projects/dots/nix
  flatpak update 
}

# warp
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

