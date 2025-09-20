import 'address_model.dart';
import 'location_model.dart';

class Store {
  final String storeId;
  final String storeName;
  final String ownerName;
  final String phoneNumber;
  final Location location;
  final Address address;
  final String openingHours;
  final double rating;
  final DateTime createdAt;
  final List<String> orderedItems;
  final DateTime updatedAt;

  Store({
    required this.storeId,
    required this.storeName,
    required this.ownerName,
    required this.phoneNumber,
    required this.location,
    required this.address,
    required this.openingHours,
    required this.rating,
    required this.createdAt,
    required this.orderedItems,
    required this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId: json['storeId'] as String? ?? '',
      storeName: json['storeName'] as String? ?? '',
      ownerName: json['ownerName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : Location(latitude: 0.0, longitude: 0.0),
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : Address(
              houseNumber: '',
              street: '',
              colony: '',
              city: '',
              state: '',
              pinCode: '',
              country: '',
              fullAddress: '',
            ),
      openingHours: json['openingHours'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      orderedItems:
          (json['orderedItems'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'storeName': storeName,
      'ownerName': ownerName,
      'phoneNumber': phoneNumber,
      'location': location.toJson(),
      'address': address.toJson(),
      'openingHours': openingHours,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'orderedItems': orderedItems,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
