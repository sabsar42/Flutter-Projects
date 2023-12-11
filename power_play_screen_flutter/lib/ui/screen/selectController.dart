import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectController extends GetxController {
  Map<int, List<bool>> selectedItems = {};

  SelectController() {
    for (int i = 1; i <= 3; i++) {
      selectedItems[i] = List.generate(20, (index) => false);
    }
  }

  void updateValue(int mIndex, int index) {
    if (selectedItems[mIndex]?[index] == false) {
      selectedItems[mIndex]?[index] = true;
      update();
    } else if (selectedItems[mIndex]?[index] == true) {
      selectedItems[mIndex]?[index] = false;
      update();
    }
  }
}
