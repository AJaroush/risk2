#!/bin/bash

# Script to push changes to GitHub repository
# Repository: https://github.com/Cjw01-01/CVDRiskPredictor

echo "========================================"
echo "Pushing Changes to GitHub"
echo "Repository: https://github.com/Cjw01-01/CVDRiskPredictor"
echo "========================================"
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "[1/6] Initializing git repository..."
    git init
else
    echo "[1/6] Git repository already initialized"
fi

# Add remote (remove existing if any, then add)
echo "[2/6] Setting up remote repository..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/Cjw01-01/CVDRiskPredictor.git

# Verify remote
echo "[3/6] Verifying remote..."
git remote -v

# Add all files
echo "[4/6] Adding all files..."
git add .

# Show what will be committed
echo ""
echo "Files to be committed:"
git status --short

# Commit changes
echo ""
echo "[5/6] Committing changes..."
git commit -m "Fix Netlify build: simplify build command, add Node version spec, and improve error handling

- Simplified netlify.toml build command (removed Python dependency from build)
- Made copy_models.py exit gracefully if files missing
- Added .nvmrc file for Node 18 compatibility
- Added engines specification to package.json
- Fixed CIMT preprocessing bug (using correct 224x224 size)
- Improved CORS configuration with environment variable support
- Added file existence checks for model loading
- Created build scripts and documentation"

# Push to GitHub
echo "[6/6] Pushing to GitHub..."
echo ""
echo "⚠️  You may be prompted for GitHub credentials"
echo ""

# Set default branch to main
git branch -M main

# Push to origin
git push -u origin main

echo ""
echo "========================================"
if [ $? -eq 0 ]; then
    echo "✅ SUCCESS! Changes pushed to GitHub"
else
    echo "❌ Push failed. Please check the error above."
    echo ""
    echo "If you need to authenticate:"
    echo "1. Use GitHub Personal Access Token as password"
    echo "2. Or set up SSH keys for passwordless push"
fi
echo "========================================"
echo ""
echo "Repository: https://github.com/Cjw01-01/CVDRiskPredictor"
echo ""

