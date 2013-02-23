from rest_framework import serializers
from TFT.models import User, Country

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('user_id', 'username', 'password', 'email', 'country_code')