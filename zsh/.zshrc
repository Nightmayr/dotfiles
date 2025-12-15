# ==============================================================================
# 1. ENVIRONMENT & COLORS
# ==============================================================================

DOTFILES_DIR="$HOME/.dotfiles"
declare -a SOURCE_FILES=(
    "env"
    "aliases"
    "functions"
)

for file in "${SOURCE_FILES[@]}"; do
    FILE_PATH="$DOTFILES_DIR/.$file"
    if [[ -x "$FILE_PATH" ]]; then
        source "$FILE_PATH"
    fi
done


# Enable color support
autoload -U colors && colors

# Initialize the completion system
autoload -U compinit && compinit

# --- START: Git Prompt Configuration ---
# Load version control system info module
autoload -Uz vcs_info

# Configure how Git info is displayed
zstyle ':vcs_info:*' formats ' (%F{yellow}%b%f)'
zstyle ':vcs_info:*' actionformats ' (%F{yellow}%b%f|%F{red}%a%f)'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' uncommittedstr 'U'
zstyle ':vcs_info:*' cleanformats ' (%F{yellow}%b%f)'
zstyle ':vcs_info:*' modifiedformats ' (%F{yellow}%b%f%F{red}%c%f)'
zstyle ':vcs_info:*' actionformats ' (%F{yellow}%b%f|%F{red}%a%f%F{red}%c%f)'
# --- END: Git Prompt Configuration ---

# ==============================================================================
# 2. OPTIONS & HISTORY
# ==============================================================================
# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Usability options
setopt APPEND_HISTORY        # Append to history file rather than replace
setopt HIST_IGNORE_ALL_DUPS  # Do not record an event that was just recorded again
setopt SHARE_HISTORY         # Share history between different shell sessions
setopt AUTO_CD               # Type path to directory instead of 'cd dir'
setopt EXTENDED_HISTORY      # Save timestamps in history

# ==============================================================================
# 3. COMPLETION TWEAKS
# ==============================================================================
# Case insensitive tab completion (typing 'cd doc' matches 'Documents')
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Use a selection menu when multiple tab options exist
zstyle ':completion:*' menu select

# ==============================================================================
# 4. PROMPT
# ==============================================================================

# Function to run before each prompt refresh
precmd() {
  vcs_info
}

setopt prompt_subst


# Format: [User]@[Host]:[CurrentDir]$
# %F{color} starts color, %f resets it.
PROMPT='%F{green}%n%f@%F{magenta}%m%f %F{cyan}%1~%f${vcs_info_msg_0_} %# '

# ==============================================================================
# 5. PATH CONFIGURATION
# ==============================================================================
# Add local binaries and Homebrew (Mac Silicon) to path if they exist
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
