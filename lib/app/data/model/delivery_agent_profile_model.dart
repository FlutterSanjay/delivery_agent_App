// lib/models/delivery_agent_profile.dart

class DeliveryAgentProfile {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String vehicleType;
  final String vehiclePlateNumber;
  final String address;
  final String status; // e.g., 'active', 'offline', 'on_duty'
  final double rating; // Read-only
  final int totalDeliveries; // Read-only
  final String profilePictureUrl; // URL for the profile image

  DeliveryAgentProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.vehicleType,
    required this.vehiclePlateNumber,
    required this.address,
    required this.status,
    required this.rating,
    required this.totalDeliveries,
    required this.profilePictureUrl,
  });

  // Factory constructor to create a DeliveryAgentProfile from a JSON map
  factory DeliveryAgentProfile.fromJson(Map<String, dynamic> json) {
    return DeliveryAgentProfile(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'N/A',
      phoneNumber: json['phone_number'] as String? ?? 'N/A',
      email: json['email'] as String? ?? 'N/A',
      vehicleType: json['vehicle_type'] as String? ?? 'N/A',
      vehiclePlateNumber: json['vehicle_plate_number'] as String? ?? 'N/A',
      address: json['address'] as String? ?? 'N/A',
      status: json['status'] as String? ?? 'offline',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalDeliveries: json['total_deliveries'] as int? ?? 0,
      profilePictureUrl:
          json['profile_picture_url'] as String? ??
          'https://placehold.co/150x150/E0E0E0/424242?text=Agent', // Placeholder
    );
  }

  // Method to convert a DeliveryAgentProfile instance to a JSON map
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
      // Rating and totalDeliveries are typically not sent back on update
      // 'rating': rating,
      // 'total_deliveries': totalDeliveries,
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
