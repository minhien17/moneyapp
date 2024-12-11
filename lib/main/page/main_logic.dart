import 'package:get/get.dart';

class MainLogic extends GetxController {
  int index = 0;

  @override
  void onInit() {
    super.onInit();

    // var args = Get.arguments;
    // if (args != null) {
    //   index = Get.arguments['indexPage'];
    //   print(index);
    // } else {
    //   print("No arguments passed.");
    // }
    // if (Get.arguments != null) print(Get.arguments['indexPage']);
    // index = Get.arguments['indexPage'];
  }

  void setIndex(int index) {
    this.index = index;
    update();
  }
}
