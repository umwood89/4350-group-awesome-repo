from django.views.decorators.csrf import csrf_exempt
from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect
from django.http import HttpResponse, HttpResponseServerError
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
from TFT.forms import UserRegistrationForm,ListingForm
import datetime
from django.utils import simplejson
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

listings = Listing.objects.order_by('date_created')
offers = Offer.objects.order_by('date_created')[:10]
listingForm = ListingForm
c = Context({"listings": listings, "offers" : offers, "listingForm" : listingForm} )

def home(request):
        user=request.user
        t = get_template('index.html')
        c["user"] = user
        html = t.render(c)
        return HttpResponse(html)

def browse(request):
        user=request.user
        listings = Listing.objects.order_by('date_created')
        #Pagination time
        paginator = Paginator(listings,4)
        page = request.GET.get('page')
        
        try:
            listings = paginator.page(page)
        except PageNotAnInteger:
            listings = paginator.page(1)
        except EmptyPage:
            listings = paginator.page(paginator.num_pages)
            
        t = get_template('browse.html')
        c["user"] = user
        c["listings"] = listings
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
            return render_to_response("thanks.html")
    else:
        form = UserRegistrationForm()
    return render_to_response("register.html", {
        'form': form,
    })
    
@csrf_exempt
def registerjson(request):
    if request.method == 'POST':
        try:
            json_data = simplejson.loads(request.raw_post_data)
            username = json_data['username'] 
            password = json_data['password']
            firstname = json_data['firstname']
            lastname = json_data['lastname']
            email = json_data['email']
        except Exception as e:
            errormessage= '%s (%s)' % (e.message, type(e))
            return HttpResponseServerError(errormessage)
        try:
            newuser = User.objects.get(username=username)
            return HttpResponse("Username already in use")
        except:
            try:
                user = User.objects.create_user(username, email, password)
                user.last_name = lastname
                user.first_name = firstname
                user.save()
                return HttpResponse(simplejson.dumps({'result':'success'}))
            except Exception as e:
                errormessage= '%s (%s)' % (e.message, type(e))
                return HttpResponseServerError(errormessage)
    return HttpResponse(simplejson.dumps("You should not get here"))


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
@csrf_exempt
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
@csrf_exempt
def newListing(request):
    if request.method == 'POST': # If the form has been submitted...
        form = ListingForm(request.POST,request.FILES) # A form bound to the POST data
        #form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid(): # All validation rules pass
            form.save();
            return render_to_response("thanks.html")
    else:
        form = ListingForm() # An unbound form
    return render_to_response("new_listing.html", {'form': form,})
                             


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
