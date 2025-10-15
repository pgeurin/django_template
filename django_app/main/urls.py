from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('debug/oauth/', views.debug_oauth, name='debug_oauth'),
]