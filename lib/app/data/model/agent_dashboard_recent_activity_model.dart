// lib/app/data/model/agent_dashboard_recent_activity_model.dart

class RecentActivity {
  // Or AgentDashboardRecentActivityModel
  final String? id; // Made nullable
  final String? type; // Made nullable
  final String? description; // Made nullable
  final DateTime? timestamp; // Made nullable
  final String? status; // Made nullable

  RecentActivity({this.id, this.type, this.description, this.timestamp, this.status});

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'] as String) // Use tryParse for safety
          : null,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'timestamp': timestamp?.toIso8601String(),
      'status': status,
    };
  }
}
