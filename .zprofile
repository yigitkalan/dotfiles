#
# ~/.bash_profile
#
#
#
#
#to automatically startx

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
