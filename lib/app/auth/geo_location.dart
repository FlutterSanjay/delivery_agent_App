import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Service: Location handling with Geolocator
class LocationService {
  LocationService();

  /// Check + Request Permissions
  Future<bool> ensurePermissions() async {
    // Check if service is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("❌ Location services disabled.");
      return false;
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("❌ Location permission denied.");
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("❌ Location permanently denied. Go to settings.");
      return false;
    }

    return true;
  }

  /// One-time current location
  Future<Position?> getCurrentLocation() async {
    try {
      if (!await ensurePermissions()) return null;

      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      debugPrint("⚠️ Geolocator error: $e");
      return null;
    }
  }

  /// Continuous location stream
  Future<Stream<Position>?> getLocationStream() async {
    try {
      if (!await ensurePermissions()) return null;

      return Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
          distanceFilter: 10,
        ),
      );
    } catch (e) {
      debugPrint("⚠️ Geolocator stream error: $e");
      return null;
    }
  }
}
