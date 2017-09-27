from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.http import HttpResponseRedirect
from django import forms
from django.views.generic.list import ListView
from django.views.generic import TemplateView
from django.views.generic.detail import DetailView
from django.views.generic.edit import CreateView, UpdateView
from feedback.models import Neighbourhood, Feedback
from feedback.mixins import LoginRequiredMixin
from django.contrib.auth.decorators import login_required
from feedback.forms import UserRegistrationForm, FeedbackForm
import csv
from django.http import HttpResponse


# Create your views here.

def home(request):
    return render(request, 'feedback/home.html')


def register(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            userObj = form.cleaned_data
            username = userObj['username']
            email = userObj['email']
            password = userObj['password']
            if not (User.objects.filter(username=username).exists() or User.objects.filter(email=email).exists()):
                User.objects.create_user(username, email, password)
                user = authenticate(username=username, password=password)
                login(request, user)
                return HttpResponseRedirect('/')
            else:
                raise forms.ValidationError('Looks like a username with that email or password already exists')

    else:
        form = UserRegistrationForm()

    return render(request, 'feedback/register.html', {'form': form})


class FeedbackListView(LoginRequiredMixin, ListView):
    model = Feedback
    paginate_by = 9

    def get_context_data(self, **kwargs):
        context = super(FeedbackListView, self).get_context_data(**kwargs)
        context['neighbourhoods'] = Neighbourhood.objects.all()
        return context


class FeedbackDetailView(LoginRequiredMixin, DetailView):
    model = Feedback


class FeedbackCreateView(LoginRequiredMixin, CreateView):
    model = Feedback
    form_class = FeedbackForm

    def form_valid(self, form):
        form.instance.name = self.request.user
        return super(FeedbackCreateView, self).form_valid(form)


@login_required
def export_csv(request):
    # Create the HttpResponse object with the appropriate CSV header.
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="feedback.csv"'

    writer = csv.writer(response)
    writer.writerow(['Name', 'Phone Number ', 'rating ', 'comments'])
    for obj in Feedback.objects.all():
        writer.writerow([obj.name.username, obj.phone_number, obj.rating, obj.comments])

    return response
