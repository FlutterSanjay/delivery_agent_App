import 'dart:convert';

import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:http/http.dart' as http;

class StoreList {
  final storage = StorageService();
  Future<dynamic> getName() async {
    final userID = storage.getUserId();
    if (userID == null) {
      return false;
    }
    final baseUrl = '${UrlPath.MAIN_URL}get/warehouseUser/$userID';

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("First Screen Store List:$data");
        await storage.saveAgentData({"AgentData": data});
        await storage.saveUserName(data['name']);

        return data;
      } else {
        return jsonDecode('{"message":"User Not Found"}');
      }
    } catch (e) {
      throw Exception("Failed to load warehouses: $e");
    }
  }

  Future<dynamic> getDeliveryAgentDetail() async {
    final docId = storage.getUserId();
    if (docId == null) {
      return false;
    }
    final baseUrl = '${UrlPath.MAIN_URL}user/$docId';

    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data;
      } else {
        return jsonDecode('{"message":"User Not Found"}');
      }
    } catch (e) {
      throw Exception("Failed to load : $e");
    }
  }
}
