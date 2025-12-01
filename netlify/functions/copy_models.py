"""
Script to copy model files to netlify functions directory for deployment
Run this before deploying to ensure models are available
This script exits gracefully if files are missing (won't fail the build)
"""
import shutil
import os
import sys

def copy_models():
    """Copy model files from backend to netlify functions directory"""
    backend_dir = os.path.join(os.path.dirname(__file__), '../../backend')
    functions_dir = os.path.dirname(__file__)
    models_dir = os.path.join(functions_dir, 'models')
    
    # Create models directory if it doesn't exist
    os.makedirs(models_dir, exist_ok=True)
    
    model_files = [
        'hypertension.pt',
        'cimt_reg.pth',
        'vessel.pth',
        'fusion_cvd_noskewed.pth'
    ]
    
    copied = []
    for model_file in model_files:
        src = os.path.join(backend_dir, model_file)
        dst = os.path.join(models_dir, model_file)
        
        if os.path.exists(src):
            try:
                shutil.copy2(src, dst)
                copied.append(model_file)
                print(f"✓ Copied {model_file}")
            except Exception as e:
                print(f"✗ Error copying {model_file}: {e}")
        else:
            print(f"⚠ Not found: {model_file} (skipping)")
    
    print(f"\nCopied {len(copied)}/{len(model_files)} model files")
    
    # Don't fail the build if models are missing - just warn
    if len(copied) == 0:
        print("⚠ WARNING: No model files were copied. Models should be added to the repository or uploaded separately.")
    elif len(copied) < len(model_files):
        print(f"⚠ WARNING: Only {len(copied)}/{len(model_files)} model files were copied. Some models may be missing.")
    
    # Always exit successfully to not break the build
    return 0

if __name__ == '__main__':
    sys.exit(copy_models())


