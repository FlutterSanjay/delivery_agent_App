import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/model/agent_dashboard_model.dart';
import '../data/model/agent_dashboard_recent_activity_model.dart';
import '../data/model/delivery_agent_profile_model.dart';

const String _baseUrl = 'https://api.yourdomain.com/home'; // <--- REPLACE THIS URL

// Fetches agent profile for greeting
Future<DeliveryAgentProfile> fetchAgentProfile(String agentId) async {
  // This would typically be from a /profile endpoint
  final uri = Uri.parse(
    'https://api.yourdomain.com/agents/$agentId',
  ); // Reusing agent profile endpoint
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return DeliveryAgentProfile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load agent profile: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Network error fetching agent profile: $e');
  }
}

Future<AgentHomeStats> fetchAgentHomeStats(String agentId) async {
  final uri = Uri.parse('$_baseUrl/$agentId/stats');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return AgentHomeStats.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load home stats: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Network error fetching home stats: $e');
  }
}

Future<List<RecentActivity>> fetchRecentActivities(String agentId) async {
  final uri = Uri.parse('$_baseUrl/$agentId/activities');
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => RecentActivity.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load recent activities: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Network error fetching recent activities: $e');
  }
}

Future<void> updateAgentStatus(String agentId, String status) async {
  final uri = Uri.parse(
    'https://api.yourdomain.com/agents/$agentId/status',
  ); // Example status update endpoint
  try {
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update status: ${response.statusCode} ${response.body}');
    }
  } catch (e) {
    throw Exception('Network error updating status: $e');
  }
}
