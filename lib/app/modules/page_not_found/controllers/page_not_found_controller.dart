import 'package:get/get.dart';

class PageNotFoundController extends GetxController {
  var showErrorText = false.obs; // Controls '404' text animation
  var showDetails = false.obs; // Controls details text and button animation

  @override
  void onInit() {
    super.onInit();
    // Trigger '404' text animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      showErrorText.value = true;
    });
    // Trigger details text and button animation after '404' animation starts
    Future.delayed(const Duration(milliseconds: 1000), () {
      showDetails.value = true;
    });
  }

  void goHome() {
    Get.offAllNamed('/home'); // Or whatever your home route is
  }
}
