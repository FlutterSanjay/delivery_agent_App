import 'package:delivery_agent/app/AppColor/appColor.dart';
import 'package:delivery_agent/app/Features/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../login_process/views/onboaeding_view.dart';
import '../controllers/store_list_controller.dart';

class StoreListView extends GetView<StoreListController> {
  const StoreListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGreyBackground,
      body: Obx(
        () => controller.isLoading.value
            ? AppLoader()
            : SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Obx(
                        () => CommonText(
                          txtName:
                              "Hello ${controller.userName.value.split(" ")[0]}, \nWelcome!!",
                          txtColor: AppColor.darkBackground,
                          fontWeight: FontWeight.w400,
                          fontSize: 36.sp,
                          txtheight: 1.0.sp,
                        ),
                      ),
                    ),
                    storeListCard(
                      Get.width * 0.75,
                      Get.width * 0.16,
                      Get.height * 0.04,
                      Get.height * 0.03,
                      "₹ ${controller.totalSalePrice}",
                      "Total Sales",
                    ),
                    storeListCard(
                      Get.width * 0.75,
                      Get.width * 0.16,
                      Get.height * 0.001,
                      Get.height * 0.03,
                      "${controller.licensePlate}",
                      "Vehicle Assigned",
                    ),

                    storeListIconCard(
                      Get.width * 0.75,
                      Get.width * 0.16,
                      Get.height * 0.001,
                      Get.height * 0.03,
                      "${controller.routeName} (${controller.totalStoreAssign} Stores)",
                      "Vehicle Assigned",
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.isCheck.value,
                            onChanged: (value) {
                              controller.isCheck.value = value!;
                            },
                            activeColor: AppColor.primary,
                          ),
                        ),
                        CommonText(
                          txtName: "I agree to all the above data shown.",
                          txtColor: AppColor.onSecondary,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                      ],
                    ),

                    login_otp_btn(controller, "Start Trip"),
                  ],
                ),
              ),
      ),
    );
  }

  Container storeListCard(
    double width,
    double height,
    double topMargin,
    double bottomMargin,
    String txtName,
    String secondTxt,
  ) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,

      margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
        color: AppColor.onPrimary,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        children: [
          CommonText(
            txtName: txtName,
            txtColor: AppColor.onSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 22.sp,
          ),
          CommonText(
            txtName: secondTxt,
            txtColor: AppColor.onSecondary,
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }

  Container storeListIconCard(
    double width,
    double height,
    double topMargin,
    double bottomMargin,
    String txtName,
    String secondTxt,
  ) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,

      padding: EdgeInsets.only(left: 25.w),
      margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
        color: AppColor.onPrimary,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.w,
            children: [
              Icon(Icons.store_rounded, color: AppColor.h5Color),
              CommonText(
                txtName: txtName,
                txtColor: AppColor.onSecondary,
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.w,
            children: [
              Icon(Icons.card_travel, color: AppColor.h5Color),
              CommonText(
                txtName: secondTxt,
                txtColor: AppColor.onSecondary,
                fontWeight: FontWeight.w400,
                fontSize: 13.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container login_otp_btn(StoreListController controller, String btnName) {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.06),
      width: Get.width * 0.5,
      height: Get.height * 0.065,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
        onPressed: controller.checkAgreement,

        child: CommonText(
          txtName: btnName,
          txtColor: AppColor.onPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
