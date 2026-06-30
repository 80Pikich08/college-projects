from rest_framework import generics
from rest_framework.permissions import AllowAny
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from .serializers import ProfileSerializer
from .serializers import RegisterSerializer
from django.contrib.auth.models import User

from .permissions import IsProfileAdmin
from .serializers import AdminUserSerializer

class RegisterView(generics.CreateAPIView):
    serializer_class = RegisterSerializer
    permission_classes = [AllowAny]


class ProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = ProfileSerializer(request.user.profile)

        return Response(serializer.data)

    def put(self, request):
        serializer = ProfileSerializer(
            request.user.profile,
            data=request.data,
            partial=True,
        )

        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(serializer.data)
        
class AdminUserListView(generics.ListAPIView):
    permission_classes = [IsProfileAdmin]
    serializer_class = AdminUserSerializer

    def get_queryset(self):
        return User.objects.select_related("profile").order_by("id")