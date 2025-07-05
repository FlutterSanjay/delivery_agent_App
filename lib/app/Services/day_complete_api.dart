// lib/services/api_service.dart

import 'dart:convert'; // Required for jsonDecode

import 'package:http/http.dart' as http; // Import the http package
import '../data/model/summary_one.dart';
import '../data/model/summary_two.dart';

class ApiService {
  // IMPORTANT: Replace this with your actual backend API base URL.
  // For local development, it might be 'http://10.0.2.2:PORT' for Android emulator
  // or 'http://localhost:PORT' for iOS simulator/web.
  // Make sure your backend server is running and accessible from your device/emulator.
  static const String _baseUrl = 'https://api.yourdomain.com'; // <--- REPLACE THIS URL

  /// Fetches the vehicle number from the backend.
  ///
  /// This method makes a GET request to the '/vehicle/number' endpoint.
  /// It expects a JSON response, e.g., `{"vehicle_number": "JH-01-AB-2012"}`.
  Future<String> fetchVehicleNumber() async {
    final uri = Uri.parse('$_baseUrl/vehicle/number');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['vehicle_number'] as String? ?? 'N/A';
      } else {
        // Handle non-200 status codes
        throw Exception(
          'Failed to load vehicle number: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      // Handle network errors or other exceptions
      print('Error fetching vehicle number: $e');
      throw Exception('Network error or failed to fetch vehicle number: $e');
    }
  }

  /// Fetches the first summary card data from the backend.
  ///
  /// This method makes a GET request to the '/day-completion/summary-one' endpoint.
  /// It expects a JSON response that can be mapped to the `SummaryDataOne` model.
  Future<SummaryDataOne> fetchSummaryOneData() async {
    final uri = Uri.parse('$_baseUrl/day-completion/summary-one');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return SummaryDataOne.fromJson(data);
      } else {
        throw Exception(
          'Failed to load summary one: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching summary one: $e');
      throw Exception('Network error or failed to fetch summary one: $e');
    }
  }

  /// Fetches the second summary card data from the backend.
  ///
  /// This method makes a GET request to the '/day-completion/summary-two' endpoint.
  /// It expects a JSON response that can be mapped to the `SummaryDataTwo` model.
  Future<SummaryDataTwo> fetchSummaryTwoData() async {
    final uri = Uri.parse('$_baseUrl/day-completion/summary-two');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return SummaryDataTwo.fromJson(data);
      } else {
        throw Exception(
          'Failed to load summary two: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching summary two: $e');
      throw Exception('Network error or failed to fetch summary two: $e');
    }
  }
}
