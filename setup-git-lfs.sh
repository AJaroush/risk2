#!/bin/bash

# Script to set up Git LFS for model files

echo "========================================"
echo "Setting up Git LFS for Model Files"
echo "========================================"
echo ""

# Check if git-lfs is installed
if ! command -v git lfs &> /dev/null; then
    echo "❌ Git LFS is not installed!"
    echo ""
    echo "Install it:"
    echo "  macOS: brew install git-lfs"
    echo "  Linux: apt-get install git-lfs"
    echo "  Windows: Download from https://git-lfs.github.com"
    exit 1
fi

echo "✅ Git LFS is installed"
echo ""

# Initialize Git LFS
echo "[1/4] Initializing Git LFS..."
git lfs install
echo ""

# Track model file extensions
echo "[2/4] Tracking model file extensions..."
git lfs track "*.pt"
git lfs track "*.pth"
echo ""

# Update .gitignore to allow tracked files
echo "[3/4] Updating .gitignore..."
# Create backup
cp .gitignore .gitignore.backup

# Comment out model file exclusions
sed -i.bak 's/^\*\\.pth$/# *.pth/' .gitignore
sed -i.bak 's/^\*\\.pt$/# *.pt/' .gitignore
sed -i.bak 's/^\*\*\/*\.pth$/# **\/*.pth/' .gitignore
sed -i.bak 's/^\*\*\/*\.pt$/# **\/*.pt/' .gitignore

# Remove specific backend exclusions
sed -i.bak '/^backend\/\*\.pth$/d' .gitignore
sed -i.bak '/^backend\/\*\.pt$/d' .gitignore

echo "✅ .gitignore updated (backup saved as .gitignore.backup)"
echo ""

# Check if model files exist
echo "[4/4] Checking for model files..."
model_files=$(find backend -name "*.pt" -o -name "*.pth" 2>/dev/null)

if [ -z "$model_files" ]; then
    echo "⚠️  No model files found in backend/ directory"
    echo ""
    echo "Please add your model files to backend/ directory:"
    echo "  - hypertension.pt"
    echo "  - cimt_reg.pth"
    echo "  - vessel.pth"
    echo "  - fusion_cvd_noskewed.pth"
    echo ""
    echo "Then run:"
    echo "  git add backend/*.pt backend/*.pth"
    echo "  git add .gitattributes"
    echo "  git commit -m 'Add model files via Git LFS'"
    echo "  git push"
else
    echo "✅ Found model files:"
    echo "$model_files" | while read file; do
        size=$(du -h "$file" | cut -f1)
        echo "  - $file ($size)"
    done
    echo ""
    echo "Next steps:"
    echo "  git add backend/*.pt backend/*.pth"
    echo "  git add .gitattributes .gitignore"
    echo "  git commit -m 'Add model files via Git LFS'"
    echo "  git push"
fi

echo ""
echo "========================================"
echo "Setup Complete!"
echo "========================================"

