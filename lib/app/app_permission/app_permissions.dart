import 'package:permission_handler/permission_handler.dart';

class PermissionServices {
  /// Check and request Microphone Permission
  static Future<bool> requestMicrophonePermission() async {
    return await _handlePermission(Permission.microphone);
  }

  /// Check and request Location Permission
  static Future<bool> requestLocationPermission() async {
    return await _handlePermission(Permission.location);
  }

  /// Check and request Calendar Permission
  static Future<bool> requestCalendarPermission() async {
    return await _handlePermission(Permission.calendar);
  }

  /// Check and request Contacts Permission
  static Future<bool> requestContactsPermission() async {
    return await _handlePermission(Permission.contacts);
  }

  /// Check and request Notification Permission
  static Future<bool> requestNotificationPermission() async {
    return await _handlePermission(Permission.notification);
  }

  /// Check and request Storage Permission
  static Future<bool> requestStoragePermission() async {
    return await _handlePermission(Permission.storage);
  }

  /// Generic handler for permissions
  static Future<bool> _handlePermission(Permission permission) async {
    if (await permission.isGranted) return true;

    final status = await permission.request();

    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  /// Request all at once (optional)
  static Future<void> requestAllPermissions() async {
    await requestMicrophonePermission();
    await requestLocationPermission();
    await requestCalendarPermission();
    await requestContactsPermission();
    await requestNotificationPermission();
    await requestStoragePermission();
  }
}
