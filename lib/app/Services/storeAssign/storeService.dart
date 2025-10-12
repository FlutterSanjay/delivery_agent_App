import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../UrlPath/UrlPath.dart';

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

  // update order status
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      final baseUrl = UrlPath.MAIN_URL;
      final url = Uri.parse("${baseUrl}update/orderStatus/$orderId");

      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"status": status}),
      );

      if (response.statusCode == 200) {
        print("✅ Order status updated successfully.");
      } else {
        throw Exception(
          "Failed to update order status. Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("❌ Error in updateOrderStatus: $e");
      rethrow;
    }
  }

  // filter order by status
  Future<Map<String, dynamic>> filterOrdersByStatus({
    required String vehicleId,
    required String status,
  }) async {
    try {
      final baseUrl = UrlPath.MAIN_URL;
      final url = Uri.parse("${baseUrl}store/orders/$vehicleId/$status");

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
