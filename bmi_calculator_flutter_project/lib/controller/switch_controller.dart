import 'package:get/get.dart';

class SwitchController extends GetxController {
  var switchValue = false.obs;

  void toggleSwitch(bool value) {

    switchValue.value = value;
    update();
  }
}
