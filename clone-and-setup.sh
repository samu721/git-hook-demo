#!/bin/bash

# ============================================
# Git Clone + Auto-Setup Wrapper Script
# ============================================

set -e  # Exit on any error

echo "🚀 Cloning repository and setting up project..."

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "❌ Error: No repository specified!"
    echo "Usage: ./clone-and-setup.sh <repository-url> [directory-name]"
    exit 1
fi

REPO_URL="$1"
DIR_NAME="${2:-}"  # Optional: directory name (defaults to repo name)

# Clone the repository
if [ -n "$DIR_NAME" ]; then
    git clone "$REPO_URL" "$DIR_NAME"
    cd "$DIR_NAME"
else
    git clone "$REPO_URL"
    # Get the repository name (remove .git if present)
    DIR_NAME=$(basename "$REPO_URL" .git)
    cd "$DIR_NAME"
fi

echo "✅ Repository cloned successfully!"

# Configure git hooks
echo "🔧 Configuring git hooks..."
git config core.hooksPath .githooks
echo "✅ Git hooks configured!"

# Run the build script
echo "🔨 Running build.bash..."
if [ -f "build.bash" ]; then
    chmod +x build.bash
    bash build.bash
    echo "✅ Build completed!"
else
    echo "⚠️  Warning: build.bash not found in repository"
fi

echo ""
echo "============================================"
echo "🎉 Setup complete! You can now start working."
echo "============================================"
echo ""
echo "Directory: $(pwd)"