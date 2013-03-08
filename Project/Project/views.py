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

def home(request):
	listings = Listing.objects.order_by('date_created')[:10]
	t = get_template('index.html')
	c = Context({"listings": listings})
	html = t.render(c)
	return HttpResponse(html)

def browse(request):
	t = get_template('browse.html')
	html = t.render(Context())
	return HttpResponse(html)

def listingdetails(request):
	t = get_template('listing_details.html')
	html = t.render(Context())
	return HttpResponse(html)

def userhome(request):
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
            return HttpResponseRedirect("/browse")
    else:
        form = UserRegistrationForm()
    return render_to_response("register.html", {
        'form': form,
    })
    
   

#def login(request):
#    username = request.POST['username']
#    password = request.POST['password']
#    user = authenticate(username=username, password=password)
#    if user is not None:
#        if user.is_active:
#            login(request, user)
#            # Redirect to a success page.
#    #    else:
#            # Return a 'disabled account' error message
#    # else:
#        # Return an 'invalid login' error message.
#    return HttpResponseRedirect("/browse")


def login(request):                                                                                                                         
    if request.method == 'POST':                                                                                                            
        request.session.set_test_cookie()                                                                                                   
        login_form = AuthenticationForm(request, request.POST)                                                                              
        if login_form.is_valid():                                                                                                           
            if request.is_ajax:                                                                                                             
                user = django_login(request, login_form.get_user())                                                                         
                if user is not None:                                                                                                        
                    return HttpResponse(request.REQUEST.get('next', '/'))   
        return HttpResponseForbidden() # catch invalid ajax and all non ajax                                                        
    else:                                                                                                                                   
        login_form = AuthenticationForm()                                                                                                                                        
    c = Context({                                                                                                                           
        'next': request.REQUEST.get('next'),                                                                                                
        'login_form': login_form,                                                                                                                         
        'request':request,                                                                                                                  
    })                                                                                                                                      
    return render_to_response('login.html', c, context_instance=RequestContext(request))


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
