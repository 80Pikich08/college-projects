from django.contrib import admin

from .models import DocumentTemplate


@admin.register(DocumentTemplate)
class DocumentTemplateAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "name",
        "practice_type",
        "is_active",
        "uploaded_at",
        "updated_at",
    ]

    list_filter = [
        "practice_type",
        "is_active",
    ]

    search_fields = [
        "name",
    ]