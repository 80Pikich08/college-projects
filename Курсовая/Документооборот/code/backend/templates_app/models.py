import os

from django.db import models


class DocumentTemplate(models.Model):
    PRACTICE_TYPE_CHOICES = [
        ("study", "Учебная практика"),
        ("production", "Производственная практика"),
    ]

    name = models.CharField(max_length=255)
    practice_type = models.CharField(max_length=20, choices=PRACTICE_TYPE_CHOICES)
    file = models.FileField(upload_to="templates/")
    is_active = models.BooleanField(default=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def filename(self):
        return os.path.basename(self.file.name)

    def __str__(self):
        return f"{self.name} — {self.practice_type}"