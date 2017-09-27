from django.db import models
from django.core.urlresolvers import reverse


# Create your models here.

class InternetPackageType(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.ForeignKey('User', models.DO_NOTHING)
    phone_number = models.CharField(max_length=45, unique=True)
    neighbourhood = models.ForeignKey('Neighbourhood', models.DO_NOTHING)
    rating = models.IntegerField(blank=True, null=True)
    comments = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.id

    def get_absolute_url(self):
        return reverse("feedback_details", kwargs={"pk": self.id})

    class Meta:
        db_table = 'feedback'


class Neighbourhood(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=45, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'neighbourhoods'
