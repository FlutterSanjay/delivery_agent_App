// services/upi_validator_service.dart
import 'package:http/http.dart' as http;

class UpiValidatorService {
  // Validate UPI ID format using regex
  static bool validateUpiFormat(String upiId) {
    final regex = RegExp(r'^[a-zA-Z0-9.\-_]{2,256}@[a-zA-Z]{2,64}$');
    return regex.hasMatch(upiId);
  }

  // Verify UPI ID with mock API (in real app, use UPI verification API)
  static Future<bool> verifyUpiId(String upiId) async {
    try {
      // Mock verification - in production, use actual UPI verification API
      await Future.delayed(Duration(seconds: 1));

      // Simulate validation (80% success rate)
      return true; // Random().nextDouble() > 0.2;
    } catch (e) {
      return false;
    }
  }
}
