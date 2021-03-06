from rest_framework import serializers
from django.contrib.auth.models import User, Group, Permission
from TFT.models import Listing, Offer

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'groups')

class GroupSerializer(serializers.ModelSerializer):
    permissions = serializers.ManySlugRelatedField(
        slug_field='codename',
        queryset=Permission.objects.all()
    )
    
    class Meta:
        model = Group
        fields = ('url', 'name', 'permissions')

class ListingSerializer(serializers.ModelSerializer):
    listing_id = serializers.Field()
    class Meta:
        model = Listing
        fields = ('listing_id', 'title','description','user','photo','trade_completed','date_created','date_completed')
        
        
class OfferSerializer(serializers.ModelSerializer):
    class Meta:
        model = Offer
        fields = ('offer_id','listing','title','description','user','photo','date_created', 'offer_accepted', 'date_accepted')
