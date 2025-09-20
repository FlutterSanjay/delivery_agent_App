class SignUpRequest {
  String name;
  String email;
  String phoneNumber;
  String role;
  String idProof;
  String warehouseId;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.idProof,
    required this.warehouseId,
  });

  /// Convert object to JSON for API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'idProof': idProof,
      'warehouseId': warehouseId,
    };
  }

  /// Create object from JSON (e.g., API response)
  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return SignUpRequest(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      idProof: json['idProof'] ?? '',
      warehouseId: json['warehouseId'] ?? '',
    );
  }
}
