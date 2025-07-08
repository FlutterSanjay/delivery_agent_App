// lib/app/data/model/agent_dashboard_model.dart

class AgentHomeStats {
  // Or AgentDashboardModel as per your naming
  final int? deliveriesToday; // Made nullable
  final double? earningsToday; // Made nullable
  final int? activeOrders; // Made nullable

  AgentHomeStats({this.deliveriesToday, this.earningsToday, this.activeOrders});

  factory AgentHomeStats.fromJson(Map<String, dynamic> json) {
    return AgentHomeStats(
      deliveriesToday: json['deliveries_today'] as int?,
      earningsToday: (json['earnings_today'] as num?)?.toDouble(),
      activeOrders: json['active_orders'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deliveries_today': deliveriesToday,
      'earnings_today': earningsToday,
      'active_orders': activeOrders,
    };
  }
}
