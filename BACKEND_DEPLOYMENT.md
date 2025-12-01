# Backend Deployment Guide

## The Problem

Netlify is only deploying your **frontend** (React app). Your **backend** (FastAPI) needs to be deployed separately because:

1. **Size Limits**: PyTorch models + dependencies can exceed Netlify's 50MB function limit (500MB on Pro)
2. **Cold Start Issues**: Large functions have slow cold starts
3. **Better Architecture**: Separating frontend and backend is more scalable

## Solution: Deploy Backend Separately

You have **two options**:

---

## Option 1: Deploy to Railway (Recommended) ⭐

**Railway** is perfect for Python/FastAPI backends and has generous limits.

### Steps:

1. **Go to Railway**: https://railway.app
2. **Sign up/Login** (use GitHub login)
3. **New Project** → **Deploy from GitHub repo**
4. **Select your repository**: `AJaroush/risk2`
5. **Configure**:
   - **Root Directory**: `backend`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `python main.py` or use `uvicorn main:app --host 0.0.0.0 --port $PORT`
6. **Add Environment Variables** (if needed):
   - `ALLOWED_ORIGINS`: Your Netlify frontend URL (e.g., `https://your-site.netlify.app`)
   - `PORT`: Railway sets this automatically
7. **Deploy!**

### After Deployment:

1. Railway will give you a URL like: `https://your-app.up.railway.app`
2. Update your Netlify frontend environment variable:
   - In Netlify Dashboard → Site Settings → Environment Variables
   - Add: `REACT_APP_API_URL=https://your-app.up.railway.app`
3. Redeploy your frontend

---

## Option 2: Deploy to Render

**Render** is another great option with free tier.

### Steps:

1. **Go to Render**: https://render.com
2. **Sign up/Login**
3. **New** → **Web Service**
4. **Connect your GitHub repository**
5. **Configure**:
   - **Name**: `cvd-risk-predictor-backend`
   - **Root Directory**: `backend`
   - **Environment**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn main:app --host 0.0.0.0 --port $PORT`
6. **Add Environment Variables**:
   - `ALLOWED_ORIGINS`: Your Netlify frontend URL
7. **Deploy!**

### After Deployment:

Same as Railway - update your Netlify environment variable with the Render URL.

---

## Option 3: Use Netlify Functions (If Models Are Small)

**Only if** your total function size (models + dependencies) < 50MB.

### Steps:

1. **Add model files to repository** (if they fit):
   ```bash
   # Remove model files from .gitignore temporarily
   git add backend/*.pt backend/*.pth
   git commit -m "Add model files for Netlify Functions"
   git push
   ```

2. **Models will be copied during build** (copy_models.py script)

3. **Netlify should automatically deploy the function**

**⚠️ Warning**: This likely won't work due to size limits. PyTorch alone is ~500MB.

---

## Update Frontend Configuration

Once backend is deployed, update your frontend:

### Option A: Use Environment Variable (Recommended)

1. In Netlify Dashboard:
   - Site Settings → Environment Variables
   - Add: `REACT_APP_API_URL=https://your-backend-url.com`
2. Update `frontend/src/App.js` to use the env variable properly

### Option B: Hardcode (Quick Test)

Update `frontend/src/App.js`:
```javascript
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8000';
```

---

## Quick Setup Script

I'll create a Railway-specific configuration file to make deployment easier.

---

## Testing

After deployment:

1. **Check backend health**: Visit `https://your-backend-url.com/health`
2. **Check backend root**: Visit `https://your-backend-url.com/`
3. **Test from frontend**: Try making a prediction

---

## Which Option to Choose?

- **Railway**: ✅ Best for Python backends, easy setup, generous limits
- **Render**: ✅ Good alternative, free tier available
- **Netlify Functions**: ❌ Not recommended due to size limits

**Recommended: Railway** 🚂

