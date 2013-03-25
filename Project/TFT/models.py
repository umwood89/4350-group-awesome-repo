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
	date_completed = models.DateTimeField(blank = True, null = True)

#	def __unicode__(self):
#		return self.listing_id
	
class Offer(models.Model):
	offer_id = models.AutoField(primary_key=True)
	listing = models.ForeignKey('Listing')
	title = models.CharField(max_length=255)
	description = models.TextField(max_length=500)
	user = models.ForeignKey(User)
	photo = models.ImageField(upload_to='offer_photos/')
	offer_accepted = models.BooleanField()
	date_created = models.DateTimeField(auto_now_add=True)
	date_accepted = models.DateTimeField(blank = True, null = True)
	
class UserProfile(models.Model):
    user = models.ForeignKey(User, unique=True)
    userphoto = models.ImageField(upload_to='profile_pictures/',blank=True,null=True)
    url = models.URLField("Website", blank=True)
    company = models.CharField(max_length=50, blank=True)
    location = models.CharField(max_length=140, blank=True)
    def __unicode__(self):
        return u'Profile of user: %s' % self.user.usernames