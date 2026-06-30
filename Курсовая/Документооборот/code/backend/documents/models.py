from django.conf import settings
from django.db import models

from templates_app.models import DocumentTemplate


class PracticeData(models.Model):
    PRACTICE_TYPE_CHOICES = [
        ("study", "Учебная практика"),
        ("production", "Производственная практика"),
    ]

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="practice_data",
    )

    fio = models.CharField(max_length=255)
    fio_genitive = models.CharField(max_length=255, blank=True)
    study_group = models.CharField(max_length=100)
    specialty = models.CharField(max_length=255)
    course = models.PositiveSmallIntegerField()
    education_form = models.CharField(max_length=100)

    practice_type = models.CharField(max_length=20, choices=PRACTICE_TYPE_CHOICES)
    practice_code = models.CharField(max_length=255)

    organization = models.CharField(max_length=500)
    address = models.CharField(max_length=500)
    supervisor = models.CharField(max_length=255)

    date_begin = models.DateField()
    date_end = models.DateField()
    document_date = models.DateField()

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.fio} — {self.get_practice_type_display()}"


class GeneratedDocument(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="generated_documents",
    )

    template = models.ForeignKey(
        DocumentTemplate,
        on_delete=models.CASCADE,
        related_name="generated_documents",
    )

    practice_data = models.ForeignKey(
        PracticeData,
        on_delete=models.CASCADE,
        related_name="generated_documents",
    )

    file = models.FileField(upload_to="generated/")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} — {self.template.name} — {self.created_at}"


class TriggerLog(models.Model):
    event_type = models.CharField(max_length=20)
    table_name = models.CharField(max_length=100)
    row_id = models.IntegerField(null=True, blank=True)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.event_type} - {self.table_name} - {self.created_at}'