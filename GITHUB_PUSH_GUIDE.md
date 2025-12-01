# Guide: Push Changes to GitHub Manually

## Quick Push Commands

Run these commands in your terminal from the project directory:

```bash
# 1. Initialize git (if not already done)
git init

# 2. Add the remote repository
git remote add origin https://github.com/Cjw01-01/CVDRiskPredictor.git
# If remote already exists, remove it first:
# git remote remove origin
# git remote add origin https://github.com/Cjw01-01/CVDRiskPredictor.git

# 3. Add all files to staging
git add .

# 4. Commit the changes
git commit -m "Fix Netlify build: simplify build command, add Node version spec, and improve error handling"

# 5. Set default branch to main
git branch -M main

# 6. Push to GitHub
git push -u origin main
```

## Or Use the Script

You can also run the automated script:

```bash
./push-changes.sh
```

## What Will Be Pushed

The following changes will be pushed:
- ✅ Simplified Netlify build configuration
- ✅ Fixed CIMT preprocessing bug
- ✅ Added Node version specification (.nvmrc)
- ✅ Improved error handling in copy_models.py
- ✅ Better CORS configuration
- ✅ New documentation files

## Authentication

If you're prompted for credentials:

**Option 1: Personal Access Token (Recommended)**
- Go to GitHub Settings → Developer settings → Personal access tokens
- Create a new token with `repo` permissions
- Use your username and the token as password

**Option 2: SSH Keys**
- Set up SSH keys with GitHub for passwordless authentication
- Change remote URL to: `git@github.com:Cjw01-01/CVDRiskPredictor.git`

## Troubleshooting

If you get "repository already exists" error:
```bash
git remote remove origin
git remote add origin https://github.com/Cjw01-01/CVDRiskPredictor.git
```

If you get authentication errors:
- Use a Personal Access Token instead of password
- Or set up SSH keys

If you need to check what files will be committed:
```bash
git status
```

## After Pushing

Once pushed successfully:
1. Check your repository: https://github.com/Cjw01-01/CVDRiskPredictor
2. Netlify should automatically trigger a new build
3. Monitor the build in Netlify dashboard

