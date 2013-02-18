from django.db import models
import datetime

# Create your models here.

class User(models.Model):
	user_id = models.AutoField(primary_key=True)
	username = models.CharField(max_length=25, unique=True)
	password = models.CharField(max_length=25)
	email = models.EmailField(max_length=255)
	country_code = models.ForeignKey('Country')
	def __unicode__(self):
		return self.username

class Country(models.Model):
	country_code = models.CharField(max_length=2, primary_key=True)
	full_name = models.CharField(max_length=50)
	def __unicode__(self):
		return self.full_name
	
class Listing(models.Model):
	listing_id = models.AutoField(primary_key=True)
	title = models.CharField(max_length=255)
	description = models.TextField(max_length=500)
	user = models.ForeignKey('User')
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
	user = models.ForeignKey('User')
	photo = models.ImageField(upload_to='offer_photos/')
	offer_accepted = models.BooleanField()
	date_created = models.DateTimeField(auto_now_add=True)
	date_accepted = models.DateTimeField()
	def __unicode__(self):
		return self.title
