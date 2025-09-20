import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import 'package:get/get.dart';
// Corrected model import path
import '../controllers/delivery_agent_profile_controller.dart';

class DeliveryAgentProfileView extends GetView<DeliveryAgentProfileController> {
  const DeliveryAgentProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Delivery Agent Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // edit action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Card
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.r,
                    backgroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuAc1Q5dnxQ9bslcZOr1nrE-VG_lw_2MJEMqGjP18a3ucf0L92_G5PizzcFG65yzRleeyA8TSDDXtmQLbYkNHTIev-6L8cerIz82RGg0Ui-80MH8LAC4dVWIFeRupladwYS4D9Q4i7xu1X_UJeRtrxcL0U2ianVyvxF7ua9pVT0GwNW-3DwhjbtxtxjNNXR4znCkrEevL5sezGp2lw7N5UB-M3aThb-bp-gPu8BXg5GEbQ7D3CR70XfNr_R65drC1F-XrtO1ff2eGC76",
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ethan Carter",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Agent ID: 12345",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Text(
                                controller.isActive.value
                                    ? "Active"
                                    : "Inactive",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: controller.isActive.value
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Switch(
                                activeThumbColor: controller.isActive.value
                                    ? Colors.green
                                    : Colors.red,
                                value: controller.isActive.value,
                                onChanged: (_) => controller.toggleStatus(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            /// Stats Section
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.6,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildStatCard(
                  "Total Deliveries",
                  Icons.inventory_2,
                  controller.totalDeliveries,
                ),
                _buildStatCard(
                  "Pending Deliveries",
                  Icons.schedule,
                  controller.pendingDeliveries,
                  highlight: true,
                ),
                _buildStatCard(
                  "Earnings",
                  Icons.account_balance_wallet,
                  controller.earnings,
                  prefix: "₹",
                ),
                _buildStatCard("Rating", Icons.star, controller.rating),
              ],
            ),

            SizedBox(height: 20.h),

            /// Contact Details
            _buildInfoTile(Icons.phone, controller.phone, "Phone"),
            _buildInfoTile(Icons.mail, controller.email, "Email"),
            _buildInfoTile(
              Icons.two_wheeler,
              controller.vehicle,
              "Vehicle Assigned",
            ),
            _buildInfoTile(
              Icons.pin_drop,
              controller.zone,
              "Working Area/Zone",
            ),

            SizedBox(height: 20.h),

            /// Quick Actions
            Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildActionButton(Icons.list_alt, "View Orders"),

                _buildActionButton(Icons.report, "Report Issue"),
              ],
            ),
          ],
        ),
      ),

      /// Footer Logout
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: ElevatedButton.icon(
          onPressed: () => controller.logout(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(double.infinity, 50.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          icon: Icon(Icons.logout, color: Colors.white, size: 16.sp),
          label: Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildStatCard(
  String title,
  IconData icon,
  var value, {
  bool highlight = false,
  String prefix = "",
}) {
  return Obx(
    () => Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: highlight ? Colors.orange.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4.r, spreadRadius: 1.r),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: highlight ? Colors.orange : Colors.grey,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: highlight ? Colors.orange : Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "$prefix${value.value}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildInfoTile(IconData icon, String value, String subtitle) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.orange.shade50,
      child: Icon(icon, color: Colors.orange),
    ),
    title: Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
    subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
    trailing: Icon(Icons.chevron_right, color: Colors.grey),
  );
}

Widget _buildActionButton(
  IconData icon,
  String title, {
  Color color = Colors.orange,
}) {
  return InkWell(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4.r, spreadRadius: 1.r),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}
