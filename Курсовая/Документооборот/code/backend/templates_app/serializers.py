from rest_framework import serializers

from .models import DocumentTemplate


class DocumentTemplateSerializer(serializers.ModelSerializer):
    file_url = serializers.SerializerMethodField()
    filename = serializers.SerializerMethodField()

    class Meta:
        model = DocumentTemplate
        fields = [
            "id",
            "name",
            "practice_type",
            "file",
            "file_url",
            "filename",
            "is_active",
            "uploaded_at",
            "updated_at",
        ]

    def get_file_url(self, obj):
        request = self.context.get("request")

        if not obj.file:
            return None

        if request is None:
            return obj.file.url

        return request.build_absolute_uri(obj.file.url)

    def get_filename(self, obj):
        return obj.filename()

    def validate_file(self, file):
        filename = file.name.lower()

        if not filename.endswith(".docx"):
            raise serializers.ValidationError(
                "Нужно загрузить файл .docx"
            )

        return file


class DocumentTemplateReplaceSerializer(serializers.ModelSerializer):
    class Meta:
        model = DocumentTemplate
        fields = [
            "file",
        ]

    def validate_file(self, file):
        filename = file.name.lower()

        if not filename.endswith(".docx"):
            raise serializers.ValidationError(
                "Нужно загрузить файл .docx"
            )

        return file