# Push to GitHub Risk2 Repository

## Repository
**https://github.com/Cjw01-01/Risk2**

This repository is currently empty and ready to receive your code.

## Quick Push Commands

Run these commands in your terminal from the project directory:

```bash
# 1. Initialize git (if not already done)
git init

# 2. Add the remote repository
git remote add origin https://github.com/Cjw01-01/Risk2.git

# 3. Add all files to staging
git add .

# 4. Commit the changes
git commit -m "Initial commit: CVD Risk Predictor with Netlify Functions setup"

# 5. Set default branch to main
git branch -M main

# 6. Push to GitHub
git push -u origin main
```

## Or Use the Automated Script

```bash
./push-to-risk2.sh
```

## What Will Be Pushed

All project files including:
- ✅ Frontend React application
- ✅ Backend FastAPI code
- ✅ Netlify Functions configuration
- ✅ Model architecture definitions
- ✅ Documentation files
- ✅ Build scripts and configuration
- ✅ Fixed CIMT preprocessing bug
- ✅ Improved error handling

**Note:** Model files (*.pth, *.pt) are excluded by .gitignore due to size limits.

## Authentication

When you push, GitHub will ask for credentials:

**Option 1: Personal Access Token (Recommended)**
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Select `repo` scope/permissions
4. Copy the token
5. Use your GitHub username and the token as password

**Option 2: SSH Keys**
```bash
# Change remote to SSH
git remote set-url origin git@github.com:Cjw01-01/Risk2.git
```

## Troubleshooting

**If remote already exists:**
```bash
git remote remove origin
git remote add origin https://github.com/Cjw01-01/Risk2.git
```

**If push fails due to authentication:**
- Make sure you're using a Personal Access Token, not your GitHub password
- Tokens expire - generate a new one if needed

**Check what will be committed:**
```bash
git status
```

**View remote configuration:**
```bash
git remote -v
```

## After Pushing

Once successfully pushed:
1. ✅ Check your repository: https://github.com/Cjw01-01/Risk2
2. ✅ All files should be visible in the repository
3. ✅ You can now connect this repo to Netlify for automatic deployments

## Next Steps

After pushing to Risk2:
1. Update Netlify to use this new repository
2. The build should now work with the fixes we applied
3. Monitor the Netlify build in the dashboard

