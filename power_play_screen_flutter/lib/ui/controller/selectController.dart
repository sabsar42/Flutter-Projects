import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pair {
  int first;
  bool second;

  Pair(this.first, this.second);
}

class SelectController extends GetxController {
  List<Pair> selectedItems = [];

  SelectController() {
    for (int i = 0; i < 20; i++) {
      selectedItems.add(Pair(0, false));
    }
  }

  void updateValue(int index, int value) {
    if (selectedItems[index].second == false) {
      selectedItems[index].first = value;
      selectedItems[index].second = true;
      update();
    } else if (selectedItems[index].second == true) {
      selectedItems[index].second= false;
      selectedItems[index].first = 0;
      update();
    }
  }
}
