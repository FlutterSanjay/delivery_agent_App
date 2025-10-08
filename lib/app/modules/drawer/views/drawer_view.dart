import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/drawer_controller.dart';

class DrawerBarView extends GetView<DrawerBarController> {
  const DrawerBarView({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Get.isDarkMode ? const Color(0xFF23170F) : Colors.white,
        child: Column(
          children: [
            // Header Section
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.black : Colors.white,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://th.bing.com/th/id/OIP.UidYXknATm9TVaVDAEDm6AHaE8?w=261&h=180&c=7&r=0&o=7&pid=1.7&rm=3",
                    fit: BoxFit.cover,
                    width: 80.w,
                    height: 80.h,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator(value: progress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),

              accountName: Text(
                "Delivery Agent",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              accountEmail: Obx(
                () => Text(
                  controller.userName.value,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(Icons.person, "Profile"),
                  _buildMenuItem(Icons.shopping_bag, "Orders", badge: "12"),

                  // Expandable Products
                  Obx(
                    () => ExpansionTile(
                      initiallyExpanded: controller.productsExpanded.value,
                      onExpansionChanged: (value) =>
                          controller.productsExpanded.value = value,
                      leading: const Icon(Icons.storefront),
                      title: const Text("Products / Inventory"),
                      children: [
                        _buildSubMenuItem("All Products"),
                        _buildSubMenuItem("Add Product"),
                      ],
                    ),
                  ),

                  _buildMenuItem(Icons.bar_chart, "Reports"),
                  _buildMenuItem(
                    Icons.notifications,
                    "Notifications",
                    dot: true,
                  ),
                  _buildMenuItem(Icons.settings, "Settings"),
                  _buildMenuItem(Icons.help_outline, "Help & Support"),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
              child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.red, size: 20.sp),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      controller.logoutUser();
                },
              ),
            ),
         
          ],
        ),
      )
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    String? badge,
    bool dot = false,
  }) {
    return Obx(() {
      bool isActive = controller.selectedMenu.value == title;
      return ListTile(
        leading: Icon(
          icon,
          color: isActive ? const Color(0xFFFF6A00) : Colors.grey.shade700,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFFFF6A00) : Colors.grey.shade700,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6A00),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  badge,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              )
            : dot
            ? CircleAvatar(radius: 4.r, backgroundColor: Colors.red)
            : null,
        onTap: () {
          controller.selectMenu(title);
        },
      );
    });
  }

  Widget _buildSubMenuItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
      ),
      onTap: () {},
    );
  }
}
