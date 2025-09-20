import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points_plus/flutter_polyline_points_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../../../auth/geo_location.dart';

class MapInterationController extends GetxController {
  final MapController mapController = MapController();

  LatLng? currentLocation;
  LatLng? destinationLocation;

  // Observable variables
  RxDouble distanceToDestination = 0.0.obs;
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxDouble speedToDestination = 0.0.obs;
  RxList<LatLng> route = <LatLng>[].obs;
  RxBool isLoading = false.obs;

  final LocationService locationService = LocationService();

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  /// ✅ Current Location Fetch + Real-time Stream
  void getCurrentLocation() async {
    try {
      isLoading.value = true;

      // First time fetch
      Position? pos = await locationService.getCurrentLocation();
      final lat = pos?.latitude;
      final long = pos?.longitude;
      if (lat != null && long != null) {
        currentLocation = LatLng(lat, long);
        mapController.move(currentLocation!, 15);
        getDestinationLocation();
        update();
      }

      // 🔥 Real-time location stream
      final stream = await locationService.getLocationStream();
      stream?.listen((Position position) async {
        print("Stream Location : ${position.latitude} & ${position.longitude}");
        currentLocation = LatLng(position.latitude, position.longitude);

        if (destinationLocation != null) {
          await _fetchRoute();
        }

        // Agar marker ko live move karna ho
        // mapController.move(currentLocation!, mapController.zoom);

        update();
      });
    } catch (e) {
      Get.snackbar("Error", "Location Error in fetching");
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Destination Fetch from Arguments
  Future<void> getDestinationLocation() async {
    try {
      isLoading.value = true;
      final args = Get.arguments;
      if (args != null && args.containsKey('lat') && args.containsKey('lon')) {
        destinationLocation = LatLng(args['lat'], args['lon']);
        if (currentLocation != null) {
          await _fetchRoute();
        } else {
          await Future.delayed(const Duration(milliseconds: 500));
          if (currentLocation != null) await _fetchRoute();
        }
        update();
      } else {
        Get.snackbar("Error", "Incorrect Location");
      }
    } catch (e) {
      Get.snackbar("Error", '$e');
    } finally {
      isLoading.value = false;
    }
  }

  /// ✅ Fetch Polyline Route and Calculate
  Future<void> _fetchRoute() async {
    try {
      if (currentLocation == null || destinationLocation == null) return;

      final polyLineURl = Uri.parse(
        "https://router.project-osrm.org/route/v1/driving/"
        "${currentLocation!.longitude},${currentLocation!.latitude};"
        "${destinationLocation!.longitude},${destinationLocation!.latitude}"
        "?overview=full&geometries=polyline",
      );

      final response = await http.get(polyLineURl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final geometry = data['routes'][0]['geometry'];
        await _decodePolyline(geometry);

        final distanceInMeters = data['routes'][0]['distance'];
        final durationInSeconds = data['routes'][0]['duration'];

        distanceToDestination.value = double.parse(
          (distanceInMeters / 1000).toStringAsFixed(2),
        );

        hours.value = durationInSeconds ~/ 3600;
        minutes.value = ((durationInSeconds % 3600) ~/ 60);

        speedToDestination.value = double.parse(
          ((distanceInMeters / durationInSeconds) * 3.6).toStringAsFixed(2),
        );

        // ✅ Fit map to route
        if (route.isNotEmpty) {
          mapController.fitCamera(
            CameraFit.bounds(
              bounds: LatLngBounds(currentLocation!, destinationLocation!),
              padding: const EdgeInsets.all(50),
            ),
          );
        }

        update();
      }
    } catch (e) {
      print("Route Fetch Error: $e");
    }
  }

  /// ✅ Decode Polyline
  Future<void> _decodePolyline(String encodedPolyline) async {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPoints = polylinePoints.decodePolyline(encodedPolyline);

    route.value = decodedPoints.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }
}
