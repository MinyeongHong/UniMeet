import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }

  // static additionalBinding() {
  //   Get.put(MypageController(), permanent: true);
  // }
}