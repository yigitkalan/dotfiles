# ==========================================
# 1. ENVIRONMENT VARIABLES & PATHS
# ==========================================
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export GOPATH=$HOME/work/go/gopath/bin
export EDITOR="nvim"
export VISUAL="nvim"
export SYSTEMD_EDITOR="nvim"

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files  --ignore-file $HOME/.ignore  2> /dev/null '

export PATH=$HOME/.pub-cache/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH=$GOPATH:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# ==========================================
# 2. ZSH OPTIONS & KEYBINDS
# ==========================================
setopt interactivecomments
setopt HIST_IGNORE_ALL_DUPS
WORDCHARS=${WORDCHARS//[\/]}
bindkey -e # Force emacs mode (standard controls)

# ==========================================
# 3. ALIASES
# ==========================================
alias cl="clear"
alias rm="rm -i"
alias open="xdg-open"
alias ls='lsd'
alias v='nvim'
alias hx="helix"
alias lg='lazygit'
alias keyb="setxkbmap -layout"
alias clearswaps="rm -rf ~/.local/state/nvim/swap/*"

# Network & Bluetooth
alias startBl='sudo systemctl start bluetooth'
alias wconnect='nmcli device wifi connect'
alias wlist='nmcli device wifi list'
alias won='nmcli radio wifi on'
alias woff='nmcli radio wifi off'

# Utils
alias fzg='cd $(find * -type d | fzf)'
alias fzo='fzf | xargs xdg-open'
alias livehere="live-server . & sass --watch . &"
alias fixusb="sudo rmmod ehci_hcd && sudo modprobe ehci_hcd"
alias reboot="sudo reboot"
alias pacclean='pacman -Qdtq | xargs -r -o sudo pacman -Rns'
alias bfilter="wlsunset"
alias backupNotes="rclone copy ~/Documents/notes/ ProtonDrive:Notes/ --progress"
alias sendphone='kdeconnect-cli -d $(kdeconnect-cli -l --id-only) --share $(fzf)'
alias startdpi='sudo systemctl start zapret --no-block && notify-send "Zapret" "Bypass Active"'
alias stopdpi='sudo systemctl stop zapret && notify-send "Zapret" "Bypass Disabled"'

# Tmux
alias tmo='tmux attach-session -t '
alias tmn='tmux new-session -s '
alias tka='tmux kill-session -a '
alias tks='tmux kill-session -t'

# Zellij
alias za='zellij attach'
alias zn='zellij -s'
alias zl='zellij list-sessions'
alias zka='zellij delete-all-sessions'
alias zk='zellij delete-session'

# ==========================================
# 4. ZIM FRAMEWORK & PLUGINS
# ==========================================
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
source ${ZIM_HOME}/init.zsh

# ==========================================
# 5. PROMPTS & TOOLS (Must be last)
# ==========================================
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
