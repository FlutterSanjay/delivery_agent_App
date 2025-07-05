class DailySummary {
  final double cashInHand;
  final double totalSales;
  final int salesTransactions;
  final int expiredProductTypes;

  DailySummary({
    required this.cashInHand,
    required this.totalSales,
    required this.salesTransactions,
    required this.expiredProductTypes,
  });

  // Factory constructor to create a DailySummary from a JSON map
  factory DailySummary.fromJson(Map<String, dynamic> json) {
    return DailySummary(
      cashInHand: json['cash_in_hand']?.toDouble() ?? 0.0,
      totalSales: json['total_sales']?.toDouble() ?? 0.0,
      salesTransactions: json['sales_transactions'] ?? 0,
      expiredProductTypes: json['expired_product_types'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cash_in_hand': cashInHand,
      'total_sales': totalSales,
      'sales_transactions': salesTransactions,
      'expired_product_types': expiredProductTypes,
    };
  }
}
