# Netlify Functions entry point
from .predict import handler, lambda_handler

__all__ = ['handler', 'lambda_handler']


