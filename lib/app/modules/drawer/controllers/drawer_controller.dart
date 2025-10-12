import 'package:delivery_agent/app/Services/GetStorageService/getStorageService.dart';
import 'package:delivery_agent/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DrawerBarController extends GetxController {
  final storage = StorageService();
  var darkMode = false.obs;
  var productsExpanded = false.obs;
  RxString userName = "...".obs;
  @override
  void onInit() {
    userName.value = storage.getUserName() ?? "";
    super.onInit();
  }

  /// currently selected menu item
  var selectedMenu = "".obs;

  /// Change menu & navigate

  final Map<String, String> menuRoutes = {
    "Profile": Routes.DELIVERY_AGENT_PROFILE,
    "Orders": Routes.ORDER,
    "Reports": Routes.REPORT_PAGE,
    "Notifications": "/notifications",
    "Settings": "/settings",
    "Help & Support": Routes.HELP_SUPPORT,
  };

  void selectMenu(String menu) {
    selectedMenu.value = menu;

    if (menuRoutes.containsKey(menu)) {
      Get.back(); // drawer close
      selectedMenu.value = "";
      Get.toNamed(menuRoutes[menu]!);
    } else {
      Get.back(); // just close drawer
    }
  }

  // void selectMenu(String menu) {
  //   selectedMenu.value = menu;

  //   switch (menu) {
  //     case "Profile":
  //       Get.toNamed(Routes.DELIVERY_AGENT_PROFILE);
  //       // print("Profile");
  //       break;
  //     case "Orders":
  //       Get.toNamed(Routes.ORDER);
  //       // print("Orders");
  //       break;
  //     case "Reports":
  //       // Get.toNamed("/reports");
  //       print("Reports");
  //       break;
  //     case "Notifications":
  //       // Get.toNamed("/notifications");
  //       print("Notification");
  //       break;
  //     case "Settings":
  //       // Get.toNamed("/settings");
  //       print("Settings");
  //       break;
  //     case "Help & Support":
  //       // Get.toNamed("/help");
  //       print("Help & Support");
  //       break;
  //     default:
  //       break;
  //   }
  // }

  Future<void> logoutUser() async {
    try {
      // Clear local storage
      await storage.clearUserToken();

      // Navigate to login screen
      Get.offAllNamed(Routes.ONBOAEDING);

      print("User Logged out Successfully!");
    } catch (e) {
      print("User Logout Issue Occurred! $e");
      Get.snackbar("Error", "Something Went Wrong!");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
