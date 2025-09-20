import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/map_interation_controller.dart';

class MapInterationView extends GetView<MapInterationController> {
  const MapInterationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Already injected

    return Scaffold(
      bottomSheet: _buildBottomSheet(),

      appBar: AppBar(title: const Text("Live Delivery Tracking")),
      body: Obx(() {
        return Stack(
          children: [
            FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: controller.currentLocation ?? LatLng(28.6139, 77.2090),
                initialZoom: 15,
                maxZoom: 90,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.deliveryAgent.delivery_agent',
                ),
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    markerDirection: MarkerDirection.top,
                    markerSize: const Size(20, 20),
                  ),
                ),
                // ✅ Destination Marker
                if (controller.destinationLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: controller.destinationLocation!,
                        width: 50,
                        height: 50,
                        child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                      ),
                    ],
                  ),
                // ✅ Polyline
                if (controller.route.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: controller.route,
                        strokeWidth: 7,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            ),
            // ✅ Loader
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: controller.getCurrentLocation,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.gps_fixed, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  BottomSheet _buildBottomSheet() {
    return BottomSheet(
      enableDrag: false,

      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Route Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => _RouteInfoItem(
                      icon: Icons.speed,
                      label: 'Speed',
                      value: '${controller.speedToDestination.value} km/h',
                    ),
                  ),
                  Obx(
                    () => _RouteInfoItem(
                      icon: Icons.timer,
                      label: 'Time',
                      value:
                          '${controller.hours.value} Hr: ${controller.minutes.value} Min',
                    ),
                  ),
                  Obx(
                    () => _RouteInfoItem(
                      icon: Icons.route,
                      label: 'Distance',
                      value: '${controller.distanceToDestination.value} km',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RouteInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _RouteInfoItem({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 29, color: AppColor.primaryVariant2),
        const SizedBox(height: 7),
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
