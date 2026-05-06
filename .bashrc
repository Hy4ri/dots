# Configuration converted from .zshrc
# vim: fdm=marker fdl=0

# exports {{{
export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export MANPAGER="nvim +Man!"

# Only set LESS_TERMCAP in TTY contexts
if [[ -t 1 ]]; then
  export LESS_TERMCAP_MD="$(
    tput bold 2>/dev/null
    tput setaf 2 2>/dev/null
  )"
  export LESS_TERMCAP_ME="$(tput sgr0 2>/dev/null)"
fi

# FZF
export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"

# PATH
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
# }}}

# options {{{
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTFILE=~/.bash_history
HISTCONTROL=ignoreboth:erasedups

shopt -s autocd
shopt -s histverify

# Only in TTY
[[ -t 0 ]] && stty stop undef 2>/dev/null
# }}}

# aliases {{{

#nix {{{{
alias nrs='nh os switch ~/Projects/dots/nix'
alias nr='nh os boot ~/Projects/dots/nix'
alias ncln='sudo nix-collect-garbage --delete-older-than 1d'
alien() { nix-alien-ld -- "$@"; }
# }}}}

#pacman {{{{
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
# }}}}

#paru {{{{
alias paruss="paru -Sl | awk '{print \$2 (\$4==\"\" ? \"\" : \" *\")}' | fzf --multi --preview 'paru -Si {1}' --reverse | xargs -ro paru -S"
alias paruscc='paru -Scc'
alias parus='paru -S'
alias parusyyu='paru -Syyu'
# }}}}

#eza {{{{
alias ls='eza --color=always --group-directories-first --icons'
alias l='eza -aHl --color=always --group-directories-first --icons --git'
alias lt='eza -aHT --level=3 --color=always --group-directories-first --icons --git'
# }}}}

#git {{{{
alias gc='git clone'
alias gp='git pull'
# }}}}

#tmux {{{{
alias tmuxa='tmux attach -t'
alias tmuxk='tmux kill-session -t'
# }}}}

#python {{{{
alias p='python'
alias pvenv='python -m venv venv'
alias sopy='source venv/bin/activate'
# }}}}

#files {{{{
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
# }}}}

#cd {{{{
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
# }}}}

#bash {{{{
sb() { source "$HOME/.bashrc"; }
brc() { ${EDITOR} ~/.bashrc; }
# }}}}

#nvim {{{{
alias snvim='sudoedit'
alias nano='nvim'
alias nivm='nvim'
alias vim='nvim'
# }}}}

#waydroid {{{{
alias wayon='waydroid show-full-ui'
alias wayoff='waydroid session stop'
# }}}}

#scripts {{{{
xx() { bash ~/Documents/xx.sh "$@"; }
# }}}}

#random {{{{
alias clock='termdown -z -Z " %I : %M " -f banner3'
alias battery='upower -i /org/freedesktop/Upower/devices/battery_BAT0'
weather() { curl -s "https://wttr.in/As%20Salt?format=3"; }
alias shizuku='adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh'
alias vdl='yt-dlp'
adl() { yt-dlp -x --audio-format mp3 "$@"; }
alias img2txt='ascii-image-converter'
alias prop='hyprprop'
alias cx='chmod +x'
alias storage='dua i'
alias termdown='termdown -f roman'
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias rsync='rsync -rPavh'
alias bios='sudo systemctl reboot --firmware-setup'
ff() { fastfetch --logo nixos_small --logo-color-1 red --logo-color-2 red --logo-color-3 red --logo-color-4 red --logo-color-5 red --logo-color-6 red --color-keys red "$@"; }
alias kew='foot -akew kew'
alias bmenu='~/.local/bin/bmenu'
grant_time() { /home/m57/Projects/micro-saftey/venv/bin/python3 /home/m57/Projects/micro-saftey/ms_safety.py --grant 10800 "$@"; }
# }}}}

# }}}

# functions {{{
math() { echo "scale=3; $*" | bc -l; }

# Directory change hook - runs 'l' when directory changes
__last_pwd="$PWD"
__chpwd_hook() {
  if [[ "$PWD" != "$__last_pwd" ]]; then
    __last_pwd="$PWD"
    l
  fi
}

extract() {
  if [[ ! -f "$1" ]]; then
    echo "'$1' is not a valid file"
    return 1
  fi
  case "$1" in
  *.xz) unxz "$1" ;;
  *.bz2) bunzip2 "$1" ;;
  *.rar) unrar x "$1" ;;
  *.gz) gunzip "$1" ;;
  *.tbz2 | *.tar.bz2) tar xjf "$1" ;;
  *.tgz | *.tar.gz) tar xzf "$1" ;;
  *.zip) unzip "$1" ;;
  *.Z) uncompress "$1" ;;
  *.7z) 7za x "$1" ;;
  *.deb) ar x "$1" ;;
  *.tar) tar xf "$1" ;;
  *.tar.xz) tar xf "$1" ;;
  *.tar.zst) unzstd "$1" ;;
  *) echo "'$1' cannot be extracted via extract()" ;;
  esac
}

compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }

gitup() {
  git add -A
  git commit -m "$1"
  git push
}

dup() {
  cd "$HOME/Projects/dots/" || return 1
  git add -A
  git commit -m "$1"
  git push
}

dngl() (
  cd "$HOME/Videos/dngl/" || return 1
  yt-dlp "$1"
)

up() {
  nh os switch -u ~/Projects/dots/nix
  flatpak update
}

warp() {
  sudo -v || return 1
  sudo warp-svc >/dev/null 2>&1 &
  disown
}

waypatch() {
  git clone https://github.com/casualsnek/waydroid_script
  cd waydroid_script || return
  python3 -m venv venv
  venv/bin/pip install -r requirements.txt
  sudo venv/bin/python3 main.py
}

nt() { nix shell "nixpkgs#$1"; }

yz() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  cwd=$(<"$tmp")
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd -- "$cwd"
  rm -f -- "$tmp"
}
# }}}

# fzf {{{
if [[ -f /run/current-system/sw/share/fzf/key-bindings.bash ]]; then
  source /run/current-system/sw/share/fzf/key-bindings.bash
elif command -v fzf &>/dev/null; then
  eval "$(fzf --bash 2>/dev/null)" || true
fi
# }}}

# zoxide {{{
eval "$(zoxide init bash)"
# }}}

# Prompt {{{
# Ensure Bash updates COLUMNS after each command
shopt -s checkwinsize

_build_prompt() {
  local clock_time meridian
  clock_time=$(date "+%l:%M")
  meridian=$(date "+%p")

  # 1. Start of terminal: Path (Green) and Opening Bracket (Blue)
  PS1="\[\e[32m\]\w \[\e[34m\][\[\e[0m\] "

  # 2. Save cursor position so you can type inside the brackets
  PS1+="\[\e[s\]"

  # 3. Move to the right side
  # Math: ] (1) + space (1) + HH:MM (5) + space (1) + AM (2) = 10 chars
  PS1+="\[\e[$((COLUMNS - 10))G\]"

  # 4. Closing Bracket (Blue)
  PS1+="\[\e[34m\]] \[\e[0m\]"

  # 5. Clock (Green) and AM/PM (Yellow)
  PS1+="\[\e[32m\]${clock_time}\[\e[33m\] ${meridian}\[\e[0m\]"

  # 6. Restore cursor position to the typing area
  PS1+="\[\e[u\]"
}

# Combine hooks: Directory listing + Prompt building
PROMPT_COMMAND="__chpwd_hook; _build_prompt"
# }}}

# vim: fdm=marker fdl=0
