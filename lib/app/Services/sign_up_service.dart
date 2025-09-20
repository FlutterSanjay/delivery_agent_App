// auth_service.dart
import 'dart:convert';
import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:http/http.dart' as http;

import '../data/model/signup_request_model.dart';

class SignUpService {
  final uri = UrlPath.MAIN_URL;

  /// Sign up API call
  Future<String> signUp(SignUpRequest request) async {
    print("Request Body : ${jsonEncode(request.toJson())}");
    final url = Uri.parse("${uri}create/warehouseUser");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(request.toJson()),
      );

      // Debug print
      // print("Request Body: ${jsonEncode(request.toJson())}");
      print("Response Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      //TODO: Bhai Uid and Phone Number chaiye response body se
      return response.body;
    } catch (e) {
      print("SignUp Error: $e");
      rethrow;
    }
  }
}
