// Example using http (install: http: ^latest_version)
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/model/daily_summary_model.dart';
import '../data/model/inventory_item.dart';

class ApiService {
  static const String _baseUrl = 'YOUR_BASE_API_URL_HERE';

  Future<DailySummary> getDailySummary() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/end-of-day/summary'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return DailySummary.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load daily summary: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load daily summary: $e');
    }
  }

  Future<List<InventoryItem>> getRemainingInventory() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/end-of-day/inventory'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((itemJson) => InventoryItem.fromJson(itemJson)).toList();
      } else {
        throw Exception('Failed to load inventory: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load inventory: $e');
    }
  }

  // Expired Item API
  Future<List<InventoryItem>> getExpiredItems() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/end-of-day/expired-items'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is List) {
          return responseData
              .map((itemJson) => InventoryItem.fromJson(itemJson as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Invalid response format for expired items data.');
        }
      } else {
        throw Exception('Failed to load expired items: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      print('Error fetching expired items: ${e.message}');
      throw Exception('Failed to load expired items: ${e.message}');
    } catch (e) {
      print('An unexpected error occurred: $e');
      throw Exception('An unexpected error occurred while fetching expired items.');
    }
  }

  Future<void> postCompleteDay(
    DailySummary summary,
    List<InventoryItem> inventory,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/end-of-day/complete'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'summary': summary.toJson(),
          'inventory': inventory.map((item) => item.toJson()).toList(),
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to complete day: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to complete day: $e');
    }
  }
}
