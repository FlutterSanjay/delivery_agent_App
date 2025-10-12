class DeliveryTrends {
  final List<String> labels;
  final List<int> values;

  DeliveryTrends({required this.labels, required this.values});

  factory DeliveryTrends.fromJson(Map<String, dynamic> json) {
    return DeliveryTrends(
      labels: List<String>.from(json['labels'] ?? []),
      values: List<int>.from(json['values'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'labels': labels, 'values': values};
  }
}
