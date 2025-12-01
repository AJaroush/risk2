#!/bin/bash

# Script to push changes to GitHub Risk2 repository
# Repository: https://github.com/Cjw01-01/Risk2

echo "========================================"
echo "Pushing to GitHub Risk2 Repository"
echo "Repository: https://github.com/Cjw01-01/Risk2"
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
git remote add origin https://github.com/Cjw01-01/Risk2.git

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
git commit -m "Initial commit: CVD Risk Predictor with Netlify Functions setup

- Full-stack application with FastAPI backend and React frontend
- 4 deep learning models for CVD risk prediction
- Netlify Functions configuration for serverless deployment
- Fixed CIMT preprocessing bug (224x224 input size)
- Improved error handling and CORS configuration
- Added Node version specification for compatibility"

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
    echo "✅ SUCCESS! Code pushed to Risk2 repository"
else
    echo "❌ Push failed. Please check the error above."
    echo ""
    echo "If you need to authenticate:"
    echo "1. Use GitHub Personal Access Token as password"
    echo "2. Or set up SSH keys for passwordless push"
fi
echo "========================================"
echo ""
echo "Repository: https://github.com/Cjw01-01/Risk2"
echo ""

