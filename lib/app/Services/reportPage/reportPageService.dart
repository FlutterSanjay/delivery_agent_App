import 'dart:convert';
import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/UrlPath/UrlPath.dart';
import 'package:delivery_agent/app/data/model/ReportPage/delivery_trends.dart';
import 'package:delivery_agent/app/data/model/ReportPage/report_page.dart';
import 'package:http/http.dart' as http;

class ReportPageService {
  final String baseUrl = UrlPath.MAIN_URL;
  final storage = StorageService();

  Future<ReportSummary?> fetchReportSummary() async {
    try {
      final url = Uri.parse("${baseUrl}report-summary/${storage.getAgentId()}");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final summary = ReportSummary.fromJson(data);

        print("✅ Report fetched successfully");
        return summary;
      } else {
        print("❌ Failed to fetch report: ${response.statusCode}");
        return null; // Return null on failure
      }
    } catch (e) {
      print("⚠️ Error fetching report summary: $e");
      return null; // Return null on error
    }
  }

  Future<DeliveryTrends?> fetchDeliveryTrendsDaily(String data) async {
    try {
      final uri = Uri.parse(
        "${baseUrl}delivery-trends/${storage.getAgentId()}/$data",
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final trends = DeliveryTrends.fromJson(data);
        print("✅ Delivery trends fetched successfully");
        return trends;
      } else {
        print("❌ Failed to fetch delivery trends: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("⚠️ Error fetching delivery trends: $e");
      return null;
    }
  }
}
