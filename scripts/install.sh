#!/bin/bash

echo "🚀 Installing DevOps 180 Challenge CLI..."

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Make scripts executable
chmod +x "$SCRIPT_DIR/devops"
chmod +x "$SCRIPT_DIR/install.sh"

# Create symlink in user's local bin directory
mkdir -p ~/bin
ln -sf "$SCRIPT_DIR/devops" ~/bin/devops

# Add ~/bin to PATH if not already there
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "" >> ~/.bashrc
    echo "# DevOps 180 Challenge" >> ~/.bashrc
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
    
    # Also add to zshrc if it exists
    if [ -f ~/.zshrc ]; then
        echo "" >> ~/.zshrc
        echo "# DevOps 180 Challenge" >> ~/.zshrc
        echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
    fi
    
    echo "📝 Added ~/bin to PATH in your shell configuration"
    echo "   Please run: source ~/.bashrc (or source ~/.zshrc)"
fi

echo "✅ Installation complete!"
echo ""
echo "To get started:"
echo "  1. Reload your shell: source ~/.bashrc"
echo "  2. Start Day 1: devops start"
echo "  3. Check status: devops status"
echo ""
echo "Happy learning! 🎉"