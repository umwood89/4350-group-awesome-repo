from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
from thisforthat.views import home, current_datetime, hours_ahead

admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    #url(r'^$', 'thisforthat.views.index', name='index'),
    # url(r'^thisforthat/', include('thisforthat.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', home),
    url(r'^trades/', include('trades.urls')),
    url(r'^time/$', current_datetime),
    url(r'^time/plus/(\d{1,2})/$', hours_ahead),
)
