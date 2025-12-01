#!/bin/bash
set -e  # Exit on error

echo "🔧 Starting build process..."

# Try to copy models (optional - don't fail if it doesn't work)
echo "📦 Attempting to copy model files..."
if command -v python3 &> /dev/null; then
    python3 netlify/functions/copy_models.py || echo "⚠️  Model copy skipped (models may be added manually)"
else
    echo "⚠️  Python not available in build environment - model copy skipped"
fi

# Build the frontend
echo "🏗️  Building frontend..."
cd frontend
npm install
npm run build
cd ..

echo "✅ Build completed successfully!"

