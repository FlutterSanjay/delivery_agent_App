// lib/services/delivery_agent_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/delivery_agent_profile_model.dart';

class DeliveryAgentApiService {
  // IMPORTANT: Replace this with your actual backend API base URL for agent profiles.
  static const String _baseUrl =
      'https://api.yourdomain.com/agents'; // <--- REPLACE THIS URL

  /// Fetches the delivery agent's profile data from the backend.
  ///
  /// This method makes a GET request to '/agents/{agentId}'.
  /// It expects a JSON response that can be mapped to `DeliveryAgentProfile`.
  Future<DeliveryAgentProfile> fetchAgentProfile(String agentId) async {
    final uri = Uri.parse('$_baseUrl/$agentId');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DeliveryAgentProfile.fromJson(data);
      } else {
        throw Exception(
          'Failed to load agent profile: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error fetching agent profile: $e');
      throw Exception('Network error or failed to fetch agent profile: $e');
    }
  }

  /// Updates the delivery agent's profile data on the backend.
  ///
  /// This method makes a PUT (or POST) request to '/agents/{agentId}'.
  /// It sends the updated `DeliveryAgentProfile` object as JSON.
  Future<DeliveryAgentProfile> updateAgentProfile(DeliveryAgentProfile profile) async {
    final uri = Uri.parse('$_baseUrl/${profile.id}');
    try {
      final response = await http.put(
        // Use PUT for full resource update, POST for partial or create
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        // Assuming backend returns the updated profile
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DeliveryAgentProfile.fromJson(data);
      } else {
        throw Exception(
          'Failed to update agent profile: ${response.statusCode} ${response.body}',
        );
      }
    } catch (e) {
      print('Error updating agent profile: $e');
      throw Exception('Network error or failed to update agent profile: $e');
    }
  }
}
