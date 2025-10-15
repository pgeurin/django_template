from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_http_methods
from django.contrib.sites.models import Site

def home(request):
    """Home page view."""
    return render(request, 'main/home.html', {
        'django_version': '5.2.6',  # Hardcoded for simplicity
    })

def debug_oauth(request):
    """Debug view for OAuth configuration."""
    site = Site.objects.get_current()
    callback_url = f"http://{site.domain}/accounts/google/login/callback/"
    
    # Get query parameters from request
    query_params = {k: v for k, v in request.GET.items()}
    
    # Get headers from request
    headers = {k: v for k, v in request.headers.items()}
    
    return JsonResponse({
        'site_domain': site.domain,
        'site_name': site.name,
        'callback_url': callback_url,
        'request_path': request.path,
        'request_host': request.get_host(),
        'query_params': query_params,
        'headers': headers,
    })