class SignUpRequest {
  String username;
  String email;
  String phoneNumber;
  String userType;
  String password;
  String confirmPassword;

  SignUpRequest({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.userType,
    required this.password,
    required this.confirmPassword,
  });

  // Convert to JSON for API call
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'password': password,
      'confirmPassword':
          confirmPassword, // Often not sent to backend, but good for client-side validation
    };
  }
}

// You might also have a SignUpResponse model if your backend sends specific data back
class SignUpResponse {
  String message;
  String? userId; // Optional
  // ... other fields from your backend response

  SignUpResponse({required this.message, this.userId});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(message: json['message'], userId: json['userId']);
  }
}
