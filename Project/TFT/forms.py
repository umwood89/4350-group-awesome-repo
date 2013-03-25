import datetime
import re

from django import forms
from django.contrib.auth import authenticate
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from TFT.models import *


class ListingForm(forms.ModelForm):
    class Meta:
        model = Listing
        exclude = ('user','trade_completed','date_completed',)

class OfferForm(forms.ModelForm):
    class Meta:
        model = Offer
        exclude = ('user','listing','offer_accepted','date_accepted',)
        
class UserRegistrationForm(forms.Form):
    username = forms.CharField(max_length=30, widget=forms.TextInput(), label=("User Name"))
    
    first_name = forms.CharField(max_length=30)
    last_name = forms.CharField(max_length=30)
    email=forms.EmailField(max_length=80)
    password1=forms.CharField(max_length=30,widget=forms.PasswordInput(),label=("Password")) #render_value=False
    password2=forms.CharField(max_length=30,widget=forms.PasswordInput(),label=("Verify Password"))

    def clean_username(self): # check if username dos not exist beforeyeah
        try:
            User.objects.get(username=self.cleaned_data['username']) #get user from user model
        except User.DoesNotExist :
            return self.cleaned_data['username']
    
        raise forms.ValidationError("Username already taken.")
    
    
    def clean(self): # check if password 1 and password2 match each other
        if 'password1' in self.cleaned_data and 'password2' in self.cleaned_data:#check if both pass first validation
            if self.cleaned_data['password1'] != self.cleaned_data['password2']: # check if they match each other
                raise forms.ValidationError("Passwords do not match.")
    
        return self.cleaned_data
    
    
    def save(self): # create new user
        new_user=User.objects.create_user(self.cleaned_data['username'],
                                      self.cleaned_data['email'],
                                      self.cleaned_data['password1'] )
        new_user.first_name = self.cleaned_data['first_name']
        new_user.last_name = self.cleaned_data['last_name']
        new_user.save()
        return new_user
    
class EditProfileForm(forms.Form):
    first_name = forms.CharField(max_length=30,label="First Name")
    last_name = forms.CharField(max_length=30,label="Last Name")
    email=forms.EmailField(max_length=30,label="Email Address")
    #password1=forms.CharField(max_length=30,widget=forms.PasswordInput(),label=("Password")) #render_value=False
    #password2=forms.CharField(max_length=30,widget=forms.PasswordInput(),label=("Verify Password"))
    
    userphoto=forms.ImageField(label="Profile Picture",required=False)
    url = forms.URLField(label="Website",required=False)
    company = forms.CharField(max_length=50,required=False)
    location = forms.CharField(max_length=140,required=False)
    
    def save(self, user):
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.email = self.cleaned_data['email']    
        user.save()
        
        profile = UserProfile.objects.get(user_id=user.id)
        profile.url = self.cleaned_data['url']
        profile.company = self.cleaned_data['company']
        profile.location = self.cleaned_data['location']
        profile.userphoto = self.cleaned_data['userphoto']
        profile.save()
    
    
    