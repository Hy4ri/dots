# exports {{{
export EDITOR="nvim"
export VISUAL="nvim"
export CSCOPE_EDITOR="nvim"
export MANPAGER="nvim +Man!"
export less_termcap_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export less_termcap_me="$(tput sgr0 2> /dev/null)"
export fzf_default_opts="--style minimal --color 16 --layout=reverse --height 30% --preview='bat -p --color=always {}'"
export fzf_ctrl_r_opts="--style minimal --color 16 --info inline --no-sort --no-preview" # separate opts for history widget
export PATH=$PATH:/home/m57/.spicetify
export PATH=$PATH:$HOME/.local/bin
# }}}

#options {{{
HISTSIZE=10000000
SAVEHIST=10000000
HISTDUP=erase
stty stop undef
setopt bang_hist
setopt extended_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_verify
setopt interactive_comments
setopt AUTOCD
setopt PROMPT_SUBST
setopt MENU_COMPLETE
setopt LIST_PACKED
setopt AUTO_LIST
setopt COMPLETE_IN_WORD
# }}}

# aliases {{{

#nix {{{{
alias nrs='nh os switch ~/Documents/Projects/dots/nix'
alias nr='nh os boot ~/Documents/Projects/dots/nix'
alias ncln='sudo nix-collect-garbage --delete-older-than 1d'
alias nup='sudo nixos-rebuild switch --flake ~/Documents/Projects/dots/nix'
alias alien='nix-alien-ld -- '
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
alias paruscc='paru -Scc' # remove unused cache
alias parus='paru -S'
alias parusyyu='paru -Syyu'
# }}}}

#eza {{{{
alias ls='eza --color=always --group-directories-first --icons' # better ls
alias l='eza -aHl --color=always --group-directories-first --icons --git' # long format
alias lt='eza -aHT --level=2 --color=always --group-directories-first --icons --git' # tree listing
# }}}}

#git {{{{
alias gitc='git clone'
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
alias rm='rm -Iv'
alias mkdir='mkdir -pv'
# }}}}

#cd {{{{
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
# }}}}

#zsh {{{{
alias sz='. "$HOME/.zshrc"'
alias zrc='${EDITOR} ~/.zshrc'
# }}}}

#nvim {{{{
alias snvim='sudoedit'
alias nano='nvim'
alias nivm='nvim'
alias vim='nvim'
alias nmax='NVIM_APPNAME=nvim-minimax nvim'
alias mvim='NVIM_APPNAME=mvim nvim'
# }}}}

#waydroid {{{{
alias wayon='waydroid show-full-ui '
alias wayoff='waydroid session stop'
alias waypatch='git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
python3 -m venv venv
venv/bin/pip install -r requirements.txt
sudo venv/bin/python3 main.py'
# }}}}

#scripts {{{{
alias xx='bash ~/Documents/xx.sh'
# }}}}

#random {{{{
alias clock='termdown -z -Z " %I : %M " -f banner3'
alias battery='Upower -i /org/freedesktop/Upower/devices/battery_BAT0'
alias weather='curl https://wttr.in/As%20Salt\?format=3'
alias shizuku='adb shell sh /sdcard/Android/data/moe.shizuku.privileged.api/start.sh'
alias vdl='yt-dlp'
alias adl='yt-dlp -t mp3'
alias img2txt='ascii-image-converter'
alias prop='hyprprop'
alias cp='cp -i'
alias cx='chmod +x'
alias storage='dua i'
alias termdown='termdown -f roman'
alias grubup='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias rsync='rsync -rPavh'
alias bios='sudo systemctl reboot --firmware-setup'
alias ff='fastfetch --logo nixos_small --logo-color-2 red --logo-color-1 red --color-keys red'
alias kew='foot -akew kew'
alias bmenu='~/.local/bin/bmenu'
# }}}}

# }}}

# functions {{{

function plugin-load {
    local repo plugdir initfile initfiles=()
    : ${ZPLUGINDIR:=${ZDOTDIR:-$HOME/.zsh}/plugins}
    for repo in $@; do
        plugdir=$ZPLUGINDIR/${repo:t}
        initfile=$plugdir/${repo:t}.plugin.zsh
        if [[ ! -d $plugdir ]]; then
            echo "Cloning $repo..."
            git clone -q --depth 1 --recursive --shallow-submodules \
                https://github.com/$repo $plugdir
        fi
        if [[ ! -e $initfile ]]; then
            initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
            (( $#initfiles )) || { echo >&2 "No init file '$repo'." && continue }
            ln -sf $initfiles[1] $initfile
        fi
        source $initfile
    done
}

#math
math() {
    echo "scale=3; $*" | bc -l
}

# z&l
zl() {
    z "$@"
    l
}

# Extract
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.xz)    unxz $1;;
            *.bz2)       bunzip2 $1;;
            *.rar)       unrar x $1;;
            *.gz)        gunzip $1;;
            *.tbz2)      tar xjf $1;;
            *.tgz)       tar xzf $1;;
            *.zip)       unzip $1;;
            *.Z)         uncompress $1;;
            *.7z)        7za e x $1;;
            *.deb)       ar x $1;;
            *.tar)       tar xf $1;;
            *.tar.bz2)   tar xjf $1;;
            *.tar.gz)    tar xzf $1;;
            *.tar.xz)    tar xf $1;;
            *.tar.zst)   unzstd $1;;
            *)           echo "'$1' cannot be extracted via extract()";;
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

# dngl
dngl() {
    cd $HOME/Videos/dngl/
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

# Nix pkgs temp install
nt() {
    nix shell nixpkgs#"$1"
}

# Set last yazi dir as terminal dir
yz() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
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

if [ -f /run/current-system/sw/share/fzf/key-bindings.zsh ]; then
    source /run/current-system/sw/share/fzf/key-bindings.zsh
elif command -v fzf &>/dev/null; then
    source <(fzf --zsh) 2>/dev/null || true
fi
# }}}

# vi {{{

bindkey -v
export KEYTIMEOUT=20

bindkey -M viins '^r' fzf-history-widget
bindkey -M vicmd '^r' fzf-history-widget

# Cursor shape
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]]; then
        print -n '\e[2 q' # Block
    else
        print -n '\e[5 q' # Blinking bar
    fi
}
zle -N zle-keymap-select

function zle-line-init {
    zle -K viins
    print -n '\e[5 q'
}
zle -N zle-line-init

# Fix backspace in insert mode
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char

# Yank to system clipboard
function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | wl-copy
}
zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

# Edit line in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# }}}

# Prompt {{{

parse_git_dirty() {
    [[ -n $(git status -s 2> /dev/null) ]] && echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
}

PROMPT='%F{green}%2c%F{blue} [%f '
RPROMPT='%F{blue}] %F{green}%D{%L:%M} %F{yellow}%D{%p}%f'
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# }}}

# plugins {{{
PLUGINS_DIR="$HOME/.zsh/plugins"

autoload -Uz compinit

# Case insensitive completion & better matching
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' \
    '+r:|[._-]=* r:|=*' \
    '+l:|=*'

eval "$(zoxide init zsh)"

# list of github repos of plugins
repos=(
    zsh-users/zsh-autosuggestions
    Aloxaf/fzf-tab
    zdharma-continuum/fast-syntax-highlighting
)
plugin-load $repos

# }}}

# startup {{{

fastfetch --logo nixos_small --logo-color-2 red --logo-color-1 red --color-keys red
# }}}

# vim:set et sw=4 ts=4 fdm=marker:
