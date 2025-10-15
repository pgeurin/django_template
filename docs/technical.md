# Technical Specifications

## Django Template Technical Documentation

This document outlines the technical specifications, architecture decisions, and performance patterns for the Django Template project.

## Technology Stack

- **Python**: 3.8+
- **Django**: 5.2.6
- **Database**: SQLite (development), PostgreSQL (production)
- **Authentication**: django-allauth with Google OAuth
- **Static Files**: WhiteNoise
- **CORS Handling**: django-cors-headers

## Project Structure

The project follows a standard Django structure with some customizations:

```
django_template/
├── django_app/                  # Main Django application directory
│   ├── django_template/         # Project configuration
│   │   ├── __init__.py
│   │   ├── asgi.py
│   │   ├── settings.py          # Settings configuration
│   │   ├── urls.py              # Main URL routing
│   │   └── wsgi.py
│   ├── main/                    # Main application
│   │   ├── __init__.py
│   │   ├── admin.py             # Admin configuration
│   │   ├── apps.py
│   │   ├── migrations/          # Database migrations
│   │   ├── models.py            # Data models
│   │   ├── templates/           # HTML templates
│   │   ├── tests.py             # Test suite
│   │   ├── urls.py              # App URL routing
│   │   └── views.py             # View controllers
│   ├── static/                  # Static files
│   ├── staticfiles/             # Collected static files (production)
│   └── manage.py                # Django management script
├── docs/                        # Documentation
├── tasks/                       # Task definitions
└── requirements.txt             # Python dependencies
```

## Authentication System

### Custom User Model

The project uses a custom User model defined in `main/models.py` that extends Django's AbstractUser:

- Email is the primary identifier (instead of username)
- Additional fields can be added as needed

### OAuth Integration

Google OAuth is integrated using django-allauth:

- OAuth credentials are stored in the database using the SocialApp model
- The setup_oauth.sh script automates the OAuth setup process
- OAuth login is configured to go directly to Google's authentication page

## API Design

The API follows RESTful principles:

- JSON responses with proper status codes
- Public and protected endpoints
- Authentication via session cookies

## Performance Patterns

### Database Optimization

- Use of Django's QuerySet methods to minimize database hits
- Proper indexing on frequently queried fields
- Select_related and prefetch_related for related objects

### Static File Handling

- WhiteNoise for efficient static file serving
- Static files are compressed and cached

### Security Measures

- CSRF protection enabled
- XSS protection headers
- Content-Type nosniff header
- Secure cookies in production
- CORS configuration for API access

## Environment Configuration

The project uses environment variables for configuration:

- `.env` file for local development
- Environment variables for production deployment
- Sensible defaults with overrides

## Testing Strategy

- Unit tests for models and views
- Integration tests for API endpoints
- Authentication flow tests

## Deployment

### Development

- Local SQLite database
- Debug mode enabled
- Auto-reload on code changes

### Production

- PostgreSQL database
- WhiteNoise for static files
- Debug mode disabled
- HTTPS enforced
- Proper logging configuration
