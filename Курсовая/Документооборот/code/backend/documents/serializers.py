from rest_framework import serializers

from .models import GeneratedDocument
from .models import PracticeData
from .models import TriggerLog

class PracticeDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = PracticeData
        fields = [
            "id",
            "fio",
            "fio_genitive",
            "study_group",
            "specialty",
            "course",
            "education_form",
            "practice_type",
            "practice_code",
            "organization",
            "address",
            "supervisor",
            "date_begin",
            "date_end",
            "document_date",
            "created_at",
        ]

        read_only_fields = [
            "id",
            "created_at",
        ]


class GeneratedDocumentSerializer(serializers.ModelSerializer):
    file_url = serializers.SerializerMethodField()
    template_name = serializers.CharField(source="template.name", read_only=True)
    practice_type = serializers.CharField(source="template.practice_type", read_only=True)

    class Meta:
        model = GeneratedDocument
        fields = [
            "id",
            "template_name",
            "practice_type",
            "file",
            "file_url",
            "created_at",
        ]

    def get_file_url(self, obj):
        request = self.context.get("request")

        if not obj.file:
            return None

        if request is None:
            return obj.file.url

        return request.build_absolute_uri(obj.file.url)


class TriggerLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = TriggerLog
        fields = [
            "id",
            "event_type",
            "table_name",
            "row_id",
            "message",
            "created_at",
        ]