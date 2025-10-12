class ReportSummary {
  final int deliveredOrders;
  final int pendingOrders;
  final int cancelledOrders;
  final double totalEarnings;
  final int totalDeliveredProducts;

  ReportSummary({
    required this.deliveredOrders,
    required this.pendingOrders,
    required this.cancelledOrders,
    required this.totalEarnings,
    required this.totalDeliveredProducts,
  });

  factory ReportSummary.fromJson(Map<String, dynamic> json) {
    return ReportSummary(
      deliveredOrders: json['deliveredOrders'] ?? 0,
      pendingOrders: json['pendingOrders'] ?? 0,
      cancelledOrders: json['cancelledOrders'] ?? 0,
      totalEarnings: (json['totalEarnings'] ?? 0).toDouble(),
      totalDeliveredProducts: json['totalDeliveredProducts'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deliveredOrders': deliveredOrders,
      'pendingOrders': pendingOrders,
      'cancelledOrders': cancelledOrders,
      'totalEarnings': totalEarnings,
      'totalDeliveredProducts': totalDeliveredProducts,
    };
  }
}
