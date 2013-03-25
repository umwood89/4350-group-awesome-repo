from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from views import *

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()


urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Project.views.home', name='home'),
    # url(r'^Project/', include('Project.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    ###### Application base functionality ######
    url(r'^$', home),
    url(r'^browse$', browse),
    url(r'^search$', search),
    url(r'^tradecenter$', tradeCenter),
    url(r'^profiles/(?P<user_id>\d+)$', viewProfile),
    url(r'^EditProfile', editProfile),
    
    ###### Login and Authentication ######
    #url(r'^login/$', login),
    #url(r'^login/$', 'django.contrib.auth.views.login'),
    (r'^login$', 'django.contrib.auth.views.login', {'template_name': 'login.html'}),
    (r'^logout$', 'django.contrib.auth.views.logout', {'next_page': '/'}),
    
    url(r'^JSONcheckpassword$', JSONcheckpassword),

    url(r'^register$', register),
    
    ##### API URLS ######
    #url(r'^api/$', 'TFT.views',name='api_root'),
    url(r'^api/users$', UserList.as_view(), name='user-list'),
    url(r'^api/users/(?P<pk>\d+)$', UserDetail.as_view(), name='user-detail'),\
    
    url(r'^api/groups$', GroupList.as_view(), name='group-list'),
    url(r'^api/groups/(?P<pk>\d+)$', GroupDetail.as_view(), name='group-detail'),
    
    url(r'^api/listings$', Listings.as_view(), name="listing-list"),
    url(r'^api/listings/(?P<pk>\d+)$', ListingDetail.as_view(), name="listing-detail"),
    
    url(r'^api/offers$', Offers.as_view(), name="offer-list"),
    url(r'^api/offers/(?P<pk>\d+)$', OfferDetail.as_view(), name="offer-detail"),
    url(r'^api/register', registerjson),
    
    ##### FORM URLS ######
    url(r'^new_listing$', newListing),
    url(r'^update_listing/(?P<listing_id>\d+)$', updateListing),
    url(r'^listing_details/(?P<listing_id>\d+)$', listingDetails),
    
    url(r'^new_offer/(?P<listing_id>\d+)$', newOffer),
    url(r'^update_offer/(?P<offer_id>\d+)$', updateOffer),
    url(r'^offer_details/(?P<offer_id>\d+)$', offerDetails),
    
    url(r'^deleteListing/(?P<listing_id>\d+)$', deleteListing),

    url(r'^accept_offer/(?P<offer_id>\d+)$', acceptOffer),
    url(r'^cancel_offer/(?P<offer_id>\d+)$', cancelOffer),

    
)
