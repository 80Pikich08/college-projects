from rest_framework import generics
from rest_framework.parsers import FormParser
from rest_framework.parsers import MultiPartParser
from rest_framework.response import Response
from rest_framework.views import APIView

from accounts.permissions import IsProfileAdmin

from .models import DocumentTemplate
from .serializers import DocumentTemplateReplaceSerializer
from .serializers import DocumentTemplateSerializer


class DocumentTemplateListCreateView(generics.ListCreateAPIView):
    permission_classes = [IsProfileAdmin]
    serializer_class = DocumentTemplateSerializer
    parser_classes = [MultiPartParser, FormParser]

    def get_queryset(self):
        return DocumentTemplate.objects.order_by("-uploaded_at")


class DocumentTemplateReplaceView(APIView):
    permission_classes = [IsProfileAdmin]
    parser_classes = [MultiPartParser, FormParser]

    def put(self, request, pk):
        template = DocumentTemplate.objects.get(pk=pk)

        serializer = DocumentTemplateReplaceSerializer(
            template,
            data=request.data,
            partial=True,
        )

        serializer.is_valid(raise_exception=True)
        serializer.save()

        result_serializer = DocumentTemplateSerializer(
            template,
            context={"request": request},
        )

        return Response(result_serializer.data)

    def patch(self, request, pk):
        return self.put(request, pk)


class DocumentTemplateDeleteView(generics.DestroyAPIView):
    permission_classes = [IsProfileAdmin]
    queryset = DocumentTemplate.objects.all()
