#!/bin/bash

echo "===== Google OAuth Setup Helper for Django Template ====="
echo ""
echo "This script will guide you through setting up Google OAuth and adding the credentials to Django."
echo ""

# Check if we have client ID and secret
if [ "$#" -ne 2 ]; then
    echo "Please follow these steps to create Google OAuth credentials:"
    echo ""
    echo "1. Go to https://console.cloud.google.com/"
    echo "2. Create a new project or select an existing one"
    echo "3. Go to 'APIs & Services' > 'OAuth consent screen'"
    echo "4. Configure the consent screen (External user type)"
    echo "5. Add scopes: profile, email, calendar.readonly"
    echo "6. Go to 'APIs & Services' > 'Credentials'"
    echo "7. Click 'Create Credentials' > 'OAuth client ID'"
    echo "8. Select 'Web application'"
    echo "9. Add these authorized redirect URIs:"
    echo "   - http://localhost:8000/accounts/google/login/callback/"
    echo "   - http://127.0.0.1:8000/accounts/google/login/callback/"
    echo "10. Click 'Create' and note your Client ID and Client Secret"
    echo ""
    echo "Then run this script again with your credentials:"
    echo "  $0 <client_id> <client_secret>"
    exit 1
fi

CLIENT_ID="$1"
CLIENT_SECRET="$2"

echo "Using Client ID: $CLIENT_ID"
echo "Using Client Secret: ${CLIENT_SECRET:0:5}...${CLIENT_SECRET: -5}"

# Add credentials to Django database
echo "Adding credentials to Django database..."
cd /Users/iflostcall9182898162/phil/django_template
python add_google_oauth_to_django.py "$CLIENT_ID" "$CLIENT_SECRET"

echo ""
echo "===== Setup Complete! ====="
echo "You can now use Google login at: http://127.0.0.1:8000/accounts/login/"
