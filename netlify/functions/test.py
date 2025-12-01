"""Simple test function to verify Netlify Functions are working"""
import json

def handler(event, context):
    """Simple test handler"""
    return {
        "statusCode": 200,
        "body": json.dumps({
            "message": "Netlify Function is working!",
            "path": event.get("path", "unknown"),
            "method": event.get("httpMethod", "unknown")
        }),
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        }
    }

