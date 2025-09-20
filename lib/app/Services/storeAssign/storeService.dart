import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../UrlPath/UrlPath.dart';
import '../../data/model/storeAssign/combined_model.dart';

class StoreService {
  Future<Map<String, dynamic>> getStoreById({
    required String vehicleId,
    required String dataType,
  }) async {
    try {
      final baseUrl = UrlPath.MAIN_URL;
      final url = Uri.parse("${baseUrl}stores/$vehicleId/$dataType");

      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception("Empty response body from API");
        }

        final dynamic decoded = json.decode(response.body);

        if (decoded is! Map<String, dynamic>) {
          throw Exception("Unexpected JSON format: ${decoded.runtimeType}");
        }

        final Map<String, dynamic> jsonResponse = decoded;

        // Check for null values in the response
        jsonResponse.forEach((key, value) {
          if (value == null) {
            print("⚠️  Null value found for key: $key");
          }
        });

        return jsonResponse;
      } else {
        throw Exception("Failed to load store. Code: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Error in getStoreById: $e");

      rethrow;
    }
  }
}
