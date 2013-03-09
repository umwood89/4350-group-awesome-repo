# Django admin config
from django.contrib import admin
from TFT.models import Listing, Offer

class AuthorAdmin(admin.ModelAdmin):
    pass
admin.site.register(Listing)
admin.site.register(Offer)