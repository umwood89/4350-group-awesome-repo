from rest_framework import serializers
from TFT.models import User, Country

class ListingSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Listing
        fields = ('listing_id','title','description','user','photo','trade_completed','date_created','date_completed')
        
class OfferSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Offer
        fields = ('offer_id','listing','title','description','user','photo','offer_accepted','date_created','date_accepted')