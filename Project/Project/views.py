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
from django.contrib.auth import *
from django.contrib.auth.decorators import *
from TFT.models import *
from TFT.serializers import ListingSerializer, OfferSerializer, UserSerializer, GroupSerializer
from TFT.forms import *
from datetime import *
from django.utils import simplejson
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.db.models import Q

listings = Listing.objects.order_by('date_created')[:10]
offers = Offer.objects.order_by('date_created')[:10]
listingForm = ListingForm
c = Context({"listings": listings, "offers" : offers, "listingForm" : listingForm} )

def home(request):
        user=request.user
        t = get_template('index.html')
        c["user"] = user
        html = t.render(c)
        return HttpResponse(html)

@login_required(login_url='/login')    
def viewProfile(request,user_id):
        t = get_template('profile.html')
        
        try:
            user = User.objects.get(pk=user_id)
            html = user.first_name
            c["username"] = user.username
            c["firstname"] = user.first_name
            c["lastname"] = user.last_name
            c["email"] = user.email
            
        except Exception as e:
            errormessage= '%s (%s)' % (e.message, type(e))
            return HttpResponseServerError(errormessage)

        # Get user profile, create a blank one if they dont have one
        try:
            profile = UserProfile.objects.get(user_id=user.id)
            c["url"] = profile.url
            c["userphoto"] = profile.userphoto
            c["company"] = profile.location
        except:
            a = "do nothing in the except"
        
        html = t.render(c)
        return HttpResponse(html)
 
@login_required(login_url='/login')   
def editProfile(request):
    if request.method == 'POST':
        form = EditProfileForm(request.POST, request.FILES)
        user = request.user
        try:
            profile = UserProfile.objects.get(user_id=user.id)
        except:
            profile = UserProfile()
            profile.user_id = user.id
            profile.save()
        if form.is_valid():
            form.save(user)
            
            return render_to_response("thanks.html")
        else:
            return render_to_response("profile_edit.html", {'form': form,},context_instance=RequestContext(request))
    else:
        user = request.user
        try:
            profile = UserProfile.objects.get(user_id=user.id)
        except:
            profile = profile()
            profile.user_id = user.id
            profile.save()
        
        data = {'first_name': user.first_name, 'last_name': user.last_name, 'email':user.email, 'url':profile.url, 'location':profile.location,'company':profile.company,'userphoto':profile.userphoto}
        form = EditProfileForm(initial=data) # form with pre-filled out stuph in it
        
        return render_to_response("profile_edit.html", {'form': form,},context_instance=RequestContext(request))
        
        
#               
#               def newListing(request):
#    if request.method == 'POST': # If the form has been submitted...
#        form = ListingForm(request.POST,request.FILES) # A form bound to the POST data
#        
#        if form.is_valid(): # All validation rules pass
#            newlisting = form.save(commit=False);
#            newlisting.user = request.user
#            form.save()
#            return render_to_response("thanks.html")
#    else:
#        form = ListingForm() # An unbound form
#        return render_to_response("new_listing.html", {'form': form,},context_instance=RequestContext(request))
#    return render_to_response("new_listing.html", {'form': form,},context_instance=RequestContext(request))
               
        
def browse(request):
        user=request.user
        listings = Listing.objects.order_by('date_created')
        #Pagination time
        paginator = Paginator(listings,5)
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
    
def search(request):
        searchstring = request.GET["searchtext"]
        
        #qgroup = reduce(operator.or_, Q(**{fieldname: searchstring}) for fieldname in fieldnames)
        listings = Listing.objects.filter(Q(title__icontains=searchstring) | Q(description__icontains=searchstring))
        
        user=request.user
        
        #Pagination time
        paginator = Paginator(listings,5)
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
    
@login_required(login_url='/login')
def tradeCenter(request):
    
    userlistings = Listing.objects.filter(user_id = request.user.id)
    for ulisting in userlistings:
        ulisting.offerCount = Offer.objects.filter(listing_id = ulisting.listing_id).count()
    c["user_listings"] = userlistings

    usersOffers = Offer.objects.filter(user_id = request.user.id)
    for offer in usersOffers:
        offer.listingTitle = Listing.objects.get(pk=offer.listing_id).title
        if offer.offer_accepted == 1:
            offer.status = "Accepted"
        else:
            olisting = Listing.objects.get(pk=offer.listing_id)
            if olisting.trade_completed == 1:
                offer.status = "Not accepted"
            else:
                offer.status = "Pending"
        
    c["users_offers"] = usersOffers
    
    c["user"] = request.user
    t = get_template('tradecenter.html')
    html = t.render(c)
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
@login_required(login_url='/login')
def newListing(request):
    if request.method == 'POST': # If the form has been submitted...
        form = ListingForm(request.POST,request.FILES) # A form bound to the POST data
        
        if form.is_valid(): # All validation rules pass
            newlisting = form.save(commit=False);
            newlisting.user = request.user
            form.save()
            return render_to_response("thanks.html")
    else:
        form = ListingForm() # An unbound form
        return render_to_response("new_listing.html", {'form': form,},context_instance=RequestContext(request))
    return render_to_response("new_listing.html", {'form': form,},context_instance=RequestContext(request))

