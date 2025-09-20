import 'dart:convert';

import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:http/http.dart' as http;

class LocationUploader {
  final uri = UrlPath.MAIN_URL;
  Future<void> sendLocationToBackend(
    String agentId,
    double lat,
    double lng,
  ) async {
    print("Agent Id : $agentId , Lat: $lat ,Lng: $lng");

    try {
      final response = await http.post(
        Uri.parse("$uri/updateLocation"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "agentId": agentId,
          "latitude": lat,
          "longitude": lng,
        }),
      );

      if (response.statusCode != 200) {
        print("Location update failed: ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
