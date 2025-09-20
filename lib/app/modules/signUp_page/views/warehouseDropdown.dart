import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/modules/login_process/views/onboaeding_view.dart';
import 'package:delivery_agent/app/modules/signUp_page/controllers/sign_up_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/model/warehouseModel/warehouseModel.dart';

class WarehouseDropdown extends StatelessWidget {
  final SignUpPageController controller;
  const WarehouseDropdown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingWarehouse.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.warehouses.isEmpty) {
        return const Text("No warehouses available");
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            txtName: "Select Warehouse *",
            txtColor: AppColor.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
          ),
          SizedBox(height: 10.h),
          CustomDropdown<Warehouse>.search(
            decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: AppColor.grey, width: 1.sp),
              closedBorderRadius: BorderRadius.circular(30.r),
              closedFillColor: Colors.transparent,
              hintStyle: TextStyle(color: Color(0xff1c1c1c), fontSize: 14.sp),
            ),
            hintText: 'Select Warehouse',
            items: controller.warehouses,
            excludeSelected: false,
            onChanged: (value) {
              if (value != null) {
                controller.selectWarehouse(value);
                print("Selected warehouse: ${value.name}, ID: ${value.id}");
              }
            },
          ),
        ],
      );
    });
  }
}
