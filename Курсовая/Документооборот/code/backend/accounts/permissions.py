from rest_framework.permissions import BasePermission


class IsProfileAdmin(BasePermission):
    def has_permission(self, request, view):
        if not request.user.is_authenticated:
            return False

        if request.user.is_staff or request.user.is_superuser:
            return True

        if hasattr(request.user, "profile"):
            return request.user.profile.is_admin

        return False