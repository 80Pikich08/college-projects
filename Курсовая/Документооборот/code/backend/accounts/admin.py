from django.contrib import admin

from .models import Profile


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "user",
        "full_name",
        "study_group",
        "is_admin",
    ]

    list_filter = [
        "is_admin",
        "study_group",
    ]

    search_fields = [
        "user__username",
        "full_name",
        "study_group",
    ]