import 'package:get/get.dart';

class SwitchController extends GetxController {
  var switchValue = false.obs;
  var classificationUnit = 'WHO'.obs;
  void toggleClassificationUnit(String value) {
    classificationUnit.value = value;
    update();
  }
  void toggleSwitch(bool value) {
    switchValue.value = value;
    update();
  }
}
