class EstimatedDeliveryTime {
  final int seconds;
  final int nanoseconds;

  EstimatedDeliveryTime({required this.seconds, required this.nanoseconds});

  DateTime get deliveryDate => DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  factory EstimatedDeliveryTime.fromJson(Map<String, dynamic> json) {
    return EstimatedDeliveryTime(
      seconds: json['_seconds'] as int? ?? 0,
      nanoseconds: json['_nanoseconds'] as int? ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {'_seconds': seconds, '_nanoseconds': nanoseconds};
  }
}
