from django.contrib.auth.models import User
from rest_framework import serializers

from .models import Profile


class RegisterSerializer(serializers.ModelSerializer):
    full_name = serializers.CharField(max_length=255, write_only=True)
    fio_genitive = serializers.CharField(
        max_length=255,
        required=False,
        allow_blank=True,
        write_only=True,
    )
    study_group = serializers.CharField(
        max_length=100,
        required=False,
        allow_blank=True,
        write_only=True,
    )
    password = serializers.CharField(write_only=True, min_length=4)

    class Meta:
        model = User
        fields = [
            "id",
            "username",
            "password",
            "full_name",
            "fio_genitive",
            "study_group",
        ]

    def create(self, validated_data):
        full_name = validated_data.pop("full_name")
        fio_genitive = validated_data.pop("fio_genitive", "")
        study_group = validated_data.pop("study_group", "")

        if not fio_genitive:
            fio_genitive = full_name

        user = User.objects.create_user(
            username=validated_data["username"],
            password=validated_data["password"],
        )

        Profile.objects.create(
            user=user,
            full_name=full_name,
            fio_genitive=fio_genitive,
            study_group=study_group,
        )

        return user

    def to_representation(self, instance):
        profile = getattr(instance, "profile", None)

        return {
            "id": instance.id,
            "username": instance.username,
            "full_name": profile.full_name if profile else "",
            "fio_genitive": profile.fio_genitive if profile else "",
            "study_group": profile.study_group if profile else "",
        }


class ProfileSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source="user.username", read_only=True)

    class Meta:
        model = Profile
        fields = [
            "id",
            "username",
            "full_name",
            "fio_genitive",
            "study_group",
            "is_admin",
        ]
        read_only_fields = [
            "id",
            "username",
            "is_admin",
        ]


class AdminUserSerializer(serializers.ModelSerializer):
    full_name = serializers.CharField(source="profile.full_name", read_only=True)
    fio_genitive = serializers.CharField(source="profile.fio_genitive", read_only=True)
    study_group = serializers.CharField(source="profile.study_group", read_only=True)
    is_admin = serializers.BooleanField(source="profile.is_admin", read_only=True)

    class Meta:
        model = User
        fields = [
            "id",
            "username",
            "full_name",
            "fio_genitive",
            "study_group",
            "is_admin",
            "is_staff",
            "is_superuser",
            "date_joined",
        ]