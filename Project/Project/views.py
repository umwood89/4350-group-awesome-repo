from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from django.http import HttpResponse
from django.template import Template, Context, RequestContext
from django.template.loader import get_template
from rest_framework import generics
from rest_framework.decorators import api_view
from rest_framework.reverse import reverse
from rest_framework.response import Response
from django.contrib.auth.models import User, Group, Permission
from django.contrib.auth import authenticate, login
from TFT.models import Listing, Offer
from TFT.serializers import ListingSerializer, OfferSerializer, UserSerializer, GroupSerializer
from TFT.forms import UserRegistrationForm
import datetime
from django.utils import simplejson

def home(request):
	user=request.user
	listings = Listing.objects.order_by('date_created')[:10]
	t = get_template('index.html')
	c = Context({"listings": listings, "user":user} )
	html = t.render(c)
	return HttpResponse(html)

def browse(request):
	user=request.user
	t = get_template('browse.html')
	c = Context({"user":user} )
	html = t.render(c)
	return HttpResponse(html)

def listingdetails(request):
	user=request.user
	t = get_template('listing_details.html')
	html = t.render(Context())
	return HttpResponse(html)

def userhome(request):
	user=request.user
	t = get_template('user_home.html')
	html = t.render(Context())
	return HttpResponse(html)


####################################################################
# Registration and authentication
####################################################################
def register(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            new_user = form.save()
            auth.login(request, new_user)
            return render_to_response("thanks.html")
    else:
        form = UserRegistrationForm()
    return render_to_response("register.html", {
        'form': form,
    })
    
   
# JSON method for logging in 
def JSONcheckpassword(request):
	try:
		username = request.POST.get('username', '')
		password = request.POST.get('password', '')
		
		user = authenticate(username=username, password=password)
		if user is not None:
			if user.is_active:
				#login(user)
				result = 'success'
				return HttpResponse(simplejson.dumps({'result': result}))						
	except:
		result = 'error'
	result = 'fail'
	return HttpResponse(simplejson.dumps({'result': result}))
    
# Set browser session via cookies
def login(request):
	try:
		username = request.POST['username']
		password = request.POST['password']
		
		user = authenticate(username=username, password=password)
		if user is not None:
			if user.is_active:
				login(request, user)
				return render_to_response('browse.html')
				
	except:
		return render_to_response("index.html")

def logout(request):
	try:
		logout(user)
	except:
		return render_to_response("index.html")
	return render_to_response("index.html")

####################################################################
# FORM POSTING VIEWS
####################################################################
def newListing(request):
    if request.method == 'POST': # If the form has been submitted...
        form = ListingForm(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            form.save();
    	else:
        	form = ListingForm() # An unbound form
    return HttpResponse("hello")


####################################################################
# DJANGO RESTFUL API views 
####################################################################
@api_view(['GET'])
def api_root(request, format=None):
    """
    The entry endpoint of our API.
    """
    return Response({
        'users': reverse('user-list', request=request),
        'groups': reverse('group-list', request=request),
        'listings': reverse('listing-List', request=request),
        'offers': reverse('offer-List', request=request),
    })
    
class UserList(generics.ListCreateAPIView):
    """
    API endpoint that represents a list of users.
    """
    model = User
    serializer_class = UserSerializer

class UserDetail(generics.RetrieveUpdateDestroyAPIView):
    """
    API endpoint that represents a single user.
    """
    model = User
    serializer_class = UserSerializer

class GroupList(generics.ListCreateAPIView):
    """
    API endpoint that represents a list of groups.
    """
    model = Group
    serializer_class = GroupSerializer

class GroupDetail(generics.RetrieveUpdateDestroyAPIView):
    """
    API endpoint that represents a single group.
    """
    model = Group
    serializer_class = GroupSerializer
    
######################################################
class Listings(generics.ListCreateAPIView):
    """
    API endpoint that represents a list of Trades.
    """
    model = Listing
    
    serializer_class = ListingSerializer
    
class ListingDetail(generics.RetrieveUpdateDestroyAPIView):
    """
    API endpoint that represents a single Trade.
    """
    model = Listing
    serializer_class = ListingSerializer
    
class Offers(generics.ListCreateAPIView):
    """
    API endpoint that represents a list of Offers.
    """
    model = Offer
    serializer_class = OfferSerializer
    
class OfferDetail(generics.RetrieveUpdateDestroyAPIView):
    """
    API endpoint that represents a single Offer.
    """
    model = Offer
    serializer_class = OfferSerializer

