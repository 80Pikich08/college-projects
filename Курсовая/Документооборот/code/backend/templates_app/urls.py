from django.urls import path

from .views import DocumentTemplateDeleteView
from .views import DocumentTemplateListCreateView
from .views import DocumentTemplateReplaceView


urlpatterns = [
    path("", DocumentTemplateListCreateView.as_view(), name="template_list_create"),
    path("<int:pk>/replace/", DocumentTemplateReplaceView.as_view(), name="template_replace"),
    path("<int:pk>/delete/", DocumentTemplateDeleteView.as_view(), name="template_delete"),
]