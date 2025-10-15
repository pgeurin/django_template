#!/bin/bash
set -e

echo "===== Complete Google OAuth Setup for Django Template ====="
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
gcloud services enable people.googleapis.com calendar-json.googleapis.com

# Create OAuth consent screen
echo "Creating OAuth consent screen..."
cat > consent_request.json << EOL
{
  "support_email": "admin@example.com",
  "application_name": "Django Template",
  "developer_email": "admin@example.com",
  "scopes": ["profile", "email", "https://www.googleapis.com/auth/calendar.readonly"]
}
EOL

# Create OAuth credentials
echo "Creating OAuth credentials..."
cat > credentials_request.json << EOL
{
  "name": "Django Template Web Client",
  "redirect_uris": [
    "http://localhost:8000/accounts/google/login/callback/",
    "http://127.0.0.1:8000/accounts/google/login/callback/"
  ],
  "javascript_origins": [
    "http://localhost:8000",
    "http://127.0.0.1:8000"
  ]
}
EOL

# Use gcloud to create OAuth client
echo "Creating OAuth client..."
CLIENT_INFO=$(gcloud auth application-default print-access-token | curl -s -X POST \
  -H "Authorization: Bearer $(cat)" \
  -H "Content-Type: application/json" \
  -d @credentials_request.json \
  "https://console.developers.google.com/apis/credentials/oauthclient?project=$PROJECT_ID")

# Extract client ID and secret
CLIENT_ID=$(echo $CLIENT_INFO | jq -r '.client_id')
CLIENT_SECRET=$(echo $CLIENT_INFO | jq -r '.client_secret')

if [ -z "$CLIENT_ID" ] || [ "$CLIENT_ID" == "null" ]; then
  echo "Failed to get client ID. Manual setup will be required."
  echo "Please follow the instructions in google_oauth_manual_setup.md"
  exit 1
fi

echo "Successfully created OAuth credentials!"
echo "Client ID: $CLIENT_ID"
echo "Client Secret: $CLIENT_SECRET"

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
echo "If you encounter any issues, please check google_oauth_manual_setup.md for troubleshooting."
