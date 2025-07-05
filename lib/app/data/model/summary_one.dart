/// Model for the first summary card data.
class SummaryDataOne {
  final double cashInHand;
  final int salesMade;
  final double revenue;

  SummaryDataOne({
    required this.cashInHand,
    required this.salesMade,
    required this.revenue,
  });

  // Factory constructor to create a SummaryDataOne instance from a JSON map.
  factory SummaryDataOne.fromJson(Map<String, dynamic> json) {
    return SummaryDataOne(
      cashInHand: (json['cash_in_hand'] as num?)?.toDouble() ?? 0.0,
      salesMade: json['sales_made'] as int? ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Method to convert a SummaryDataOne instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {'cash_in_hand': cashInHand, 'sales_made': salesMade, 'revenue': revenue};
  }
}
