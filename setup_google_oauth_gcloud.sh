#!/bin/bash
set -e

echo "===== Google OAuth Setup for Django Template using gcloud ====="
echo "This script will:"
echo "1. Create a Google Cloud project"
echo "2. Enable necessary APIs"
echo "3. Create OAuth credentials"
echo "4. Add them to the Django database"
echo ""

# Generate a unique project ID
PROJECT_ID="django-template-$(date +%s)"
PROJECT_NAME="Django Template"

echo "Creating Google Cloud project: $PROJECT_NAME ($PROJECT_ID)..."
gcloud projects create $PROJECT_ID --name="$PROJECT_NAME"

echo "Setting project as default..."
gcloud config set project $PROJECT_ID

echo "Enabling necessary APIs..."
gcloud services enable people.googleapis.com calendar-json.googleapis.com oauth2.googleapis.com

# Check if user is authenticated
echo "Checking authentication..."
gcloud auth list --filter=status:ACTIVE --format="value(account)" || {
  echo "You need to authenticate with Google Cloud. Running 'gcloud auth login'..."
  gcloud auth login
}

# Create OAuth consent screen
echo "Creating OAuth consent screen..."
echo "This step requires manual intervention in the Google Cloud Console."
echo "Please go to: https://console.cloud.google.com/apis/credentials/consent?project=$PROJECT_ID"
echo "And set up the OAuth consent screen with the following settings:"
echo "- User Type: External"
echo "- App name: Django Template"
echo "- User support email: your-email@example.com"
echo "- Developer contact information: your-email@example.com"
echo "- Scopes: .../auth/userinfo.profile, .../auth/userinfo.email, .../auth/calendar.readonly"
echo ""
read -p "Press Enter once you've completed the OAuth consent screen setup..."

# Create OAuth client ID
echo "Creating OAuth client ID..."
echo "Please go to: https://console.cloud.google.com/apis/credentials?project=$PROJECT_ID"
echo "And create an OAuth client ID with the following settings:"
echo "- Application type: Web application"
echo "- Name: Django Template Web Client"
echo "- Authorized redirect URIs:"
echo "  * http://localhost:8000/accounts/google/login/callback/"
echo "  * http://127.0.0.1:8000/accounts/google/login/callback/"
echo ""
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
