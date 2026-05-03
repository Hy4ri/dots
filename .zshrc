# vim: fdm=marker fdl=0

# exports {{{
export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export MANPAGER="nvim +Man!"

# Only set LESS_TERMCAP in TTY contexts
if [[ -t 1 ]]; then
    export LESS_TERMCAP_MD="$(tput bold 2>/dev/null; tput setaf 2 2>/dev/null)"
    export LESS_TERMCAP_ME="$(tput sgr0 2>/dev/null)"
fi

# FZF
export FZF_DEFAULT_OPTS="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export FZF_CTRL_R_OPTS="--style minimal --color 16 --info inline --no-sort --no-preview"

# PATH
export PATH="$HOME/.local/bin:$HOME/.spicetify:$PATH"
# }}}

# options {{{
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# Combine all setopts into single calls
setopt AUTOCD AUTO_LIST bang_hist COMPLETE_IN_WORD extended_history \
    hist_expire_dups_first hist_find_no_dups hist_ignore_all_dups \
    hist_ignore_space hist_save_no_dups hist_verify interactive_comments \
    LIST_PACKED MENU_COMPLETE PROMPT_SUBST share_history

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

#zsh {{{{
sz() { source "$HOME/.zshrc"; }
zrc() { ${EDITOR} ~/.zshrc; }
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

plugin-load() {
    local repo plugdir initfile initfiles=()
    : "${ZPLUGINDIR:=$PLUGINS_DIR}"
    for repo in "$@"; do
      ZSH_CUSTOM="$HOME/.zsh"
      plugins_dir="$ZSH_CUSTOM/plugins"

      # Example: load plugins from the custom plugins directory
      for plugin in "$plugins_dir"/*; do
        if [ -d "$plugin" ]; then
          f="$plugin/$plugin.zsh"
          [ -f "$f" ] && source "$f"
        fi
      done
        plugdir="$ZPLUGINDIR/${repo:t}"
        initfile="$plugdir/${repo:t}.plugin.zsh"
        if [[ ! -d "$plugdir" ]]; then
            echo "Cloning $repo..."
            git clone -q --depth 1 --recursive --shallow-submodules \
                "https://github.com/$repo" "$plugdir"
        fi
        if [[ ! -e "$initfile" ]]; then
            initfiles=("$plugdir"/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
            (( $#initfiles )) || { echo >&2 "No init file '$repo'." && continue }
            ln -sf "$initfiles[1]" "$initfile"
        fi
        source "$initfile"
    done
}

math() { echo "scale=3; $*" | bc -l; }

# z&l - only in interactive shells
chpwd() { [[ -o interactive ]] && l; }

extract() {
    if [[ ! -f "$1" ]]; then
        echo "'$1' is not a valid file"
        return 1
    fi
    case "$1" in
        *.xz) unxz "$1";;
        *.bz2) bunzip2 "$1";;
        *.rar) unrar x "$1";;
        *.gz) gunzip "$1";;
        *.tbz2|*.tar.bz2) tar xjf "$1";;
        *.tgz|*.tar.gz) tar xzf "$1";;
        *.zip) unzip "$1";;
        *.Z) uncompress "$1";;
        *.7z) 7za x "$1";;
        *.deb) ar x "$1";;
        *.tar) tar xf "$1";;
        *.tar.xz) tar xf "$1";;
        *.tar.zst) unzstd "$1";;
        *) echo "'$1' cannot be extracted via extract()";;
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

# Set last yazi dir as terminal dir
yz() {
    local tmp cwd
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

yazicd_widget() {
    zle -I
    yz
}

zle -N yazicd_widget
bindkey '^o' yazicd_widget

# }}}

# fzf {{{
if [[ -f /run/current-system/sw/share/fzf/key-bindings.zsh ]]; then
    source /run/current-system/sw/share/fzf/key-bindings.zsh
elif command -v fzf &>/dev/null; then
    source <(fzf --zsh) 2>/dev/null || true
fi
# }}}

# completion {{{
# Ultra-aggressive compinit caching
autoload -Uz compinit

# Fast compinit: skip security check, use cached dump
compinit -C

# Completion styling and caching
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' rehash true
# }}}

# plugins {{{
PLUGINS_DIR="$HOME/.zsh/plugins"

# Load all plugins synchronously
plugin-load zsh-users/zsh-autosuggestions
plugin-load Aloxaf/fzf-tab
plugin-load zdharma-continuum/fast-syntax-highlighting
# }}}

# zoxide - lazy load only if not already loaded {{{
if (( $+commands[zoxide] )) && (( ! $+functions[z] )); then
    eval "$(zoxide init zsh)"
fi
# }}}

# Prompt {{{
PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='%F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'
# }}}

# vim: fdm=marker fdl=0
