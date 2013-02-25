from django.http import HttpResponse
from django.template import Template, Context, RequestContext
from django.template.loader import get_template
#from TFT.models import User
#from django.contrib.auth.models import User
#from TFT.models import Country

import datetime

def home(request):
    t = get_template('index.html')
    html = t.render(Context())
    return HttpResponse(html)



def printUser(request,name):
    model = User
    #toinsert = User(username="wally",password="hello",email="hello@hello.com",country_code= Country.objects.get(country_code="he"))
    #toinsert.save()
    if check_user_exists(name):
        user1 = User.objects.get(username=name)
        response = "<html><body><p>User id: " + str(user1.user_id) +"<br />Username: " + user1.username + "<br />Email: " + user1.email + "<br />Country: " + Country.objects.get(country_code=user1.country_code_id).full_name +"<br /></p></body></html>"
    else:
        response = "Error, user does not exist!"
    return HttpResponse(response)

def check_user_exists(name):
    try:
        user1 = User.objects.get(username=name)
        return True
    except:
        return False

def check_password_matches(name,password):
    if check_user_exists(name):
        current_user = User.objects.get(username=name)
        if current_user.password == password:
            return True
    return False
        
        
    



    
    



