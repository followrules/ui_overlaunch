import 'package:get/get.dart';
import 'package:overlaunch/controller/auth_controller.dart';
import 'package:overlaunch/controller/home_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
