import 'dart:convert';

import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

import '../UrlPath/UrlPath.dart';

class OTPService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storage = StorageService();
  String? _verificationId;
  int? _resendToken; // 🔹 store resend token

  Future<int> checkUserExist(String phoneNumber) async {
    try {
      final url = "${UrlPath.MAIN_URL}user/exists?phoneNumber=$phoneNumber";

      final response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'})
          .timeout(const Duration(seconds: 8));
      ;
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        print(userData['userData']['userId']);
        await storage.saveUserId(userData['userData']['userId']);

        return response.statusCode;
      } else {
        print("Something Went Wrong");
        return 400;
      }
    } catch (e) {
      print("❌ Error $e");
      return 400;
    }
  }

  // Send OTP
  Future<void> sendOTP(String phone, {bool isResend = false}) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        timeout: const Duration(seconds: 60),
        forceResendingToken: isResend
            ? _resendToken
            : null, // 🔹 resend if available// Increase timeout
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification
          await _auth.signInWithCredential(credential);
          print("✅ Auto-verification successful!");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("❌ Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          print("⌛ Auto-retrieval timeout. Please enter OTP manually.");
        },
      );
    } catch (e) {
      print("❌ Error sending OTP: $e");
    }
  }

  Future<void> TokenReceive(String uid, String phoneNumber) async {
    final url = "${UrlPath.MAIN_URL}otp/token";

    // Data to send
    final Map<String, String> data = {
      'userId': uid,
      'userPhoneNumber': phoneNumber,
    };
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 7));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        storage.saveUserToken(responseData['token']);
        storage.saveUId(responseData['uid']);
        print("Token : ${storage.getUserToken()}");
      } else {
        // Error from backend
        print("Error: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Verify OTP manually
  Future<bool> verifyOTP(String smsCode) async {
    try {
      if (_verificationId != null) {
        final credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: smsCode,
        );
        final user = await _auth.signInWithCredential(credential);
        print("Sign In Details: $user");
        final userId = user.user?.uid;
        final userPhoneNumber = user.user?.phoneNumber;
        // await storage.write('userId', userId);

        await TokenReceive(userId!, userPhoneNumber!);
        print("✅ Phone number verified successfully! ");
        return true;
      } else {
        print("❌ Verification ID not found!");
        return false;
      }
    } catch (e) {
      print("❌ Error verifying OTP: $e");
      return false;
    }
  }
}
