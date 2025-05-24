from django.contrib import admin
from django.urls import path, include
from core.views import home_view
from contact.views import contact_view

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('core.urls')),
    path('contact/', include('contact.urls')),
]