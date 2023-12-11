import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:power_play_screen_flutter/ui/controller/selectController.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final int sec = 20;
  final fixedColor = Color.fromRGBO(8, 8, 45, 1.0);
  SelectController selectController = Get.put(SelectController());
  final grayColor = Color.fromRGBO(70, 83, 91, 1.0);
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
                controller.updateValue(index,sec+index);
              },
              child: Container(
                color:
                controller.selectedItems[index].second == false
                    ? fixedColor
                    : (controller.selectedItems[index].second &&
                    controller.selectedItems[index].first == sec + index)
                    ? Colors.red
                    : grayColor,
                child: Center(
                  child: Text('${index+1}'),
                ),
              ),
            );
          });
        },
      ),
    );
  }


}

