# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Prompt override
PS1='[\u@\h \W'

# Git Auto-completion
 if [ -f ~/.git-completion.bash ]; then
   . ~/.git-completion.bash
 fi

# Git Prompt
source /usr/share/git-core/contrib/completion/git-prompt.sh

export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM=auto
export GIT_PS1_SHOWSTASHSTATE=true
export PREPROMPT=$PS1

export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "]$ "'

