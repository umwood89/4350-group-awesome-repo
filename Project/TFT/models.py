from django.db import models
from django.contrib.auth.models import User
import datetime

# Create your models here.

class Listing(models.Model):
	listing_id = models.AutoField(primary_key=True)
	title = models.CharField(max_length=255)
	description = models.TextField(max_length=500)
	user = models.ForeignKey(User)
	photo = models.ImageField(upload_to='listing_photos/')
	trade_completed = models.BooleanField()
	date_created = models.DateTimeField(auto_now_add=True)
	date_completed = models.DateTimeField()
	def __unicode__(self):
		return self.title
	
class Offer(models.Model):
	offer_id = models.AutoField(primary_key=True)
	listing = models.ForeignKey('Listing')
	title = models.CharField(max_length=255)
	description = models.TextField(max_length=500)
	user = models.ForeignKey(User)
	photo = models.ImageField(upload_to='offer_photos/')
	offer_accepted = models.BooleanField()
	date_created = models.DateTimeField(auto_now_add=True)
	date_accepted = models.DateTimeField()
	def __unicode__(self):
		return self.title

class Password(models.Model):
    title = models.CharField(max_length=200)
    username = models.CharField(max_length=200, blank=True)
    password = models.CharField(max_length=200)
    url = models.URLField(max_length=500,blank=True,verbose_name='Site URL')
    notes = models.TextField(max_length=500,blank=True,help_text='Any extra notes')
    created_at = models.DateTimeField(auto_now_add=True, editable=False)
    updated_at = models.DateTimeField(auto_now=True, editable=False)
    def __unicode__(self):
        return self.title


