from django.conf.urls import url

from django.contrib.auth import views as auth_views
from django.contrib.auth.decorators import permission_required
from feedback.views import home, register, FeedbackListView, FeedbackCreateView,export_csv

urlpatterns = [
    url(r'^$', home),
    url(r'^login/$', auth_views.login, {'template_name': 'feedback/login.html'}, name='login'),
    url(r'^logout/$', auth_views.logout, name='logout'),
    url(r'^feedback/$', permission_required('user.is_superuser')(FeedbackListView.as_view()), name='feedback'),
    url(r'^create/feedback/$', FeedbackCreateView.as_view(), name='feedback_create'),
    url(r'^export/csv/$', export_csv, name='export_csv'),
    url(r'^register/', register),

]
