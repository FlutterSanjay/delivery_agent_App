import 'package:get/get.dart';

import '../data/model/signup_request_model.dart';
import '../data/model/signup_response_model.dart'; // Still good to have the model structure

class AuthService extends GetxService {
  // Simulate a network delay
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    print('Simulating signup for: ${request.name}, ${request.email}');
    await Future.delayed(const Duration(seconds: 2)); // Simulate network latency

    // --- Sample Data Logic ---
    // You can add more complex sample logic here if needed
    if (request.email == 'test@example.com' && request.idProof == '123...') {
      // Simulate a successful signup
      return SignUpResponse(
        message: 'Account created successfully for ${request.name}!',
        userId: 'mock_user_123',
      );
    } else if (request.email.contains('error')) {
      // Simulate a specific error
      throw Exception('An account with this email already exists.');
    } else {
      // Simulate a generic signup failure for other cases
      throw Exception('Failed to create account. Please try again.');
    }
    // --- End Sample Data Logic ---
  }
}
