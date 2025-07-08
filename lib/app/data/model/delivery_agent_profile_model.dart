// lib/app/data/model/delivery_agent_profile_model.dart

class DeliveryAgentProfile {
  final String id;
  final String? name; // Made nullable
  final String? phoneNumber; // Made nullable
  final String? email; // Made nullable
  final String? vehicleType; // Made nullable
  final String? vehiclePlateNumber; // Made nullable
  final String? address; // Made nullable
  final String? status; // Made nullable
  final double? rating; // Made nullable
  final int? totalDeliveries; // Made nullable
  final String? profilePictureUrl; // Made nullable

  DeliveryAgentProfile({
    required this.id,
    this.name, // Now nullable
    this.phoneNumber,
    this.email,
    this.vehicleType,
    this.vehiclePlateNumber,
    this.address,
    this.status,
    this.rating,
    this.totalDeliveries,
    this.profilePictureUrl,
  });

  factory DeliveryAgentProfile.fromJson(Map<String, dynamic> json) {
    return DeliveryAgentProfile(
      id: json['id'] as String? ?? '', // Provide default for ID if it can be null
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      vehicleType: json['vehicle_type'] as String?,
      vehiclePlateNumber: json['vehicle_plate_number'] as String?,
      address: json['address'] as String?,
      status: json['status'] as String?,
      rating: (json['rating'] as num?)?.toDouble(), // Safely convert num to double
      totalDeliveries: json['total_deliveries'] as int?,
      profilePictureUrl: json['profile_picture_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'vehicle_type': vehicleType,
      'vehicle_plate_number': vehiclePlateNumber,
      'address': address,
      'status': status,
      'rating': rating,
      'total_deliveries': totalDeliveries,
      'profile_picture_url': profilePictureUrl,
    };
  }

  // Helper method to create a copy with updated values (useful for immutability)
  DeliveryAgentProfile copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? vehicleType,
    String? vehiclePlateNumber,
    String? address,
    String? status,
    double? rating,
    int? totalDeliveries,
    String? profilePictureUrl,
  }) {
    return DeliveryAgentProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      vehicleType: vehicleType ?? this.vehicleType,
      vehiclePlateNumber: vehiclePlateNumber ?? this.vehiclePlateNumber,
      address: address ?? this.address,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      totalDeliveries: totalDeliveries ?? this.totalDeliveries,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
