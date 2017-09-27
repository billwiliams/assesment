from django.contrib.auth.models import User
from django.forms import ModelForm, ModelChoiceField, Select, DateTimeField
from django import forms
from django.core.validators import RegexValidator
from feedback.models import Neighbourhood, Feedback


class UserRegistrationForm(forms.Form):
    username = forms.CharField(
        required=True,
        label='Username',
        max_length=32
    )
    email = forms.CharField(
        required=True,
        label='Email',
        max_length=256,
    )
    password = forms.CharField(
        required=True,
        label='Password',
        max_length=32,
        widget=forms.PasswordInput()
    )


class FeedbackForm(ModelForm):


    class Meta:
        model = Feedback
        exclude = ['created_at', 'updated_at', 'name']

    def __init__(self, *args, **kwargs):
        STATUS_CHOICES = (
            (1, ("1")),
            (2, ("2")),
            (3, ("3")),
            (4, ("4 ")),
            (5, ("5"))
        )
        super(FeedbackForm, self).__init__(*args, **kwargs)
        phone_number_validator = RegexValidator(r"[07][0-9]{8}(?![0-9])", "Invalid phone number must follow 07***")
        self.fields['neighbourhood'] = ModelChoiceField(queryset=Neighbourhood.objects.all(), widget=Select,
                                                        empty_label="Choose a neighborhood")
        self.fields['rating'] = forms.ChoiceField(choices=STATUS_CHOICES, label="Rating", initial='',
                                                  widget=forms.Select(), required=True)
        self.fields['phone_number'] = forms.CharField(
            label="Phone Number",
            required=True,  # Note: validators are not run against empty fields
            validators=[phone_number_validator]
        )
