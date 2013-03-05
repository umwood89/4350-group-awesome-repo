from rest_framework import serializers
from django.contrib.auth.models import User, Group, Permission
from TFT.models import Listing, Offer

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email', 'groups')

class GroupSerializer(serializers.HyperlinkedModelSerializer):
    permissions = serializers.ManySlugRelatedField(
        slug_field='codename',
        queryset=Permission.objects.all()
    )
    
    class Meta:
        model = Group
        fields = ('url', 'name', 'permissions')

class ListingSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Listing
        fields = ('title','description','user','photo','trade_completed','date_created','date_completed')
        

        
class OfferSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Offer
        fields = ('listing','title','description','user','photo','date_created')