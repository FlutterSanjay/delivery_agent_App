// lib/services/payment_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/payment_transaction_model.dart';

class PaymentApiService {
  // IMPORTANT: Replace this with your actual backend API base URL for payments.
  // Make sure your backend server is running and accessible.
  static const String _baseUrl = 'https://api.yourdomain.com'; // <--- REPLACE THIS URL

  /// Simulates processing a payment by sending data to a backend.
  ///
  /// This method makes a POST request to the '/process-payment' endpoint.
  /// It expects to send a `PaymentTransaction` object as JSON and
  /// receive a `PaymentTransaction` object with updated status/ID.
  Future<PaymentTransaction> processPayment(PaymentTransaction transaction) async {
    final uri = Uri.parse('$_baseUrl/process-payment');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transaction.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming the backend returns the updated transaction data
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return PaymentTransaction.fromJson(responseData);
      } else {
        // Handle non-2xx status codes (e.g., 400 Bad Request, 500 Internal Server Error)
        print(
          'Payment failed with status code: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception('Payment failed: ${response.body}');
      }
    } catch (e) {
      // Handle network errors (e.g., no internet, server unreachable)
      print('Network or processing error: $e');
      throw Exception('Payment processing failed due to network error: $e');
    }
  }
}
