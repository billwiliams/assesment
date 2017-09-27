from django.conf.urls import url

from django.contrib.auth import views as auth_views
from .views import home, register

urlpatterns = [
    url(r'^$', home),
    url(r'^login/$', auth_views.login, {'template_name': 'feedback/login.html'}, name='login'),
    url(r'^logout/$', auth_views.logout, name='logout'),
    url(r'^register/', register),

]
