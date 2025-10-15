#!/bin/bash

# Check if we have client ID and secret
if [ "$#" -ne 2 ]; then
    echo "===== Google OAuth Setup for Django Template ====="
    echo ""
    echo "Usage: $0 <client_id> <client_secret>"
    echo ""
    echo "Available Django template projects:"
    gcloud projects list --format="value(projectId)" | grep django-template
    echo ""
    echo "To set up Google OAuth:"
    echo ""
    echo "1. Go to the Google Cloud Console OAuth consent screen:"
    echo "   https://console.cloud.google.com/apis/credentials/consent?project=django-template-1760488570"
    echo ""
    echo "2. Configure the OAuth consent screen:"
    echo "   - User Type: External"
    echo "   - App name: Django Template"
    echo "   - User support email: your-email@example.com"
    echo "   - Developer contact information: your-email@example.com"
    echo ""
    echo "3. Add scopes:"
    echo "   - .../auth/userinfo.profile"
    echo "   - .../auth/userinfo.email"
    echo "   - .../auth/calendar.readonly (if needed)"
    echo ""
    echo "4. Go to the Credentials page:"
    echo "   https://console.cloud.google.com/apis/credentials?project=django-template-1760488570"
    echo ""
    echo "5. Click 'Create Credentials' > 'OAuth client ID'"
    echo "   - Application type: Web application"
    echo "   - Name: Django Template Web Client"
    echo "   - Authorized redirect URIs:"
    echo "     * http://localhost:8000/accounts/google/login/callback/"
    echo "     * http://127.0.0.1:8000/accounts/google/login/callback/"
    echo ""
    echo "6. Click 'Create' and note your Client ID and Client Secret"
    echo ""
    echo "7. Run this script again with your credentials:"
    echo "   $0 <client_id> <client_secret>"
    exit 1
fi

CLIENT_ID="$1"
CLIENT_SECRET="$2"

echo "===== Google OAuth Setup for Django Template ====="
echo ""
echo "Using Client ID: $CLIENT_ID"
echo "Using Client Secret: ${CLIENT_SECRET:0:5}...${CLIENT_SECRET: -5}"
echo ""

# Save credentials to file
cat > google_oauth_credentials.json << EOL
{
  "web": {
    "client_id": "$CLIENT_ID",
    "project_id": "django-template-1760488570",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_secret": "$CLIENT_SECRET",
    "redirect_uris": [
      "http://localhost:8000/accounts/google/login/callback/",
      "http://127.0.0.1:8000/accounts/google/login/callback/"
    ],
    "javascript_origins": [
      "http://localhost:8000",
      "http://127.0.0.1:8000"
    ]
  }
}
EOL

echo "Credentials saved to google_oauth_credentials.json"

# Add credentials to Django database
echo "Adding credentials to Django database..."
cd /Users/iflostcall9182898162/phil/django_template
python add_google_oauth_to_django.py "$CLIENT_ID" "$CLIENT_SECRET"

echo ""
echo "===== Setup Complete! ====="
echo "You can now use Google login at: http://127.0.0.1:8000/accounts/login/"
echo ""
echo "Note: The Django server should be restarted to apply the changes."
