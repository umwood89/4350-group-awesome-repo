# TFT views
from rest_framework import generics
from rest_framework.decorators import api_view
from rest_framework.reverse import reverse
from rest_framework.response import Response
from TFT.serializers import ListingSerializer, OfferSerializer
from TFT.models import Listing, Offer

@api_view(['GET'])
def api_root(request, format=None):
    """
    The entry endpoint of our API.
    """
    return Response({
        'users': reverse('user-list', request=request),
    })
    
class Listings(generics.ListCreateAPIView):
    """
    API endpoint that represents a list of Trades.
    """
    model = Listing
    serializer_class = ListingSerializer
    
class Offers(generics.ListCreateAPIView):
    """
    API endpoint that represents a list of Offers.
    """
    model = Offer
    serializer_class = OfferSerializer
    
#class UserDetail(generics.RetrieveUpdateDestroyAPIView):
#    """
#    API endpoint that represents a single user.
#    """
#    model = User
#    serializer_class = UserSerializer