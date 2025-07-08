import 'package:delivery_agent/app/imagePath/imagePath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../AppColor/appColor.dart';
import '../../../data/model/agent_dashboard_model.dart';
import '../../../data/model/agent_dashboard_recent_activity_model.dart';
import '../../../data/model/delivery_agent_profile_model.dart';
import '../controllers/agent_dashboard_controller.dart';

class AgentDashboardView extends GetView<AgentDashboardController> {
  const AgentDashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.onPrimary,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: AppColor.redColor, size: 50.sp),
                  SizedBox(height: 10.h),
                  Text(
                    'Error: ${controller.errorMessage.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColor.redColor, fontSize: 16.sp),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => controller.fetchHomeData(
                      controller.agentProfile.value?.id ?? 'agent_123',
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else if (controller.agentProfile.value == null ||
            controller.homeStats.value == null) {
          return const Center(child: Text('No home data available.'));
        } else {
          final profile = controller.agentProfile.value;
          final stats = controller.homeStats.value;

          return CustomScrollView(
            slivers: [
              _buildAppBar(profile!),
              SliverPadding(
                padding: EdgeInsets.all(16.0.r),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildStatusToggle(),
                    SizedBox(height: 20.h),
                    _buildStatsSection(stats!),
                    SizedBox(height: 30.h),
                    _buildActionButtons(),
                    SizedBox(height: 30.h),
                    _buildRecentActivitiesSection(),
                  ]),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    bool isFullWidth = false,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      color: AppColor.lightGreyBackground,
      child: Padding(
        padding: EdgeInsets.all(15.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30.sp, color: color),
            SizedBox(height: 10.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 15.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: 1.55.r,
          children: [
            _buildActionButton(
              icon: Icons.person_outline,
              label: 'View Profile',
              onTap: controller.goToProfile,
              color: const Color(0xFF4C67FF), // Indigo Blue
            ),
            _buildActionButton(
              icon: Icons.add_circle_outline,
              label: 'New Delivery',
              onTap: controller.startNewDelivery,
              color: const Color(0xFF00C896), // Soft Teal Green
            ),
            _buildActionButton(
              icon: Icons.history,
              label: 'Payment History',
              onTap: controller.viewPaymentHistory,
              color: const Color(0xFFFF6E40), // Vibrant Orange Coral
            ),
            _buildActionButton(
              icon: Icons.support_agent,
              label: 'Support',
              onTap: controller.goToSupport,
              color: const Color(0xFF936DFF), // Soft Purple
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 35.sp, color: AppColor.onPrimary),
            SizedBox(height: 10.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(DeliveryAgentProfile profile) {
    return SliverAppBar(
      expandedHeight: 180.h,
      floating: true,
      pinned: true,
      snap: false,
      elevation: 0,
      backgroundColor: AppColor.onPrimary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primary, Colors.orangeAccent.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w, bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: AppColor.onPrimary,
                      backgroundImage: (profile.profilePictureUrl?.isNotEmpty ?? false)
                          ? AssetImage(profile.profilePictureUrl!)
                          : AssetImage(ImagePath.imgNotFound),

                      onBackgroundImageError: (exception, stackTrace) {
                        print('Error loading profile image: $exception');
                      },
                      child: (profile.profilePictureUrl?.isEmpty ?? true)
                          ? Icon(Icons.person, size: 30.sp, color: Colors.grey)
                          : null,
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(fontSize: 16.sp, color: AppColor.onPrimary),
                          ),
                          Text(
                            profile.name ?? 'No Name',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.onPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none,
                        color: AppColor.onPrimary,
                        size: 28.sp,
                      ),
                      onPressed: () {
                        Get.snackbar(
                          'Notifications',
                          'No new notifications.',
                          snackPosition: SnackPosition.TOP,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusToggle() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Go Online',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Obx(
              () => Switch(
                trackOutlineColor: WidgetStateColor.transparent,
                value: controller.isOnline.value,
                onChanged: controller.toggleOnlineStatus,
                activeColor: AppColor.lightGreenColor,
                inactiveThumbColor: AppColor.redColor,
                inactiveTrackColor: AppColor.redColor.withAlpha(50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(AgentHomeStats stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Performance',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wrap each card with Flexible instead of Expanded to avoid overflow
            Container(
              padding: EdgeInsets.all(10.r),
              width: Get.width * 0.45,
              child: _buildStatCard(
                icon: Icons.delivery_dining,
                label: 'Deliveries',
                value: stats.deliveriesToday?.toString() ?? '0',
                color: Colors.orange.shade600,
              ),
            ),
            SizedBox(width: 5.w),
            Container(
              padding: EdgeInsets.all(10.r),
              width: Get.width * 0.45,
              child: _buildStatCard(
                icon: Icons.attach_money,
                label: 'Earnings',
                value: '\$${(stats.earningsToday ?? 0).toStringAsFixed(2)}',
                color: Colors.green.shade600,
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Container(
          padding: EdgeInsets.all(10.r),
          width: Get.width * 0.45,
          child: _buildStatCard(
            icon: Icons.list_alt,
            label: 'Active Orders',
            value: stats.activeOrders?.toString() ?? '0',
            color: Colors.purple.shade600,
            isFullWidth: true,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activities',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 15.h),
        Obx(
          () => controller.recentActivities.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(16.0.r),
                  child: Text(
                    'No recent activities.',
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.recentActivities.length,
                  itemBuilder: (context, index) {
                    final activity = controller.recentActivities[index];
                    return _buildActivityTile(activity);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildActivityTile(RecentActivity activity) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _getActivityIcon(activity.type ?? ""),
              color: activity.status == "complete"
                  ? Color(0xff085b06)
                  : _getActivityColor(activity.status ?? ""),
              size: 20.sp,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.description ?? 'No description',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    activity.timestamp != null
                        ? DateFormat('MMM dd, hh:mm a').format(activity.timestamp!)
                        : 'No date',
                    style: TextStyle(fontSize: 12.sp, color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              margin: EdgeInsets.only(top: 5.h),
              decoration: BoxDecoration(
                color: _getActivityColor(activity.status ?? '').withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                activity.status ?? 'Unknown',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: _getActivityColor(activity.status ?? ''),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type.toLowerCase()) {
      case 'delivery':
        return Icons.local_shipping;
      case 'pickup':
        return Icons.shopping_bag;
      case 'payment':
        return Icons.payments;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info_outline;
    }
  }

  Color _getActivityColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColor.lightGreenColor;
      case 'pending':
        return Colors.orange.shade700;
      case 'cancelled':
        return AppColor.redColor;
      case 'processing':
        return Colors.blue.shade700;
      default:
        return AppColor.redColor;
    }
  }
}
