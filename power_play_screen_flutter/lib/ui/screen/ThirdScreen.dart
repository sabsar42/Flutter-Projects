import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_play_screen_flutter/ui/controller/selectController.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final int thi = 30;
  final grayColor = Color.fromRGBO(70, 83, 91, 1.0);
  final fixedColor = Color.fromRGBO(8, 8, 45, 1.0);

  SelectController selectController = Get.put(SelectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GetBuilder<SelectController>(builder: (controller) {
            return GestureDetector(
              onTap: () {
                controller.updateValue(index, thi + index);
              },
              child: Container(
                color:
                controller.selectedItems[index].second == false
                    ? fixedColor
                    : (controller.selectedItems[index].second &&
                    controller.selectedItems[index].first == thi + index)
                    ? Colors.red
                    : grayColor,
                child: Center(
                  child: Text('${index + 1}'),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
