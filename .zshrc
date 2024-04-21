# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="nanotech"

plugins=( 
    git
    archlinux
    zsh-autosuggestions
    colorize
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r


### From this line is for pywal-colors
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh

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
alias parusyyu='paru -Syyu'
alias parus='paru -S'
alias clock='tty-clock -c -C7 -b -t -n'
neofetch

export PATH=$PATH:/home/m57/.spicetify
