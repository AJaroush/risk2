@echo off
REM Build script for Windows (local testing)

echo 🔧 Starting build process...

REM Try to copy models (optional)
echo 📦 Attempting to copy model files...
python netlify\functions\copy_models.py 2>nul || echo ⚠️  Model copy skipped

REM Build the frontend
echo 🏗️  Building frontend...
cd frontend
call npm install
call npm run build
cd ..

echo ✅ Build completed successfully!

