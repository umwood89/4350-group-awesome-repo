from django.http import HttpResponse
from django.template import Template, Context, RequestContext
from django.template.loader import get_template
import datetime

def home(request):
    t = get_template('index.html')
    html = t.render(Context())
    return HttpResponse(html)
