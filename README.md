# Django Template

A production-ready Django starter template with authentication (email/password + Google OAuth), API examples, and modern UI.

## ✨ Features

- 🔐 **Complete Authentication**
  - Email/password registration and login
  - Google OAuth integration
  - Custom User model ready to extend
  
- 🚀 **API Ready**
  - Example public API endpoint
  - Example protected (authenticated) API endpoint
  - JSON responses with proper status codes
  
- 🎨 **Modern UI**
  - Clean, responsive homepage
  - Built-in templates extending a base layout
  - Easy to customize styling
  
- 🧪 **Full Test Suite**
  - Unit tests for all views and models
  - API endpoint tests
  - Authentication flow tests
  
- 📦 **Production Ready**
  - PostgreSQL and SQLite support
  - WhiteNoise for static files
  - Environment-based configuration
  - CORS handling built-in

## 🚀 Quick Start

### 1. Clone and Setup

```bash
# Clone the repository
git clone https://github.com/pgeurin/django_template.git
cd django_template

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 2. Configure Environment

```bash
# Copy the example env file
cp .env.example .env

# Edit .env with your settings (optional - works with defaults)
```

### 3. Run Migrations

```bash
cd django_app
python manage.py migrate
```

### 4. Create Superuser

```bash
python manage.py createsuperuser
```

### 5. Run Development Server

```bash
python manage.py runserver
```

Visit http://localhost:8000 to see your app!

## 📚 Project Structure

```
django_template/
├── django_app/
│   ├── main/                  # Main application
│   │   ├── models.py          # Custom User model
│   │   ├── views.py           # Views (home, API endpoints)
│   │   ├── urls.py            # URL routing
│   │   ├── admin.py           # Admin configuration
│   │   ├── tests.py           # Test suite
│   │   └── templates/         # HTML templates
│   │       └── main/
│   │           ├── base.html  # Base template
│   │           └── home.html  # Homepage
│   ├── heyyoufree/            # Django project settings
│   │   ├── settings.py        # Main settings
│   │   ├── urls.py            # Root URL config
│   │   └── wsgi.py            # WSGI config
│   ├── manage.py              # Django management script
│   └── db.sqlite3             # SQLite database (dev)
├── requirements.txt           # Python dependencies
├── requirements.prod.txt      # Production dependencies
├── .env.example               # Environment variables template
├── .gitignore                 # Git ignore rules
└── README.md                  # This file
```

## 🔌 API Endpoints

### Public Endpoint
```bash
GET /api/example/
```
Returns example JSON data - no authentication required.

**Response:**
```json
{
  "status": "success",
  "message": "This is an example API endpoint",
  "data": {
    "items": ["item1", "item2", "item3"],
    "count": 3
  }
}
```

### Protected Endpoint
```bash
GET /api/protected/
POST /api/protected/
```
Requires authentication. Returns user information on GET, echoes back POST data.

**GET Response:**
```json
{
  "status": "success",
  "message": "You are authenticated!",
  "user": {
    "email": "user@example.com",
    "id": 1
  }
}
```

## 🔐 Setting Up Google OAuth

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google+ API
4. Create OAuth 2.0 credentials
5. Add authorized redirect URIs:
   - http://localhost:8000/accounts/google/login/callback/
   - Your production domain callback URL
6. Add credentials to `.env`:
   ```
   GOOGLE_CLIENT_ID=your-client-id
   GOOGLE_CLIENT_SECRET=your-client-secret
   ```
7. Run migrations and start server
8. Go to http://localhost:8000/admin/
9. Add a "Social application":
   - Provider: Google
   - Name: Google OAuth
   - Client ID: (from .env)
   - Secret key: (from .env)
   - Sites: Select your site

## 🧪 Running Tests

```bash
cd django_app
python manage.py test main
```

Or with pytest:
```bash
pytest
```

## 🗄️ Database Configuration

### SQLite (Default - for development)
No configuration needed! Just run migrations.

### PostgreSQL (Recommended for production)

Add to `.env`:
```env
DATABASE_URL=postgresql://user:password@localhost:5432/dbname
```

Or use individual settings:
```env
DB_NAME=your_database
DB_USER=your_user
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
```

## 🚀 Deployment

### Preparation
1. Set `DEBUG=False` in production
2. Set a strong `SECRET_KEY`
3. Configure `ALLOWED_HOSTS` with your domain
4. Set up PostgreSQL database
5. Configure Google OAuth with production callback URL

### Static Files
```bash
python manage.py collectstatic
```

### Using Gunicorn (Production Server)
```bash
pip install -r requirements.prod.txt
gunicorn heyyoufree.wsgi:application
```

## 🛠️ Customization

### Extending the User Model
Edit `django_app/main/models.py`:
```python
class User(AbstractUser):
    email = models.EmailField(unique=True)
    # Add your custom fields
    phone_number = models.CharField(max_length=20, blank=True)
    bio = models.TextField(blank=True)
```

### Adding New Views
Edit `django_app/main/views.py` and add to `urls.py`

### Customizing Templates
Templates are in `django_app/main/templates/main/`
- `base.html` - Base template with navbar
- `home.html` - Homepage

### Adding API Endpoints
1. Add view function in `views.py`
2. Add URL pattern in `urls.py`
3. Add tests in `tests.py`

## 📝 Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SECRET_KEY` | Django secret key | Auto-generated (insecure) |
| `DEBUG` | Debug mode | `True` |
| `ALLOWED_HOSTS` | Allowed hostnames | `localhost,127.0.0.1` |
| `DATABASE_URL` | Database connection string | SQLite |
| `DB_NAME` | PostgreSQL database name | - |
| `DB_USER` | PostgreSQL user | `postgres` |
| `DB_PASSWORD` | PostgreSQL password | - |
| `DB_HOST` | PostgreSQL host | `localhost` |
| `DB_PORT` | PostgreSQL port | `5432` |
| `GOOGLE_CLIENT_ID` | Google OAuth client ID | - |
| `GOOGLE_CLIENT_SECRET` | Google OAuth secret | - |

## 🤝 Contributing

This is a template repository. Fork it and make it your own!

## 📄 License

This project is open source and available under the MIT License.

## 🔗 Links

- Django Documentation: https://docs.djangoproject.com/
- Django Allauth: https://django-allauth.readthedocs.io/
- Google OAuth Setup: https://console.cloud.google.com/

---

**Built with ❤️ using Django**
