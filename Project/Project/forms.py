from django import forms
from TFT.models import Listing;

class ListingForm(forms.ModelForm):
    class Meta:
        model = Listing
        # fields = ('title', 'description', 'photo')
        exclude = ('User','trade_completed','date_completed',)