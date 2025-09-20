class Address {
  final String houseNumber;
  final String street;
  final String colony;
  final String city;
  final String state;
  final String pinCode;
  final String country;
  final String fullAddress;

  Address({
    required this.houseNumber,
    required this.street,
    required this.colony,
    required this.city,
    required this.state,
    required this.pinCode,
    required this.country,
    required this.fullAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      houseNumber: json['houseNumber'] as String? ?? '',
      street: json['street'] as String? ?? '',
      colony: json['colony'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      pinCode: json['pinCode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      fullAddress: json['fullAddress'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'houseNumber': houseNumber,
      'street': street,
      'colony': colony,
      'city': city,
      'state': state,
      'pinCode': pinCode,
      'country': country,
      'fullAddress': fullAddress,
    };
  }
}
