# Environment Variables Documentation

This document describes all environment variables used in the CVD Risk Predictor application.

## Backend Environment Variables

### `ENVIRONMENT`
- **Purpose**: Sets the application environment
- **Values**: `development` or `production`
- **Default**: `development` (if not set, allows all CORS origins)
- **Usage**: Controls CORS behavior and other environment-specific settings

### `ALLOWED_ORIGINS`
- **Purpose**: Comma-separated list of allowed origins for CORS
- **Default**: `http://localhost:3000`
- **Example**: `http://localhost:3000,http://localhost:8000`
- **Production Example**: `https://your-netlify-site.netlify.app,https://www.yourdomain.com`
- **Usage**: Controls which domains can access the API

### `MODEL_DIR`
- **Purpose**: Path to directory containing model files (.pth, .pt)
- **Default**: Empty (models expected in backend directory)
- **Usage**: Allows you to specify a custom location for model files
  - Useful for Netlify Functions where models might be in a different directory
  - Example: `/var/task/models` or relative path like `./models`

## Frontend Environment Variables

### `REACT_APP_API_URL`
- **Purpose**: Backend API URL for the React frontend
- **Default**: `http://localhost:8000` (if not set, falls back to Netlify function)
- **Development**: `http://localhost:8000`
- **Production**: `https://your-backend-url.com` or use Netlify function path `/.netlify/functions/predict`
- **Usage**: Tells the frontend where to send API requests

## Setup Instructions

### Local Development

1. **Backend** (Optional - uses defaults if not set):
   ```bash
   export ENVIRONMENT=development
   export ALLOWED_ORIGINS=http://localhost:3000
   ```

2. **Frontend** - Create `.env` file in `frontend/` directory:
   ```env
   REACT_APP_API_URL=http://localhost:8000
   ```

### Production Deployment

1. **Backend** (Railway/Render/Heroku):
   ```
   ENVIRONMENT=production
   ALLOWED_ORIGINS=https://your-netlify-site.netlify.app
   MODEL_DIR=/app/models  # If models are in a specific directory
   ```

2. **Frontend** (Netlify):
   - In Netlify dashboard: Site settings > Environment variables
   - Add:
     ```
     REACT_APP_API_URL=https://your-backend-url.com
     ```

## Netlify Functions

For Netlify Functions deployment, the `MODEL_DIR` is automatically set to `netlify/functions/models/` if that directory exists.

The function will use models from that directory during execution.