def updateListing(request, listing_id):
    listing = Listing.objects.get(pk=listing_id);
    if request.method == 'POST': # If the form has been submitted...
        form = ListingForm(request.POST or None,request.FILES, instance=listing) # A form bound to the POST data
        form.save()
        return render_to_response("thanks.html")
    else:
        form = ListingForm( instance=listing) # An unbound form
        return render_to_response("update_listing.html", {'form': form,'update':'yes','listing':listing},context_instance=RequestContext(request))

@login_required(login_url='/login')
def newOffer(request,listing_id):
    listing = Listing.objects.get(pk=listing_id)
    if request.method == 'POST': # If the form has been submitted...
        form = OfferForm(request.POST,request.FILES) # A form bound to the POST data
        
        if form.is_valid(): # All validation rules pass
            newOffer = form.save(commit=False)
            newOffer.user = request.user
            newOffer.listing = listing
            form.save()
            return render_to_response("thanks.html",{'location':request.META['HTTP_REFERER'], 'message':'made an offer on a listing!'})
    else:
        form = OfferForm() # An unbound form
        c["form"] = form
        c["user"] = request.user
        c["listing"] = listing
        t = get_template('new_offer.html')
        html = t.render(c)
        return HttpResponse(html)
    
def updateOffer(request, offer_id):
    offer = Offer.objects.get(pk=offer_id);
    if request.method == 'POST': # If the form has been submitted...
        form = OfferForm(request.POST or None,request.FILES, instance=offer) # A form bound to the POST data
        form.save()
        return render_to_response("thanks.html")
    else:
        form = OfferForm( instance=offer) # An unbound form
        return render_to_response("update_offer.html", {'form': form,'update':'yes','offer':offer},context_instance=RequestContext(request))
 
@login_required(login_url='/login')
def acceptOffer(request,offer_id):
    try:  
        # Get the Offer being accepted, and the listing associated with the offer      
        offer = Offer.objects.get(pk=offer_id)
        listing = Listing.objects.get(pk=offer.listing_id)
        
        # Check to make sure that the Listing hasn't been accepted already
        
        if listing.trade_completed == 1:
            html = "Listing has already been accepted. <br><br> <a href=\"/listing_details/" + str(listing.listing_id) + "\">Return to listing details</a>"
            return HttpResponse(html) 
        
        # Check to make sure that the user logged in is the owner of the listing the offer is being accepted for. 
        if listing.user_id == request.user.id:
            
            # Set flags for trade completion
            offer.offer_accepted = 1
            offer.date_accepted = datetime.now()
            listing.trade_completed = 1
            listing.date_accepted = datetime.now()
            offer.save()
            listing.save()
            
            # Return to listings details page
            c["listing_detail"] = listing
            c["offers_detail"] = Offer.objects.filter(listing=listing.listing_id)
            c["user"] = request.user;
            t = get_template('listing_details.html')
            html = t.render(c)
            return HttpResponse(html)
        else:
            html = "User logged in cannot accept this offer, because they're not the owner of this offer"
            return HttpResponse(html)        
        
    except Offer.DoesNotExist:
        html = "Offer does not exist.."
        return HttpResponse(html)
    except Exception as e:
        html = '%s (%s)' % (e.message, type(e))
        return HttpResponseServerError(html)
        
    return HttpResponse(html)  

def cancelOffer(request,offer_id):
    offer = Offer.objects.get(pk=offer_id);
    if offer.user_id == request.user.id:
        
        offer.delete()
        return render_to_response("thanks.html",{'message':'canceled your offer! ','location':'tradecenter'})
    else: 
        html = "User logged in cannot delete this offer, because they're not the owner of this offer"
        return HttpResponse(html)     
                    
def deleteListing(request,listing_id):
    listing = Listing.objects.get(pk=listing_id);
    if listing.user_id == request.user.id:
        listing.delete()
        return render_to_response("thanks.html",{'message':'deleted your listing! ','location':'tradecenter'})
    else: 
        html = "User logged in cannot delete this offer, because they're not the owner of this offer"
        return HttpResponse(html)
def listingDetails(request,listing_id):
    
    listing = Listing.objects.get(pk=listing_id)
    offers_detail = Offer.objects.filter(listing=listing.listing_id)
    
    paginator = Paginator(offers_detail,5)
    page = request.GET.get('page')
    
    try:
        offers_detail = paginator.page(page)
    except PageNotAnInteger:
        offers_detail = paginator.page(1)
    except EmptyPage:
        offers_detail = paginator.page(paginator.num_pages)
    
    c["listing_detail"] = listing
    c["offers_detail"] = offers_detail
    c["user"] = request.user;
    t = get_template('listing_details.html')
    html = t.render(c)
    return HttpResponse(html)

def offerDetails(request,offer_id):
    
    offer = Offer.objects.get(pk=offer_id)
    
    c["offer_detail"] = offer
    c["user"] = request.user;
    t = get_template('offer_details.html')
    html = t.render(c)
    return HttpResponse(html)


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
