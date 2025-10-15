#!/bin/bash

echo "===== Google OAuth Setup Guide for Django Template ====="
echo ""

# Get existing project ID
echo "Available Django template projects:"
gcloud projects list --format="value(projectId)" | grep django-template

echo ""
echo "Please select one of the above project IDs or create a new one."
read -p "Enter project ID to use (or press Enter to create a new one): " PROJECT_ID

if [ -z "$PROJECT_ID" ]; then
  # Create a new project
  PROJECT_ID="django-template-$(date +%s)"
  echo "Creating new project: $PROJECT_ID"
  gcloud projects create $PROJECT_ID --name="Django Template"
fi

# Set as default project
echo "Setting $PROJECT_ID as default project..."
gcloud config set project $PROJECT_ID

# Enable APIs
echo "Enabling necessary APIs..."
gcloud services enable people.googleapis.com || true
gcloud services enable calendar-json.googleapis.com || true

# Guide through OAuth setup
echo ""
echo "==== MANUAL STEPS REQUIRED ===="
echo ""
echo "1. Go to the Google Cloud Console OAuth consent screen:"
echo "   https://console.cloud.google.com/apis/credentials/consent?project=$PROJECT_ID"
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
echo "   https://console.cloud.google.com/apis/credentials?project=$PROJECT_ID"
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

# Get credentials
read -p "Enter the Client ID: " CLIENT_ID
read -p "Enter the Client Secret: " CLIENT_SECRET

# Verify the credentials
if [ -z "$CLIENT_ID" ] || [ -z "$CLIENT_SECRET" ]; then
  echo "Error: Client ID or Client Secret cannot be empty."
  exit 1
fi

echo "Successfully obtained OAuth credentials!"
echo "Client ID: $CLIENT_ID"
echo "Client Secret: ${CLIENT_SECRET:0:5}...${CLIENT_SECRET: -5}"

# Save credentials to file
cat > google_oauth_credentials.json << EOL
{
  "web": {
    "client_id": "$CLIENT_ID",
    "project_id": "$PROJECT_ID",
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
