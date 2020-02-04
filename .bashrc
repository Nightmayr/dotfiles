# Umayr Saghir's (Nightmayr) bashrc

# Debugging
# Uncomment below for debugging information
#set -x

# Environment Variables
export OS=$(uname -s)
export PATH=$PATH
export EDITOR=vim
export HISTCONTROL=ignoreboth:erasedups
if [ -f /etc/os-release ]; then
    export DISTRO=$(sed -n '/\bID\b/p' /etc/os-release | awk -F= '/^ID/{print $2}' | tr -d '"')
fi

# Options

### Append to history
shopt -s histappend

# Functions

### Git prompt setup
function git_setup {
    # Git Auto-completion
    if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
        . /usr/local/etc/bash_completion.d/git-completion.bash
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
        if [ $DISTRO == "ubuntu" ]; then
            export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "$ "'
        elif [ $DISTRO == "centos" ] || [ $DISTRO == "rhel" ]; then
            export PROMPT_COMMAND='__git_ps1 "$PREPROMPT" "]$ "'
        fi
    fi

}

# Global and OS specific configurations

### Global 

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

### macOS 
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

### Linux 
elif [ $OS == "Linux" ]; then
    # Ubuntu config
    if [ $DISTRO == "ubuntu" ]; then
        # ubuntu bashrc
        
        # set variable identifying the chroot you work in (used in the prompt below)
        if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
            debian_chroot=$(cat /etc/debian_chroot)
        fi
        
        # set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
            xterm-color|*-256color) color_prompt=yes;;
        esac

        # Prompt setup
        if [ "$color_prompt" = yes ]; then
            PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]'
        else
            PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W'
        fi
        unset color_prompt force_color_prompt
        
        # enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            #alias dir='dir --color=auto'
            #alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi

        # Git config
        if [ -f /usr/bin/git ]; then
            git_setup
        fi


    elif [ $DISTRO == "centos" ] || [ $DISTRO == "rhel" ]; then
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

# PATH setup for mac
if [ $OS == "Darwin" ]; then
    source ~/.profile
fi

# Alias definitions
# Put aliases into separate file instead of adding them here directly
# use a file like ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Completions

### Bash Completion
if [ $OS == "Darwin" ]; then
    [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
else
    [ -f /etc/bash_completion ] && . /etc/bash_completion
fi

### Kubernetes completion
if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion bash)
fi

### Terraform completion
if [ -x "$(command -v terraform)" ]; then
        complete -C $(which terraform) terraform
fi

### Gcloud shell completion
if [ -x "$(command -v gcloud)" ]; then
    if [ $OS == "Darwin" ]; then
        if [ -f '/Users/umayr/Applications/google-cloud-sdk/completion.bash.inc' ]; then 
            . '/Users/umayr/Applications/google-cloud-sdk/completion.bash.inc'
    fi
    else
            # Linux completion here
            echo 'hello'
        fi
fi

### AWS CLI completion
if [ -x "$(command -v aws)" ]; then
    complete -C $(which aws_completer) aws
fi

# Custom additions



