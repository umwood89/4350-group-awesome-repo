"""
This file demonstrates writing tests using the unittest module. These will pass
when you run "manage.py test".

Replace this with more appropriate tests for your application.


Some simple Django tests 

These are in addition to the built-in django tests, and the selenium tests. 
"""
from django.utils import unittest
from django.test import TestCase

from TFT.models import *
from django.contrib.auth.models import User

import datetime



class ListingTestCase(unittest.TestCase):
        def setUp(self):
            self.listing = Listing(description="description", title="title", photo="photo.jpg", trade_completed=0, user=User(), date_completed=datetime.datetime.now())    
            
        def test_listing_model_data(self):
            self.assertEqual(self.listing.title, "title")
            self.assertEqual(self.listing.photo, "photo.jpg")
            self.assertEqual(self.listing.trade_completed, 0)
            
class OfferTestCase(unittest.TestCase):
        def setUp(self):
            self.offer = Offer(title="title", description="description", offer_id=1, listing=Listing(), user=User(), photo="photo.jpg", offer_accepted=0, date_accepted=datetime.datetime.now())

        def test_offer_model_data(self):
            """ Test the functionalty of the listings model """
            self.assertEqual(self.offer.title, "title")
            self.assertEqual(self.offer.description, "description")


class ProfileTestCase(unittest.TestCase):
        def setUp(self):
            self.user = User()
            self.profile = UserProfile(user=User(),userphoto="photo.jpg",url="url",company="company",location="location")

        def test_profile_model_data(self):
            """ Test the functionality of the offer model """
            self.assertEqual(self.profile.userphoto, "photo.jpg")
            self.assertEqual(self.profile.url, "url")
            self.assertEqual(self.profile.company, "company")
            self.assertEqual(self.profile.location, "location")

class UserTestCase(unittest.TestCase):
    def setUp(self):
        self.user = User(username="richard")
    
    def test_delete_user(self):
        self.user.delete()
        self.assertEqual(self.user, null)

class SimpleTest(TestCase):
    def test_basic_addition(self):
        """
        Tests that 1 + 1 always equals 2.
        """
        self.assertEqual(1 + 1, 2)
