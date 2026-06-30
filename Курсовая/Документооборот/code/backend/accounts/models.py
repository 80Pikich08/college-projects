from django.conf import settings
from django.db import models


class Profile(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="profile",
    )

    full_name = models.CharField(max_length=255)
    fio_genitive = models.CharField(max_length=255, blank=True)
    study_group = models.CharField(max_length=100, blank=True)
    is_admin = models.BooleanField(default=False)

    def __str__(self):
        return self.full_name