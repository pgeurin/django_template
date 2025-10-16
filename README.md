# Django Template with Google OAuth

A production-ready Django template with Google OAuth authentication, organized for easy deployment and maintenance.

## ⚠️ IMPORTANT: Updated Deployment Runbook

**The deployment runbook has been updated with critical lessons learned from real production deployments.**

**Before deploying, please read:** [`docs/deployment/RENDER_DEPLOYMENT_RUNBOOK.md`](docs/deployment/RENDER_DEPLOYMENT_RUNBOOK.md)

This runbook now includes solutions for common deployment issues:
- Google OAuth 500 errors
- Database migration automation
- Superuser creation automation
- ALLOWED_HOSTS configuration
- Build command formatting

## 🚀 Quick Start

### Local Development
```bash
# 1. Create virtual environment
python -m venv django_template_env
source django_template_env/bin/activate

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run migrations
cd django_app
python manage.py migrate

# 4. Start server
python manage.py runserver
```

### Deploy to Render
```bash
# Push to GitHub (auto-deploys)
git push origin main

# Or manual deployment
export RENDER_API_KEY=your_api_key
render deploys create srv-your-service-id --confirm
```

## 📁 Project Structure

```
django_template/
├── 📁 django_app/           # Django application
├── 📁 docs/                # All documentation
│   ├── 📁 deployment/      # Deployment guides
│   └── 📁 oauth/          # OAuth setup guides
├── 📁 scripts/             # Deployment scripts
├── 📁 tasks/               # Project tasks
├── requirements.in         # High-level dependencies
├── requirements.txt        # Complete dependencies
└── render.yaml            # Render configuration
```

## 📚 Documentation

- **Getting Started**: This README
- **Deployment**: `docs/deployment/`
- **OAuth Setup**: `docs/oauth/`
- **Requirements**: `docs/REQUIREMENTS_MANAGEMENT.md`
- **Project Structure**: `PROJECT_STRUCTURE.md`
- **Success Log**: `docs/SUCCESSFUL_DEPLOYMENT_LOG.md`

## ⚙️ Configuration

### Environment Variables
- `DEBUG`: Set to `False` for production
- `SECRET_KEY`: Django secret key (auto-generated)
- `ALLOWED_HOSTS`: Domain configuration (auto-configured)
- `DATABASE_URL`: PostgreSQL connection (auto-configured)

### Google OAuth Setup
1. **Google Cloud Console**: Create OAuth 2.0 credentials
2. **Redirect URIs**: Add your domain + `/accounts/google/login/callback/`
3. **Environment Variables**: Set `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET`

## 🔧 Dependencies

Uses `pip-tools` for professional dependency management:
- `requirements.in`: High-level dependencies
- `requirements.txt`: Generated complete dependencies

Update dependencies:
```bash
pip-compile requirements.in
pip install -r requirements.txt
```

## ✅ Production Checklist

- [ ] Set `DEBUG=False`
- [ ] Configure Google OAuth credentials
- [ ] Test OAuth flow
- [ ] Verify static files
- [ ] Check database migrations
- [ ] Test deployment

## 🆘 Troubleshooting

See `docs/SUCCESSFUL_DEPLOYMENT_LOG.md` for complete troubleshooting guide.

## 📖 Learn More

- **Architecture**: `docs/architecture.mermaid`
- **Technical Specs**: `docs/technical.md`
- **Project Status**: `docs/status.md`