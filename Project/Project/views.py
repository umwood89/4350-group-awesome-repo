from django.http import HttpResponse
from django.template import Template, Context, RequestContext
from django.template.loader import get_template
from TFT.models import Listing
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

def listing(request):
	t = get_template('listing.html')
	html = t.render(Context())
	return HttpResponse(html)

