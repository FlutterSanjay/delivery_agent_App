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
