from django.contrib import admin

from .models import GeneratedDocument
from .models import PracticeData
from .models import TriggerLog

@admin.register(PracticeData)
class PracticeDataAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "user",
        "fio",
        "study_group",
        "specialty",
        "practice_type",
        "date_begin",
        "date_end",
        "created_at",
    ]

    list_filter = [
        "practice_type",
        "study_group",
        "specialty",
    ]

    search_fields = [
        "fio",
        "study_group",
        "specialty",
        "organization",
    ]


@admin.register(GeneratedDocument)
class GeneratedDocumentAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "user",
        "template",
        "created_at",
    ]

    list_filter = [
        "created_at",
    ]

    search_fields = [
        "user__username",
        "template__name",
    ]


@admin.register(TriggerLog)
class TriggerLogAdmin(admin.ModelAdmin):
    list_display = [
        "id",
        "event_type",
        "table_name",
        "row_id",
        "created_at",
    ]

    list_filter = [
        "event_type",
        "table_name",
        "created_at",
    ]

    search_fields = [
        "table_name",
        "message",
    ]

    readonly_fields = [
        "event_type",
        "table_name",
        "row_id",
        "message",
        "created_at",
    ]