# Umayr Saghir's (Nightmayr) bashrc

# Environment Variables
OS=$(uname -s)
export PATH=$PATH
EDITOR=vim

# Git prompt setup
function git_setup {
    # Git Auto-completion
    if [ -f ~/.git-completion.bash ]; then
        . ~/.git-completion.bash
    fi

    # Git prompt settings
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWUPSTREAM=auto
    export GIT_PS1_SHOWSTASHSTATE=true
    export PREPROMPT=$PS1
    # Modify prompt to show git branch
    if [ $OS == "Darwin" ]; then
        export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "$ "'
    elif [ $OS == "Linux" ]; then
        if [ $(sed -n '/\bID\b/p' /etc/os-release | awk -F= '/^ID/{print $2}') == "ubuntu" ]; then
            export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "$ "'
        elif [ $(sed -n '/\bID\b/p' /etc/os-release | awk -F= '/^ID/{print $2}') == "centos" ]; then
            export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "]$ "'
        fi
    fi

}

# global config

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# macOS bash config
if [ $OS == "Darwin" ]; then
    # Bash settings
    export PS1="\[\e[92m\]\u\[\e[m\]\[\e[92m\]@\[\e[m\]\[\e[92m\]\h\[\e[m\]:\[\e[36m\]\W\[\e[m\]"
    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

    # Setting Java home if it exists
    if [ -f /Library/Java/JavaVirtualMachines/openjdk-11.jdk ]; then
        export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home"
    fi
    # Git config
    if [ -f /usr/local/bin/git ]; then
        git_setup
    fi

# Linux config
elif [ $OS == "Linux" ]; then
    # Ubuntu config
    if [ $(sed -n '/\bID\b/p' /etc/os-release | awk -F= '/^ID/{print $2}') == "ubuntu" ]; then
        # ubuntu bashrc
        
        # set variable identifying the chroot you work in (used in the prompt below)
        if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
            debian_chroot=$(cat /etc/debian_chroot)
        fi
        
        # Prompt setup
        if [ "$color_prompt" = yes ]; then
            PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'
        else
            PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\'
        fi
        unset color_prompt force_color_prompt
        # Git config
        if [ -f /usr/bin/git ]; then
            git_setup
        fi

        # set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
            xterm-color|*-256color) color_prompt=yes;;
        esac

    elif [ $(sed - '/\bID\b/p' /etc/os-release | awk -F= '/^ID/{print $2}') == "centos" ]; then
        # Prompt override
        PS1='[\u@\h \W'
        
        if [ -x "$(command -v git)" ]; then
            # source git-prompt
            source /usr/share/git-core/contrib/completion/git-prompt.sh
            # git setup
            git_setup
        fi
    fi
fi

# Alias definitions
# Put aliases into separate file instead of adding them here directly
# use a file like ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Completions
if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion bash)
fi

# Custom additions




