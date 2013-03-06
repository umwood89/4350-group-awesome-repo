import datetime
import re

from django import forms
from django.contrib.auth import authenticate
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User

class UserRegistrationForm(forms.Form):
    username = forms.CharField(max_length=30)
    first_name = forms.CharField()
    last_name = forms.CharField()
    email=forms.EmailField(required=False)
    password1=forms.CharField(max_length=30,widget=forms.PasswordInput()) #render_value=False
    password2=forms.CharField(max_length=30,widget=forms.PasswordInput())

    def clean_username(self): # check if username dos not exist before
        try:
            User.objects.get(username=self.cleaned_data['username']) #get user from user model
        except User.DoesNotExist :
            return self.cleaned_data['username']
    
        raise forms.ValidationError("this user exist already")
    
    
    def clean(self): # check if password 1 and password2 match each other
        if 'password1' in self.cleaned_data and 'password2' in self.cleaned_data:#check if both pass first validation
            if self.cleaned_data['password1'] != self.cleaned_data['password2']: # check if they match each other
                raise forms.ValidationError("passwords dont match each other")
    
        return self.cleaned_data
    
    
    def save(self): # create new user
        new_user=User.objects.create_user(self.cleaned_data['username'],
                                      self.cleaned_data['email'],
                                      self.cleaned_data['password1'] )
        new_user.first_name = self.cleaned_data['first_name']
        new_user.last_name = self.cleaned_data['last_name']
        new_user.save()
        return new_user