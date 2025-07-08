import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../imagePath/imagePath.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.navigatedToOnBoardScreen(context);
    return Scaffold(body: Center(child: Image.asset(ImagePath.logo)));
  }
}
