from django.conf.urls import patterns, include, url
from TFT.views import Listings, Offers, api_root, ListingDetail, OfferDetail, UserList, UserDetail, GroupList, GroupDetail
from rest_framework.urlpatterns import format_suffix_patterns

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()
from views import home
from views import printUser

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Project.views.home', name='home'),
    # url(r'^Project/', include('Project.foo.urls')),listing-detail

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
    url(r'^$', home),
    url(r'^users/(\w{1,19})$', printUser),
    
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

#urlpatterns = format_suffix_patterns(urlpatterns, allowed=['json', 'api'])