// lib/app/modules/delivery_agent_profile/views/delivery_agent_profile_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

import 'package:get/get.dart';

import '../../../AppColor/appColor.dart'; // Corrected import path for AppColor
import '../../../data/model/delivery_agent_profile_model.dart'; // Corrected model import path
import '../controllers/delivery_agent_profile_controller.dart';

class DeliveryAgentProfileView extends GetView<DeliveryAgentProfileController> {
  const DeliveryAgentProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: const Text('Agent Profile'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(controller.isEditing.value ? Icons.cancel : Icons.edit),
              onPressed: controller.isLoading.value
                  ? null // Disable button when loading
                  : () {
                      if (controller.isEditing.value) {
                        controller.cancelEdit(); // Cancel button
                      } else {
                        controller.toggleEditMode(); // Edit button
                      }
                    },
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: false,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.0.r), // Use .r for all-around padding
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
                    onPressed: () => controller.fetchAgentProfile(
                      controller.agentProfile.value?.id ?? 'agent_123',
                    ), // Retry with current ID
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else if (controller.agentProfile.value == null) {
          return const Center(child: Text('No profile data available.'));
        } else {
          // Display profile content
          final profile = controller.agentProfile.value!;
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.0.w, 100.0.h, 20.0.w, 20.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r, // Use .r for radius
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: AssetImage(profile.profilePictureUrl!),
                        onBackgroundImageError: (exception, stackTrace) {
                          // Fallback to a placeholder icon if image fails to load
                          print('Error loading image: $exception');
                        },
                        child: profile.profilePictureUrl!.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 60.sp,
                                color: Colors.grey,
                              ) // Use .sp for icon size
                            : null,
                      ),
                      if (controller.isEditing.value)
                        Positioned(
                          bottom: 0.h, // Use .h
                          right: 0.w, // Use .w
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Implement image selection logic (e.g., from gallery/camera)
                              Get.snackbar(
                                'Feature',
                                'Image upload not yet implemented!',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: CircleAvatar(
                              radius: 20.r, // Use .r
                              backgroundColor: Colors.blue.shade700,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20.sp, // Use .sp
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h), // Use .h
                // Agent Name (always visible, but editable in edit mode)
                Text(
                  controller.nameController.text.isEmpty && !controller.isEditing.value
                      ? 'N/A'
                      : controller.nameController.text,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ), // Use .sp
                ),

                SizedBox(height: 5.h), // Use .h
                // Agent Status
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ), // Use .w and .h
                  decoration: BoxDecoration(
                    color: _getStatusColor(profile.status!),
                    borderRadius: BorderRadius.circular(20.r), // Use .r
                  ),
                  child: Text(
                    profile.status!.capitalizeFirst!,
                    style: TextStyle(
                      color: AppColor.onPrimary,
                      fontSize: 14.sp,
                    ), // Use .sp
                  ),
                ),
                SizedBox(height: 30.h), // Use .h
                // Profile Details Card
                _buildProfileDetailsCard(profile),
                SizedBox(height: 20.h), // Use .h
                // Performance Metrics Card (Read-only)
                _buildPerformanceMetricsCard(profile),
                SizedBox(height: 30.h), // Use .h
                // Save/Cancel Buttons (only in edit mode)
                if (controller.isEditing.value) _buildEditActionButtons(),
              ],
            ),
          );
        }
      }),
    );
  }

  // Helper to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'on_duty':
        return AppColor.greenColor;
      case 'offline':
        return AppColor.redColor;
      default:
        return AppColor.greyColor;
    }
  }

  Widget _buildProfileDetailsCard(DeliveryAgentProfile profile) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)), // Use .r
      child: Padding(
        padding: EdgeInsets.all(16.0.r), // Use .r
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal & Vehicle Details',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold), // Use .sp
            ),
            SizedBox(height: 15.h), // Use .h
            _buildProfileField(
              icon: Icons.person_outline,
              label: 'Name',
              controller: controller.nameController,
              isEditable: controller.isEditing.value,
            ),
            _buildProfileField(
              icon: Icons.phone_outlined,
              label: 'Phone Number',
              controller: controller.phoneController,
              isEditable: controller.isEditing.value,
              keyboardType: TextInputType.phone,
            ),
            _buildProfileField(
              icon: Icons.email_outlined,
              label: 'Email',
              controller: controller.emailController,
              isEditable: controller.isEditing.value,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildProfileField(
              icon: Icons.motorcycle_outlined,
              label: 'Vehicle Type',
              controller: controller.vehicleTypeController,
              isEditable: controller.isEditing.value,
            ),
            _buildProfileField(
              icon: Icons.badge_outlined,
              label: 'Plate Number',
              controller: controller.vehiclePlateNumberController,
              isEditable: controller.isEditing.value,
            ),
            _buildProfileField(
              icon: Icons.location_on_outlined,
              label: 'Address',
              controller: controller.addressController,
              isEditable: controller.isEditing.value,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required bool isEditable,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h), // Use .h
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey.shade700, size: 24.sp), // Use .sp
          SizedBox(width: 15.w), // Use .w
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 14.sp, color: AppColor.greyColor), // Use .sp
                ),
                if (isEditable)
                  TextField(
                    controller: controller,
                    keyboardType: keyboardType,
                    maxLines: maxLines,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ), // Use .sp
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0.h), // Use .h
                      border: const UnderlineInputBorder(), // Added const
                      enabledBorder: const UnderlineInputBorder(
                        // Added const
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        // Added const
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  )
                else
                  Text(
                    controller.text.isEmpty ? 'N/A' : controller.text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ), // Use .sp
                    maxLines: maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetricsCard(DeliveryAgentProfile profile) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)), // Use .r
      child: Padding(
        padding: EdgeInsets.all(16.0.r), // Use .r
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold), // Use .sp
            ),
            SizedBox(height: 15.h), // Use .h
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetricItem(
                  icon: Icons.star_outline,
                  label: 'Rating',
                  value: profile.rating!.toStringAsFixed(1),
                ),
                _buildMetricItem(
                  icon: Icons.delivery_dining_outlined,
                  label: 'Total Deliveries',
                  value: profile.totalDeliveries.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.blue.shade700, size: 30.sp), // Use .sp
          SizedBox(height: 8.h), // Use .h
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey), // Use .sp
          ),
          SizedBox(height: 5.h), // Use .h
          Text(
            value,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold), // Use .sp
          ),
        ],
      ),
    );
  }

  Widget _buildEditActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: controller.isLoading.value ? null : () => controller.cancelEdit(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade400,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 15.h), // Use .h
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ), // Use .r
              elevation: 3,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold), // Use .sp
            ),
          ),
        ),
        SizedBox(width: 15.w), // Use .w
        Expanded(
          child: ElevatedButton(
            onPressed: controller.isLoading.value ? null : () => controller.saveProfile(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: AppColor.onPrimary,
              padding: EdgeInsets.symmetric(vertical: 15.h), // Use .h
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ), // Use .r
              elevation: 5,
            ),
            child: controller.isLoading.value
                ? const CircularProgressIndicator(color: AppColor.onPrimary)
                : Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ), // Use .sp
                  ),
          ),
        ),
      ],
    );
  }
}
