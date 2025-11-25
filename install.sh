#!/bin/bash

# Define variables
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# List of files to symlink 
# Format: "folder/filename:target_in_home"
# Example: "vim/.vimrc:.vimrc" maps ~/dotfiles/vim/.vimrc to ~/.vimrc
FILES_TO_LINK=(
    "vim/.vimrc:.vimrc"
    "bash/.bash_common:.bash_common"
    "tmux/.tmux.conf:.tmux.conf"
)

create_symlinks() {
    echo "Creating symlinks..."
    mkdir -p "$BACKUP_DIR"
    
    for mapping in "${FILES_TO_LINK[@]}"; do
        KEY="${mapping%%:*}"
        VAL="${mapping##*:}"
        
        SOURCE="$DOTFILES_DIR/$KEY"
        TARGET="$HOME/$VAL"

        # 1. Backup existing file if it's not already a symlink to our source
        if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]; then
            echo "Backing up existing $VAL to $BACKUP_DIR"
            mv "$TARGET" "$BACKUP_DIR"
        fi

        # 2. Remove existing symlink if it exists (to refresh it)
        if [ -L "$TARGET" ]; then
            unlink "$TARGET"
        fi

        # 3. Create the new symlink
        ln -s "$SOURCE" "$TARGET"
        echo "Linked $SOURCE -> $TARGET"
    done
    
    # Cleanup backup dir if empty
    if [ -z "$(ls -A $BACKUP_DIR)" ]; then
       rmdir "$BACKUP_DIR"
    else
       echo "Backups saved to $BACKUP_DIR"
    fi
}

create_symlinks

# --- Update .bashrc safely ---
TARGET_RC="$HOME/.bashrc"

# Check if .bashrc already sources .bash_common
if grep -q "source ~/.bash_common" "$TARGET_RC"; then
    echo "Skipping: .bash_common is already sourced in $TARGET_RC"
else
    echo "Appending source command to $TARGET_RC..."
    cat <<EOT >> "$TARGET_RC"

# --- Load Common Dotfiles ---
if [ -f ~/.bash_common ]; then
    source ~/.bash_common
fi
EOT
fi
