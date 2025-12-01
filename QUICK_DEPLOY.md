# Quick Deployment Guide - Frontend + Backend

## Current Setup

✅ **Frontend**: Deployed on Netlify (working)  
❌ **Backend**: Needs separate deployment

---

## Step 1: Deploy Backend to Railway

### A. Go to Railway
1. Visit: https://railway.app
2. Sign up/Login (use GitHub - it's easiest)

### B. Create New Project
1. Click **"New Project"**
2. Select **"Deploy from GitHub repo"**
3. Choose your repository: **`AJaroush/risk2`**
4. Railway will detect the repository

### C. Configure Service
1. Click on the new service
2. Go to **Settings** tab
3. Set **Root Directory** to: `backend`
4. Railway will automatically:
   - Detect Python
   - Install dependencies from `requirements.txt`
   - Run the app

### D. Add Environment Variables
1. Go to **Variables** tab
2. Add these variables:
   ```
   ALLOWED_ORIGINS=https://your-netlify-site.netlify.app
   ```
   (Replace with your actual Netlify site URL)

### E. Get Your Backend URL
1. Railway will give you a URL like: `https://your-app.up.railway.app`
2. **Copy this URL** - you'll need it next!

---

## Step 2: Connect Frontend to Backend

### A. Update Netlify Environment Variables
1. Go to **Netlify Dashboard** → Your Site
2. Go to **Site Settings** → **Environment Variables**
3. Click **Add variable**
4. Add:
   - **Key**: `REACT_APP_API_URL`
   - **Value**: `https://your-app.up.railway.app` (the Railway URL from Step 1)
5. Click **Save**

### B. Redeploy Frontend
1. Go to **Deploys** tab in Netlify
2. Click **Trigger deploy** → **Clear cache and deploy site**
3. Wait for deployment to complete

---

## Step 3: Upload Model Files

Since model files are excluded from git (they're too large), you need to upload them:

### Option A: Upload via Railway Dashboard
1. Go to Railway service → **Settings** → **Files**
2. Upload model files to the `backend/` directory:
   - `hypertension.pt`
   - `cimt_reg.pth`
   - `vessel.pth`
   - `fusion_cvd_noskewed.pth`

### Option B: Use Railway CLI
```bash
# Install Railway CLI
npm i -g @railway/cli

# Login
railway login

# Link to your project
railway link

# Upload files
railway upload backend/hypertension.pt
railway upload backend/cimt_reg.pth
railway upload backend/vessel.pth
railway upload backend/fusion_cvd_noskewed.pth
```

### Option C: Add to Repository (If Under 100MB each)
```bash
# Remove from .gitignore temporarily
# Edit .gitignore and comment out model file lines

git add backend/*.pt backend/*.pth
git commit -m "Add model files"
git push
```

---

## Step 4: Test Everything

1. **Test Backend Health**: Visit `https://your-railway-url.up.railway.app/health`
   - Should return: `{"status": "healthy"}`

2. **Test Backend Root**: Visit `https://your-railway-url.up.railway.app/`
   - Should return: `{"message": "CVD Risk Predictor API", "status": "running"}`

3. **Test Frontend**: Visit your Netlify site
   - Try uploading an image and making a prediction

---

## Troubleshooting

### Backend shows 502/503 errors
- Check Railway logs for errors
- Make sure models are uploaded
- Check that port is set correctly (Railway sets `$PORT` automatically)

### Frontend can't connect to backend
- Verify `REACT_APP_API_URL` is set correctly in Netlify
- Check CORS settings in backend (should allow Netlify domain)
- Clear browser cache

### Models not loading
- Verify model files are in `backend/` directory on Railway
- Check file names match exactly (case-sensitive)
- Check Railway logs for file path errors

---

## Alternative: Render.com

If Railway doesn't work, try **Render**:

1. Go to: https://render.com
2. New → Web Service
3. Connect GitHub repo
4. Set:
   - **Root Directory**: `backend`
   - **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`
5. Add environment variables
6. Deploy!

---

## Summary

✅ **Backend**: Deploy to Railway/Render  
✅ **Frontend**: Already on Netlify - just add `REACT_APP_API_URL`  
✅ **Models**: Upload to backend service  
✅ **Connect**: Update Netlify environment variable  

**You're done!** 🎉

