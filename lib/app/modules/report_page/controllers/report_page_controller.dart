import 'package:delivery_agent/app/Services/reportPage/reportPageService.dart';
import 'package:delivery_agent/app/data/model/ReportPage/delivery_trends.dart';
import 'package:delivery_agent/app/data/model/ReportPage/report_page.dart';
import 'package:get/get.dart';

class ReportPageController extends GetxController {
  // Selected Tab (Daily / Weekly / Monthly)
  RxString selectedTab = "Daily".obs;

  final ReportPageService _reportPageService = ReportPageService();

  // Report Summary Data
  var reportSummary = Rxn<ReportSummary>();
  var deliveryTrendsDaily = Rxn<DeliveryTrends>();
  var deliveryTrendsWeekly = Rxn<DeliveryTrends>();
  var deliveryTrendsMonthly = Rxn<DeliveryTrends>();

  @override
  void onInit() {
    super.onInit();
    fetchReportSummary();

    fetchDeliveryTrends("daily");
    fetchDeliveryTrends("weekly");
    fetchDeliveryTrends("monthly");
  }

  void fetchReportSummary() async {
    final summary = await _reportPageService.fetchReportSummary();
    if (summary != null) {
      reportSummary.value = summary;
    }
  }

  void fetchDeliveryTrends(String data) async {
    if (data == "daily") {
      final trends = await _reportPageService.fetchDeliveryTrendsDaily(data);
      if (trends != null) {
        deliveryTrendsDaily.value = trends;
      }
    } else if (data == "weekly") {
      final trends = await _reportPageService.fetchDeliveryTrendsDaily(data);
      if (trends != null) {
        deliveryTrendsWeekly.value = trends;
      }
    } else if (data == "monthly") {
      final trends = await _reportPageService.fetchDeliveryTrendsDaily(data);
      if (trends != null) {
        deliveryTrendsMonthly.value = trends;
      }
    }
  }

  // Dummy data for performance chart
  RxList<double> deliveryData = <double>[50, 60, 40, 80, 90, 75, 65].obs;

  // Function to update chart data based on selected tab
  void updateChartData(String tab) {
    selectedTab.value = tab;

    if (tab == "Daily") {
      deliveryData.value = [50, 60, 40, 80, 90, 75, 65]; // backend integration
    } else if (tab == "Weekly") {
      deliveryData.value = [300, 320, 400, 380, 420, 410, 450];
    } else {
      deliveryData.value = [1200, 1350, 1100, 1500, 1420, 1550, 1600];
    }
  }

  // Calculate target completion percentage
  double get targetCompletion => reportSummary.value != null
      ? (reportSummary.value!.totalDeliveredProducts /
                (reportSummary.value!.totalDeliveredProducts +
                    reportSummary.value!.pendingOrders +
                    reportSummary.value!.cancelledOrders)) *
            100.0
      : 0.0;

  // Get chart percentage change
  String get performanceChange => "+15%";
}
