import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/Features/loader.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/report_page_controller.dart';

class ReportPageView extends GetView<ReportPageController> {
  const ReportPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryVariant2,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reports',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white, // White background
      body: Obx(
        () => SafeArea(
          child: controller.reportSummary.value == null
              ? AppLoader()
              : SingleChildScrollView(
                  // ✅ Added scroll to avoid overflow
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // Performance Overview Section
                        Text(
                          "Performance Overview",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        Obx(
                          () => GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 4 / 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h, // ✅ fixed spacing (was 2.h)
                            children: [
                              _buildStatCard(
                                "Total Deliveries",
                                "${controller.reportSummary.value?.totalDeliveredProducts ?? 0}",
                              ),
                              _buildStatCard(
                                "Pending Orders",
                                "${controller.reportSummary.value?.pendingOrders ?? 0}",
                              ),
                              _buildStatCard(
                                "Cancelled",
                                "${controller.reportSummary.value?.cancelledOrders ?? 0}",
                              ),
                              _buildStatCard(
                                "Earnings",
                                "\$${controller.reportSummary.value?.totalEarnings ?? 0}",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Tabs (Daily / Weekly / Monthly)
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildTabButton("Daily"),
                              _buildTabButton("Weekly"),
                              _buildTabButton("Monthly"),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Delivery Trends Section
                        Text(
                          "Delivery Trends",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildChartCard(),

                        SizedBox(height: 24.h),

                        // Target Completion
                        Text(
                          "Target Completion",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildProgressCard(),
                      ],
                    ),
                  ),
                ),
        ),
      ),

      // Bottom Navigation Bar
    );
  }

  // ---------------------- Widgets ---------------------- //

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label) {
    return Obx(() {
      bool isSelected = controller.selectedTab.value == label;
      return GestureDetector(
        onTap: () => controller.updateChartData(label),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFFF98006) : Colors.transparent,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildChartCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Performance Trend",
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 4.h),
          Text(
            controller.performanceChange,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF98006),
            ),
          ),
          SizedBox(height: 12.h),

          // ✅ Graph Section using fl_chart
          SizedBox(
            height: 160.h,
            child: Obx(() {
              return LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        controller.deliveryData.length,
                        (index) => FlSpot(
                          index.toDouble(),
                          controller.deliveryData[index],
                        ),
                      ),
                      isCurved: true,
                      color: const Color(0xFFF98006),
                      barWidth: 2,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFF98006).withAlpha(30),
                            Colors.orangeAccent.withAlpha(90),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              );
            }),
          ),

          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                .map(
                  (d) => Text(
                    d,
                    style: TextStyle(fontSize: 11.sp, color: Colors.black),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Weekly Goal",
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
              Text(
                "75/100",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: LinearProgressIndicator(
              value:
                  controller.targetCompletion *
                  0.01, // Convert percentage to 0-1 scale
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFFF98006),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFFF98006) : Colors.grey,
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xFFF98006) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
