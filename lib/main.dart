import 'package:delivery_agent/app/modules/agent_dashboard/controllers/agent_dashboard_controller.dart';
import 'package:delivery_agent/app/modules/delivery_agent_profile/controllers/delivery_agent_profile_controller.dart';
import 'package:delivery_agent/app/modules/end_of_day/controllers/end_of_day_controller.dart';
import 'package:delivery_agent/app/modules/order/controllers/order_controller.dart';
import 'package:delivery_agent/app/modules/payment_page/controllers/payment_page_controller.dart';
import 'package:delivery_agent/app/modules/store_assign/controllers/store_assign_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'app/Services/record_sale_product_api.dart';
import 'app/Services/sign_up_api_services.dart';
import 'app/modules/day_complete/controllers/day_complete_controller.dart';
import 'app/modules/login_process/controllers/onboaeding_controller.dart';
import 'app/modules/record_sales/controllers/record_sales_controller.dart';
import 'app/modules/store_list/controllers/store_list_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  // FlutterEngineGroup().useImpeller = false;
  Get.put(ApiProvider());
  Get.put(RecordSalesController());
  Get.put(OrderController());
  Get.put(StoreAssignController());
  Get.put(StoreListController());
  Get.put(OnboardingController());
  Get.put(EndOfDayController());
  Get.put(DayCompleteController());
  Get.put(PaymentPageController());
  Get.put(AuthService());
  Get.put(AgentDashboardController());
  Get.put(DeliveryAgentProfileController());

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
