from django import forms
from TFT.models import Listing;

class ListingForm(forms.ModelForm):
    class Meta:
        model = Listing