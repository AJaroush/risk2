# Netlify Combined Setup - Frontend + Backend Together

## ✅ Configuration Complete!

Your project is now set up to run **both frontend and backend together on Netlify** using Netlify Functions!

---

## How It Works

### Frontend (React)
- ✅ Builds and deploys to Netlify
- ✅ Served as static files from `frontend/build`

### Backend (FastAPI)
- ✅ Runs as a Netlify Function (serverless)
- ✅ Accessible via `/api/*` redirects
- ✅ Handles all API requests

### Request Flow

```
Frontend Request: /api/predict
    ↓
Netlify Redirect: /.netlify/functions/predict/predict
    ↓
FastAPI Handler: /predict endpoint
    ↓
Response returns to frontend
```

---

## ⚠️ Important: Model Files Size Limit

**Netlify Functions have size limits:**
- **Free tier**: 50MB per function
- **Pro tier**: 500MB per function

PyTorch + your models might exceed this. Here are your options:

---

## Option 1: Use Git LFS for Models (Recommended)

If models are under GitHub's 100MB limit:

### Steps:

1. **Install Git LFS** (if not installed):
   ```bash
   # macOS
   brew install git-lfs
   
   # Initialize Git LFS
   git lfs install
   ```

2. **Track model files**:
   ```bash
   git lfs track "*.pt"
   git lfs track "*.pth"
   ```

3. **Update .gitignore** - Remove model exclusions:
   ```bash
   # Comment out or remove these lines from .gitignore:
   # *.pth
   # *.pt
   ```

4. **Add models to repository**:
   ```bash
   git add backend/*.pt backend/*.pth
   git add .gitattributes
   git commit -m "Add model files via Git LFS"
   git push
   ```

5. **Models will be copied during build** (copy_models.py script)

---

## Option 2: Store Models Externally

If models are too large for Git/GitHub:

### Use Cloud Storage (S3, Google Cloud, etc.)

1. **Upload models to cloud storage**
2. **Download during function initialization**
3. **Cache in function** (models persist between warm invocations)

### Example: Download from URL

Update `netlify/functions/predict.py` to download models if missing:

```python
import urllib.request

def ensure_models():
    models_dir = os.path.join(current_dir, 'models')
    os.makedirs(models_dir, exist_ok=True)
    
    model_urls = {
        'hypertension.pt': 'https://your-storage.com/models/hypertension.pt',
        # ... other models
    }
    
    for filename, url in model_urls.items():
        path = os.path.join(models_dir, filename)
        if not os.path.exists(path):
            print(f"Downloading {filename}...")
            urllib.request.urlretrieve(url, path)
```

---

## Option 3: Netlify Pro (If Available)

If you have Netlify Pro:
- 500MB function limit
- Should handle PyTorch + models
- Models can be committed to repo

---

## Current Setup

### ✅ What's Configured

1. **netlify.toml**:
   - ✅ Build command for frontend
   - ✅ Functions directory configured
   - ✅ API redirects set up
   - ✅ Function timeout set

2. **Netlify Function**:
   - ✅ `netlify/functions/predict.py` - FastAPI wrapper
   - ✅ Requirements.txt with all dependencies
   - ✅ Python 3.11 runtime

3. **Frontend**:
   - ✅ Uses `/api` path in production
   - ✅ Falls back to localhost for development

### 📋 What You Need to Do

1. **Add model files** (choose one option above)
2. **Deploy to Netlify** (automatic via GitHub)
3. **Test the API** endpoints

---

## Deployment Steps

### 1. Prepare Model Files

Choose one of the options above (Git LFS, external storage, or Pro tier)

### 2. Deploy to Netlify

Netlify will automatically:
- Build the frontend
- Set up the function
- Configure redirects

### 3. Verify Deployment

1. **Check frontend**: Visit your Netlify site
2. **Check backend health**: Visit `https://your-site.netlify.app/.netlify/functions/predict/health`
3. **Test API**: Visit `https://your-site.netlify.app/.netlify/functions/predict/`

### 4. Test from Frontend

- Upload an image
- Make a prediction
- Check browser console for errors

---

## Troubleshooting

### Function Not Found (404)

**Check:**
- Function is in `netlify/functions/` directory
- Function file is named correctly (matches redirect path)
- Function has `lambda_handler` function

**Fix:**
```bash
# Verify function structure
ls -la netlify/functions/predict.py
```

### Models Not Loading

**Check:**
- Models are in `netlify/functions/models/` directory
- Model paths in backend code match actual file names
- Check function logs in Netlify dashboard

**Fix:**
- Upload models manually via Netlify dashboard
- Or use external storage and download on init

### Function Timeout

**Check:**
- Model loading takes too long
- Cold start is slow

**Fix:**
- Increase timeout in `netlify.toml` (max 26s free, 50s Pro)
- Optimize model loading
- Use function warming strategies

### Import Errors

**Check:**
- All dependencies in `netlify/functions/requirements.txt`
- Python version matches `runtime.txt`

**Fix:**
```bash
# Verify requirements
cat netlify/functions/requirements.txt
```

---

## File Structure

```
your-repo/
├── frontend/              # React frontend
│   ├── src/
│   └── build/            # Built files (deployed)
├── backend/              # FastAPI backend
│   ├── main.py
│   └── *.pt, *.pth      # Model files (need to add)
├── netlify/
│   └── functions/
│       ├── predict.py    # Function handler
│       ├── requirements.txt
│       ├── runtime.txt
│       └── models/       # Models copied here during build
└── netlify.toml         # Netlify configuration
```

---

## Environment Variables

Set in Netlify Dashboard → Site Settings → Environment Variables:

- `ALLOWED_ORIGINS`: Your Netlify site URL (for CORS)
- `MODEL_DIR`: Path to models (optional, auto-detected)

---

## Quick Start Checklist

- [ ] Choose model file storage option (Git LFS, external, or Pro)
- [ ] Add model files to repository or configure external storage
- [ ] Push code to GitHub
- [ ] Netlify automatically builds and deploys
- [ ] Test `/health` endpoint
- [ ] Test prediction from frontend
- [ ] Check function logs if issues occur

---

## Summary

✅ **Frontend**: Deploys as static site  
✅ **Backend**: Runs as Netlify Function  
✅ **Routing**: `/api/*` → Function  
✅ **Ready**: Just add model files!

**The hard part is model files - once those are handled, everything should work!** 🚀

