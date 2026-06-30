from django.urls import path

from .views import GenerateDocumentsView
from .views import MyDocumentsListView
from .views import TriggerLogListView

urlpatterns = [
    path("generate/", GenerateDocumentsView.as_view(), name="generate_documents"),
    path("my/", MyDocumentsListView.as_view(), name="my_documents"),
    path("trigger-logs/", TriggerLogListView.as_view(), name="trigger_logs")
]