# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  poetry
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# PERSONAL -> https://gist.github.com/thushana/6da997a21eb87c8673dea5ef00e669d3

# USAGE
# zedit        # Open ~/.zshrc in VS Code
# zsource      # Reload ~/.zshrc
# zcopy        # Copy ~/.zshrc to clipboard
# timetraveler # Activate virtual env and open VS Code
# codetree     # Show & copy directory structure
# codediff     # Show & copy git changes
# codecopy <file>  # Copy file contents & open Chrome
# dbstate      # Get database schema
# dbrecent <table> [rows] # Get latest database rows


# Add Homebrew to PATH if not already set
export PATH="/opt/homebrew/bin:$PATH"

# Edit ~/.zshrc using VS Code
zedit() {
  code ~/.zshrc
}

# Reload ~/.zshrc
zsource() {
  source ~/.zshrc
}

# Copy ~/.zshrc contents to clipboard
zcopy() {
  cat ~/.zshrc | pbcopy
  echo ".zshrc file copied to clipboard."
}

# Activate timetraveler virtual environment & open VS Code
timetraveler() {
  deactivate 2>/dev/null  # Silently deactivate any existing virtualenv
  cd /Users/thushan/Code/timetraveler || return

  if [ ! -d "env" ]; then
    python3 -m venv env
  fi

  source env/bin/activate
  code . &  # Open VS Code in the background
}

# Activate strange loops virtual environment, open GitHub Desktop, and launch VS Code
strangeloops() {
  deactivate 2>/dev/null  # Silently deactivate any existing virtualenv
  cd ~/Code/strangeloops || return

  # Ensure pyenv is initialized
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"

  # Define the Python version and virtual environment name
  PYTHON_VERSION="3.11.6"  # Change if needed
  ENV_NAME="strangeloops"

  # Set the correct Python version for this project
  pyenv local "$PYTHON_VERSION"

  # Create virtualenv if it doesn’t exist
  if ! pyenv virtualenvs | grep -q "$ENV_NAME"; then
    pyenv virtualenv "$PYTHON_VERSION" "$ENV_NAME"
  fi

  # Activate virtual environment
  pyenv activate "$ENV_NAME"

  # Print out version and path
  echo "✅ Using Python version: $(python --version)"
  echo "📂 Python location: $(which python)"

  # Open GitHub Desktop and ensure it loads the strangeloops repo
  echo "🚀 Opening GitHub Desktop..."
  open -a "GitHub Desktop" .

  # Wait a few seconds to let GitHub Desktop fully open before launching VS Code
  sleep 2

  # Open VS Code in the project directory
  echo "💻 Opening VS Code..."
  code . &
}

# Generate a clean directory tree (excluding env, __pycache__, and metadata)
codetree() {
  if ! command -v tree &> /dev/null; then
    echo "Error: 'tree' command is not installed. Install it with 'brew install tree'."
    return 1
  fi

  # Define general ignore patterns
  ignore_patterns="*.log|*.tmp|*.swp|*.lock|dist|build|coverage|.DS_Store|Thumbs.db"

  # Define Python-specific ignore patterns
  ignore_patterns_python="__pycache__|*.pyc|*.pyo|*.egg-info|env|.pytest_cache|*.ipynb_checkpoints"

  # Define JavaScript/Node.js-specific ignore patterns
  ignore_patterns_js="node_modules|.next|.turbo|*.env|yarn.lock|package-lock.json|npm-debug.log"

  # Combine all patterns
  combined_ignore_patterns="$ignore_patterns|$ignore_patterns_python|$ignore_patterns_js"

  # Execute tree command with combined ignore patterns
  {
    echo "Directory structure for: $(pwd)"
    echo "\n---\n"
    tree --prune -I "$combined_ignore_patterns"
  } | tee >(pbcopy)

  echo "Directory structure copied to clipboard."
}


# Show latest commit messages & file changes for a well-formed commit prompt
codediff() {
  if ! command -v git &> /dev/null; then
    echo "Error: 'git' is not installed."
    return 1
  fi

  {
    git log -n 5 --pretty=format:"%s"
    echo "\n---\n"

    # Show diffs for both staged & unstaged changes
    git diff --staged
    git diff

    # Show diffs for new, untracked files
    git ls-files --others --exclude-standard | xargs -I {} git diff --no-index /dev/null {}

    echo "\n---\nGenerate a commit message that matches the style above and explains the changes and why they were made."
  } | tee >(pbcopy)

  echo "Git commit messages, diff, and prompt copied to clipboard."
}

codecopy() {
  if [ -z "$1" ]; then
    echo "Usage: codecopy <filename>"
    return 1
  fi

  # Search for the file across all subdirectories
  FILE_PATH=$(find . -type f -path "*$1" 2>/dev/null | head -n 1)

  if [ -z "$FILE_PATH" ]; then
    echo "File '$1' not found."
    return 1
  fi

  ABS_PATH=$(realpath "$FILE_PATH")

  # Get line and character count
  LINE_COUNT=$(wc -l < "$ABS_PATH")
  CHAR_COUNT=$(wc -m < "$ABS_PATH")

  # Copy the file path, line/char count, and contents to the clipboard
  {
    echo "File Path: $ABS_PATH"
    echo "Lines: $LINE_COUNT"
    echo "Characters: $CHAR_COUNT"
    echo "----------------------------------------"
    cat "$ABS_PATH"
  } | pbcopy

  echo "File path, line count, character count, and contents of '$ABS_PATH' copied to clipboard."

  # Optional: Bring Google Chrome to the front
  osascript -e 'tell application "Google Chrome" to activate'
}


export ENVIRONMENT=development

# Created by `pipx` on 2025-02-07 14:50:29
export PATH="$PATH:/Users/thushan/.local/bin"
alias python=python3

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## PYTHON
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
