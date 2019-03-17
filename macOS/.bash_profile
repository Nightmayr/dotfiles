# Including paths for homebrew
export PATH="/usr/local/sbin:$HOME/scripts:$HOME/Library/Python/3.7/bin:$HOME/Applications/apache-maven-3.6.0/bin:$PATH"
# Setting JAVA_HOME
export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home"

# Bash Completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Git Auto-completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#Git prompt

# Bash Prompt Customisation
# export PS1="\h:\[\e[36m\]\W\[\e[m\] \u\\$ \[\e[35m\]\`parse_git_branch\`\[\e[m\]"
#export PS1="\h:\[\e[36m\]\W\[\e[m\] \u\\$ \[\e[m\]"
# export PREPROMPT="\h:\[\e[36m\]\W\[\e[m\]\[\e[92m\] \u\[\e[m\]\$ \[\e[m\]"
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM=auto
export GIT_PS1_SHOWSTASHSTATE=true
export PREPROMPT="\h:\[\e[36m\]\W\[\e[m\]\[\e[92m\] \u\[\e[m\]\[\e[m\]"

export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "$ "'
export GIT_PS1_SHOWCOLORHINTS=true
#export PS1="\[\e[92m\]\u\[\e[m\]\[\e[92m\]@\[\e[m\]\[\e[92m\]\h\[\e[m\]:\[\e[36m\]\W\[\e[m\] \\$ "

# Bash Colours
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

####################################  ALIASES  #####################################################

#alias for  default vim to be the Homebrew version
#alias vim='/usr/local/Cellar/macvim/8.0-144_3/MacVim.app/Contents/MacOS/Vim'
alias ldd='/usr/bin/otool'
alias python='python3'

# alias for mongod
#alias mongod='/usr/local/Cellar/mongodb/3.6.3/bin/mongod'

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/umayr/Applications/google-cloud-sdk/path.bash.inc' ]; then . '/Users/umayr/Applications/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/umayr/Applications/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/umayr/Applications/google-cloud-sdk/completion.bash.inc'; fi

# kubectl autocompletion
# command below not working 
#source <(kubectl completion bash)
# for legacy bash on macOS
source /dev/stdin <<<"$(kubectl completion bash)"


