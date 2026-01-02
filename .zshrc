# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
#
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# #Step 1) install with dotnet install scripts
# #Step 2) symlink of dotnet in /usr/bin/ and /usr/local/bin
# export DOTNET_ROOT=/home/sy/.dotnet
# export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

export GOPATH=$HOME/work/go/gopath/bin
export EDITOR=nvim
export VISUAL=nvim
export LIBVA_DRIVER_NAME=nvidia
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files  --ignore-file $HOME/.ignore  2> /dev/null '

export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH=$GOPATH:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"


export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
setopt interactivecomments

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git 
  zsh-autosuggestions 
  web-search 
  zsh-syntax-highlighting 
  copypath 
  copyfile 
  history)

  #you-should-use


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias sdn="systemctl poweroff"
alias cl="clear"
alias rm="rm -i"
alias open="xdg-open"


#open bluetooth
alias startBl='sudo systemctl start bluetooth'

alias fzg='cd $(find * -type d | fzf)'
alias fzo='fzf | xargs xdg-open'

alias v="nvim"

alias lg='lazygit'

#localectl list-x11-keymap-layouts to list the layouts
alias keyb="setxkbmap -layout"

alias clearswaps="rm -rf ~/.local/state/nvim/swap/*"

alias wconnect="nmcli device wifi connect"
alias wlist="nmcli device wifi list"
alias won="nmcli radio wifi on"
alias woff="nmcli radio wifi off"

alias livehere="live-server . & ; sass --watch . & "

alias fixusb="sudo rmmod ehci_hcd && sudo modprobe ehci_hcd"

alias tmo='tmux attach-session -t '
alias tmn='tmux new-session -s '
alias tka='tmux kill-session -a '
alias tks='tmux kill-session -t'

alias pacclean="sudo pacman -R $(pacman -Qdtq)"

alias reboot="sudo reboot"

alias startdpi="sudo systemctl start zapret"
alias stopdpi="sudo systemctl stop zapret"


#Instead use a shell script
# alias performant="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only GBM_BACKEND=nvidia-drm WLR_DRM_DEVICES=/dev/dri/card1"

alias bfilter="wlsunset"

alias backupNotes="rclone copy ~/Documents/notes/ ProtonDrive:Notes/ --progress"

alias ls='lsd'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


# pfetch
#neofetch
