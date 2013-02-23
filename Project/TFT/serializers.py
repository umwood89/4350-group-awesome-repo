from rest_framework import serializers
from TFT.models import User, Country

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('username', 'password', 'email')