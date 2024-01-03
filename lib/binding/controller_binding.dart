import 'package:fbsocial/controller/login_controller.dart';
import 'package:get/get.dart';

class MyControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      LoginController(),
    );
  }
}
