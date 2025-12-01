# 🔧 Fix Netlify Function - Complete Guide

## Current Setup ✅

Your backend IS configured to run on Netlify! The function is set up correctly.

## What's Fixed

1. ✅ Function handler name corrected (`handler` function)
2. ✅ Error handling added
3. ✅ CORS headers added
4. ✅ Test function created

## How to Verify It's Working

### Step 1: Check Function Deployment

1. Go to **Netlify Dashboard** → Your Site
2. Click on **Functions** tab
3. You should see:
   - `predict` function listed
   - `test` function listed (simple test)

### Step 2: Test the Function Directly

After deployment, try these URLs:

**Test Function** (should always work):
```
https://your-site.netlify.app/.netlify/functions/test
```

**Health Check**:
```
https://your-site.netlify.app/.netlify/functions/predict/health
```

**Root Endpoint**:
```
https://your-site.netlify.app/.netlify/functions/predict/
```

### Step 3: Check Function Logs

1. Netlify Dashboard → Functions → `predict`
2. Click on **View logs**
3. Look for:
   - Import errors
   - Missing dependencies
   - Model file errors

## Common Issues & Fixes

### Issue 1: Function Not Listed

**Problem**: Function doesn't appear in Functions tab

**Fix**:
- Verify `netlify/functions/predict.py` exists
- Check that file has `handler` function
- Rebuild and redeploy

### Issue 2: 404 Error

**Problem**: `/api/predict` returns 404

**Check**:
1. Function is deployed (see Step 1)
2. Redirect is working (check netlify.toml)
3. Try direct function URL first

**Fix**: If function works directly but redirect doesn't:
- The redirect path might be wrong
- Check browser console for actual error

### Issue 3: Import Errors

**Problem**: Function logs show import errors

**Fix**:
1. Check `netlify/functions/requirements.txt` has all dependencies
2. Verify Python version in `runtime.txt`
3. Check that backend code is accessible

### Issue 4: Models Not Found

**Problem**: Models can't be loaded

**Fix**:
1. Models need to be in `netlify/functions/models/` directory
2. Upload models manually OR
3. Use external storage (S3, etc.) and download on init

## File Structure

```
netlify/functions/
├── predict.py          # Main function (FastAPI backend)
├── test.py             # Simple test function
├── requirements.txt    # Python dependencies
├── runtime.txt         # Python version
├── __init__.py        # Package init
└── models/            # Model files go here (if added)
```

## Next Steps

1. **Commit and push** these fixes
2. **Wait for Netlify to rebuild**
3. **Check Functions tab** in dashboard
4. **Test function directly** first
5. **Then test via redirect** (`/api/predict`)

## If Still Not Working

If the function still doesn't work after these fixes:

1. Check Netlify build logs for errors
2. Check function logs for runtime errors
3. Verify all dependencies are installed
4. Consider that models might be too large (50MB limit)

**The function structure is now correct - it should work!**

