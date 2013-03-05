from django.conf.urls import patterns, include, url
from rest_framework.urlpatterns import format_suffix_patterns
from views import home, browse, listingdetails, userhome, api_root, ListingDetail, OfferDetail, UserList, UserDetail, GroupList, GroupDetail, Listings, Offers
from views import login, register, JSONcheckpassword, logout

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
    url(r'^browse/$', browse),
    url(r'^listingdetails/$', listingdetails),
    url(r'^userhome/$', userhome),
    
    ###### Login and Authentication ######
    #url(r'^login/$', login),
    #url(r'^login/$', 'django.contrib.auth.views.login'),
    (r'^login/$', 'django.contrib.auth.views.login', {'template_name': 'login.html'}),
    (r'^logout/$', 'django.contrib.auth.views.logout', {'next_page': '/'}),
    #(r'^logout/$', logout),
    url(r'^JSONcheckpassword/$', JSONcheckpassword),

    url(r'^register/$', register),
    
    ##### API URLS ######
    #url(r'^api/$', 'TFT.views',name='api_root'),
    url(r'^api/users/$', UserList.as_view(), name='user-list'),
    url(r'^api/users/(?P<pk>\d+)/$', UserDetail.as_view(), name='user-detail'),\
    
    url(r'^api/groups/$', GroupList.as_view(), name='group-list'),
    url(r'^api/groups/(?P<pk>\d+)/$', GroupDetail.as_view(), name='group-detail'),
    
    url(r'^api/listings/$', Listings.as_view(), name="listing-list"),
    url(r'^api/listings/(?P<pk>\d+)/$', ListingDetail.as_view(), name="listing-detail"),
    
    url(r'^api/offers/$', Offers.as_view(), name="offer-list"),
    url(r'^api/offers/(?P<pk>\d+)/$', OfferDetail.as_view(), name="offer-detail"),
    
)
