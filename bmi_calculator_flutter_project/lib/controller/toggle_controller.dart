import 'package:get/get.dart';

class ToggleController extends GetxController {
  var switchValue = false.obs;
  var classificationUnit = 'WHO'.obs;
  RxString heightDropdownValue = 'ft'.obs;
  RxString weightDropdownValue = 'kg'.obs;

  void toggleHeightUnit(String value) {
    heightDropdownValue.value = value;
    update();
  }

  void toggleWeightUnit(String value) {
    weightDropdownValue.value = value;
    update();
  }

  void toggleClassificationUnit(String value) {
    classificationUnit.value = value;
    update();
  }

  void toggleSwitch(bool value) {
    switchValue.value = value;
    update();
  }
}
