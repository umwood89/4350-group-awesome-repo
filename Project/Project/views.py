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
