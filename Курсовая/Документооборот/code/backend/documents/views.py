from rest_framework import generics
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from templates_app.models import DocumentTemplate

from .models import GeneratedDocument
from .serializers import GeneratedDocumentSerializer
from .serializers import PracticeDataSerializer
from .services import GenerateDocx
from accounts.permissions import IsProfileAdmin
from .models import TriggerLog
from .serializers import TriggerLogSerializer

class GenerateDocumentsView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        serializer = PracticeDataSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        practice_data = serializer.save(user=request.user)

        templates = DocumentTemplate.objects.filter(
            practice_type=practice_data.practice_type,
            is_active=True,
        ).order_by("name")

        if not templates.exists():
            return Response(
                {
                    "detail": "Нет активных DOCX-шаблонов для выбранного типа практики."
                },
                status=status.HTTP_400_BAD_REQUEST,
            )

        generated_documents = []

        for template in templates:
            file_path = GenerateDocx(template, practice_data)

            generated_document = GeneratedDocument.objects.create(
                user=request.user,
                template=template,
                practice_data=practice_data,
                file=file_path,
            )

            generated_documents.append(generated_document)

        result_serializer = GeneratedDocumentSerializer(
            generated_documents,
            many=True,
            context={"request": request},
        )

        return Response(
            {
                "practice_data": PracticeDataSerializer(practice_data).data,
                "documents": result_serializer.data,
            },
            status=status.HTTP_201_CREATED,
        )


class MyDocumentsListView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = GeneratedDocumentSerializer

    def get_queryset(self):
        return GeneratedDocument.objects.filter(
            user=self.request.user,
        ).select_related(
            "template",
            "practice_data",
        ).order_by("-created_at")

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context["request"] = self.request

        return context


class TriggerLogListView(generics.ListAPIView):
    permission_classes = [IsProfileAdmin]
    serializer_class = TriggerLogSerializer

    def get_queryset(self):
        return TriggerLog.objects.order_by("-created_at")[:100]